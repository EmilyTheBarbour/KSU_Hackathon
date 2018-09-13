IMPORT KSU_Hackathon;
IMPORT DataPatterns;

rawMerchantData := KSU_Hackathon.Files.MerchantData.File;

OUTPUT(rawMerchantData, NAMED('rawMerchantDataSample'));

rawMerchantProfileResults := DataPatterns.Profile(rawMerchantData,
    features := 'fill_rate,cardinality,best_ecl_types,lengths,patterns,modes');

OUTPUT(rawMerchantProfileResults,,
    KSU_Hackathon.Files.MerchantData.merchant_data_patterns_raw_file_path, OVERWRITE);