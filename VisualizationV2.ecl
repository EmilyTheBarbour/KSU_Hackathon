IMPORT KSU_Hackathon;
IMPORT STD;
IMPORT Visualizer.Visualizer;

r1 := RECORD
    STRING25 merchant_name := KSU_Hackathon.Files.MerchantData.File.merchant_name;
    REAL count := COUNT(GROUP, KSU_Hackathon.Files.MerchantData.File.merchant_name = 'DAIRY QUEEN #42455');
END;


tbl := TABLE(KSU_Hackathon.Files.MerchantData.File, r1);

OUTPUT(tbl, NAMED('Counts'));