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

result_sorted := SORT(resultTwo, RECORD, STABLE);

uniqueresult := DEDUP(result_sorted,keep 1);
Output(uniqueresult, NAMED('Unique'));
