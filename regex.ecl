IMPORT KSU_Hackathon;
IMPORT DataPatterns;
IMPORT STD;

OUTPUT(KSU_Hackathon.Files.MerchantData.File, NAMED('MerchantData'));


names := Record
	 String merch_names := KSU_Hackathon.Files.MerchantData.File.merchant_name;
End;
tbl := table(KSU_Hackathon.Files.MerchantData.File, names);


names replace(names N) := Transform	
	SELF.merch_names := REGEXREPLACE('[^a-zA-Z]', N.merch_names,'');
	SELF := N;
END;
result := Project(tbl, replace(LEFT));
Output(result, NAMED('name'));
