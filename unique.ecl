IMPORT KSU_Hackathon;
IMPORT DataPatterns;
IMPORT STD;

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
	SELF.merch_names := TRIM(S.merch_names, ALL);
END;
resultTwo := Project(second_edit, normal(LEFT));
Output(resultTwo, NAMED('editTWO'));

unsorted_results := resultTwo;

result_sorted := SORT(unsorted_results, RECORD, STABLE):
		PERSIST('unique_sorted', SINGLE); //result_sorted
uniqueresult := DEDUP(result_sorted,keep 1);
uniqueresult_nonull := uniqueresult(uniqueresult.merch_names > '');
Output(uniqueresult_nonull, NAMED('unique')); //sortNOTunique Unique
