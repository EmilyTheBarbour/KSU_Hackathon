IMPORT DataPatterns;
IMPORT Merchant;

rawMerchantData := Merchant.Files.merchant_raw_ds;
OUTPUT(RawMerchantData, NAMED('rawMerchantDataSample'));

rawMerchantProfileResults := DataPatterns.Profile(rawMerchantData, 
    features := 'fill_rate,cardinality,best_ecl_types,lengths,patterns,modes');

OUTPUT(rawMerchantProfileResults,,
    Merchant.Files.merchant_data_patterns_raw_file_path, OVERWRITE);