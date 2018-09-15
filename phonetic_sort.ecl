IMPORT KSU_Hackathon;
IMPORT DataPatterns;
IMPORT STD;
IMPORT Mast.ML.Docs;
IMPORT Docs.Tokenize AS Types;
IMPORT Std.Str AS Str;


OUTPUT(KSU_Hackathon.Files.MerchantData.File, NAMED('MerchantData'));


names := Record
	 String merch_names := KSU_Hackathon.Files.MerchantData.File.merchant_name;
END;
tbl := table(KSU_Hackathon.Files.MerchantData.File, names);

//changed regex to include whitespaces

names replace(names N) := Transform	
	SELF.merch_names := REGEXREPLACE('[^a-zA-Z[:space:]]', STD.Str.ToUpperCase(N.merch_names),'');	
	// SELF := N; this is a short cut for multiple labels not affected by transform
END;
result := Project(tbl, replace(LEFT));
Output(result, NAMED('name'));

first_edit := result;
		
//removes single values

first_edit single_replace(first_edit F) := Transform
	SELF.merch_names := REGEXREPLACE('(^| ).( |$)', F.merch_names,'');
END;
resultONE := Project(first_edit, single_replace(LEFT));
Output(resultONE, NAMED('editONE'));

second_edit := resultONE;

//Removes Whitespaces any other preprocessing should be done befor this

second_edit normal(second_edit S) := Transform
	SELF.merch_names := TRIM(S.merch_names, LEFT);
END;
resultTwo := Project(second_edit, normal(LEFT));
Output(resultTwo, NAMED('editTWO'));

unsorted_results := resultTwo;

result_sorted := SORT(unsorted_results, RECORD, STABLE):
		PERSIST('unique_sorted', SINGLE); //result_sorted
uniqueresult := DEDUP(result_sorted,keep 1);
uniqueresult_nonull := uniqueresult(uniqueresult.merch_names > '');
Output(uniqueresult_nonull, NAMED('unique')); //sortNOTunique Unique

meta_input := uniqueresult_nonull;

metaphone_output := RECORD
	String source;
	String Meta1;
	String Meta2;
	String Meta_both;

END;

metaphone_output toPhonetic(meta_input M) := TRANSFORM
	SELF.source := M.merch_names;
  SELF.Meta1  := STD.Metaphone.Primary( M.merch_names ); 
  SELF.Meta2  := STD.Metaphone.Secondary( M.merch_names ); 
  SELF.Meta_both  := STD.Metaphone.Double( M.merch_names );
END;

phonetic_index := PROJECT(meta_input, toPhonetic(LEFT));

COUNT(phonetic_index);
COUNT(phonetic_index(Meta1 <> Meta2)); 

OUTPUT(phonetic_index); 
OUTPUT(phonetic_index(Meta1 <> Meta2));

  
metaphone_output Clean(DATASET(metaphone_output) r) := FUNCTION
	s := r.source;
	CleanForTokens(STRING s):=FUNCTION
		sRestrictChars:=' '+REGEXREPLACE('[^- A-Z0-9\']',Str.ToUpperCase(s),' ')+' ';
		sStripPunctEnds:=REGEXREPLACE('( -)|(- )|( \')|(\' )',sRestrictChars,' ');
		sRemoveNumberOnly:=REGEXREPLACE(' [-0-9\']+(?=[ ])',sStripPunctEnds,'');
		sRemoveSingleChars:=REGEXREPLACE(' [B-H,J-Z](?=[ ])',sRemoveNumberOnly,'');
		sCompressSpaces:=REGEXREPLACE('[ ]+',sRemoveSingleChars,' ');
		sNormalizePosessives:=REGEXREPLACE('\'S ',sCompressSpaces,' ');
		sSplitContraction01:=REGEXREPLACE('\'RE ',sNormalizePosessives,' ARE ');
		sSplitContraction02:=REGEXREPLACE('\'LL ',sSplitContraction01,' WILL ');
		sSplitContraction03:=REGEXREPLACE(' I\'M ',sSplitContraction02,' I AM ');
		RETURN sSplitContraction03;
	END;
	x := PROJECT(r,TRANSFORM(metaphone_output,SELF.source := CleanForTokens(LEFT.source), SELF := LEFT));
	RETURN x;
	
  END;



