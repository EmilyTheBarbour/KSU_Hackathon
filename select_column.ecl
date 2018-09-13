IMPORT KSU_Hackathon;
IMPORT DataPatterns;

OUTPUT(KSU_Hackathon.Files.MerchantData.File, NAMED('MerchantData'));

//below returns a search 
//merchantname := KSU_Hackathon.Files.MerchantData.File(merchant_name = 'ADIDAS ONLINE STORE ');

//creates a record with only the merchant names
names := Record
	varstring merch_names := KSU_Hackathon.Files.MerchantData.File.merchant_name;
End;

//table puts it in a format ecl can output
tbl := table(KSU_Hackathon.Files.MerchantData.File, names);

//unfinished regex to remove special characters, just to get it working.
filtered_tbl := regexreplace('/[^a-zA-Z ]/g', tbl,'');
Output(tbl, NAMED('names'));
