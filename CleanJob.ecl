IMPORT STD;
IMPORT Merchant;

Merchant.Files.merchant_clean_layout clean(Merchant.Files.merchant_raw_layout raw) := TRANSFORM
    SELF.merchant_id := raw.merchant_id;
    SELF.merchant_name := raw.merchant_name;
    SELF.merchant_category := raw.merchant_category;
END

cleaned := PROJECT(Merchant.Files.merchant_raw_ds, clean(LEFT));

OUTPUT(cleaned,,Merchant.Files.taxi_clean_file_path, THOR, COMPRESSED, OVERWRITE);