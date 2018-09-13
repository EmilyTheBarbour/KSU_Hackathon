/******************************************************************************
 * How to use this module
 *
 * Calling code needs to import this module:
 *
 *      IMPORT Files;
 *
 * Make sure you assign a value to Files.MY_NAME, below.  This value
 * will become the prefix of all files you will create on the cluster.
 *
 * To create a full pathname for a file you will create (as for OUTPUT) given a
 * STRING path:
 *
 *      myFullPath := Files.FullPath(path);
 *
 * To access one of the datasets, just reference the 'file' attribute within
 * the appropriate submodule.  Example:
 *
 *      theData := Files.MerchantData.file;
 ******************************************************************************/
EXPORT Files := MODULE
    // Change this value to your name (recommend first initial + full last name)
    SHARED MY_NAME := 'H12';
    SHARED MY_FILE_SCOPE := IF(MY_NAME != '', '~' + MY_NAME, ERROR(-1, 'You need to set Files.MY_NAME to your name or initials'));
    //--------------------------------------------------------------------------
    // Call this function to create a full path for a file that you will create.
    // The argument is a portion of the path; this function merely adds a
    // prefix in the correct format and returns the result.
    EXPORT FullPath(STRING path) := MY_FILE_SCOPE + '::' + TRIM(path, LEFT, RIGHT);
    //--------------------------------------------------------------------------
    EXPORT MerchantData := MODULE
        EXPORT PATH := '~dataseers::merchant_data';
        EXPORT RecordDef := RECORD
            DECIMAL18_5     transaction_amount;
            STRING10        pos_indicator;
            STRING20        merchant_ref_num;
            STRING30        merchant_number;
            STRING50        merchant_name;
            STRING100       merchant_address;
            STRING50        merchant_city;
            STRING2         merchant_state;
            STRING3         merchant_country_code;
            STRING35        merchant_country;
            STRING10        merchant_zip;
            STRING4         merchant_category_code;
            STRING225       merchant_category;
            STRING6         terminal_fiid;
            STRING16        terminal_identifier;
        END;
        EXPORT File := DATASET(PATH, RecordDef, FLAT);
    END;
    //--------------------------------------------------------------------------
    // EXPORT Customers := MODULE
    //     EXPORT PATH := '~dataseers::customers';
    //     EXPORT RecordDef := RECORD
    //         STRING50        first_name;
    //         STRING50        last_name;
    //         STRING75        address;
    //         STRING50        city;
    //         STRING30        state;
    //         STRING6         zip;
    //         STRING20        country;
    //     END;
    //     EXPORT File := DATASET(PATH, RecordDef, FLAT);
    // END;
    // //--------------------------------------------------------------------------
    // EXPORT OFACMaster := MODULE
    //     EXPORT PATH := '~dataseers::ofac_master';
    //     // Additional information on this data can be found at:
    //     //      https://www.treasury.gov/resource-center/sanctions/SDN-List/Pages/sdn_data.aspx
    //     //      https://www.treasury.gov/resource-center/faqs/Sanctions/Pages/faq_compliance.aspx#5
    //     //      https://www.treasury.gov/resource-center/sanctions/SDN-List/Documents/dat_spec.txt
    //     EXPORT RecordDef := RECORD
    //         UNSIGNED4       ent_num;            // unique record identifier/unique listing identifier
    //         STRING350       sdn_name;           // special designated nationals
    //         STRING12        sdn_type;           // individual or business
    //         STRING50        program;            // sanctions program name
    //         STRING200       title;              // title of an individual
    //         STRING8         call_sign;          // vessel call sign
    //         STRING25        vess_type;          // vessel type
    //         STRING14        tonnage;            // vessel tonnage
    //         STRING8         grt;                // gross registered tonnage
    //         STRING40        vess_flag;          // vessel flag
    //         STRING150       vess_owner;         // vessel owner name
    //         STRING1000      remarks;            // remarks on SDN
    //         UNSIGNED4       ent_num_add;
    //         UNSIGNED4       add_num;
    //         STRING750       address;            // street address of SDN
    //         STRING116       city_state_zip;     // city, state/province, zip/postal code pf SDN
    //         STRING250       country;            // country of address
    //         STRING200       add_remarks;        // remarks on address
    //         UNSIGNED4       ent_num_alt;
    //         UNSIGNED4       alt_num;
    //         STRING8         alt_type;           // type of alternate identity
    //         STRING350       alt_name;           // alternate identity name
    //         STRING200       alt_remarks;        // remarks on alternate identity
    //         UNSIGNED4       ent_num_sdncmt;
    //         STRING          remarks_extended;
    //     END;
    //     EXPORT File := DATASET(PATH, RecordDef, FLAT);
    // END;
END;