IMPORT STD;

EXPORT Files := MODULE
        EXPORT file_scope := '~training-samples';
        EXPORT project_scope := 'merchant';
        EXPORT in_files_scope := 'in';
        EXPORT out_files_scope := 'out';

        /*
            Location of raw file on the landing zone {Consider one months worth of trips for the initial test}
        */

        EXPORT merchant_lz_file_path := '/var/lib/HPCCSystems/mydropzone/yellow_tripdata_2015-01.csv';

        /*
            Raw file layout and dataset after it is imported into Thor
        */

        EXPORT merchant_raw_file_path := file_scope + '::' + project_scope + '::' + in_files_scope + '::yellow_tripdata.csv';

        EXPORT merchant_raw_layout := RECORD
            STRING merchant_number;
            STRING merchant_name;
            STRING merchant_category;
        END;

        EXPORT mrechant_raw_ds := DATASET(merchant_raw_file_path, merchant_raw_layout, CSV(HEADING(1)));

        /*
         
        EXPORT Data Profile report on the Raw File. Use the report output to understand your data 
        and validate the assumptions you would have made.

        */

        EXPORT merchant_data_patterns_raw_file_path := file_scope + '::' + 
             project_scope + '::' + out_files_scope +  '::yellow_tripdata_raw_data_patterns.thor';


        /*
            Cleaned file layout and dataset. The cleaned file is created after cleaning the 
            raw file.
        */
    
        EXPORT merchant_clean_file_path := file_scope + '::' + project_scope + '::' + out_files_scope + '::yellow_tripdata_clean.thor';
        
        EXPORT merchant_clean_layout := RECORD
            UNSIGNED1 merchant_number;
            STRING merchant_name;
            STRING merchant_category;
        END;

        EXPORT merchant_clean_ds := DATASET(merchant_clean_file_path, merchant_clean_layout, THOR);    

        /*
            The cleaned file is enriched to add important attributes
        */

        EXPORT merchant_enrich_file_path := file_scope + '::' + project_scope + '::' + out_files_scope +  '::yellow_tripdata_enriched.thor';
        
        EXPORT merchant_enrich_layout := RECORD
            merchant_clean_layout;
        END;

        EXPORT merchant_enrich_ds := DATASET(merchant_enrich_file_path, merchant_enrich_layout, THOR);    
   
        /* 
            Create a simple attribute file that records the counts of trips daily
        */
        EXPORT merchant_analyze_file_path := file_scope + '::' + project_scope + '::' + out_files_scope +  '::yellow_tripdata_analyze.thor';
        
        EXPORT merchant_analyze_layout := RECORD
            Std.Date.Date_t    pickup_date;
            UNSIGNED4 cnt;        
        END;

        EXPORT merchant_analyze_ds := DATASET(merchant_analyze_file_path, merchant_analyze_layout, THOR);    

        /*
            Create a training file to train a GLM for predecting trip counts for a future date
        */

        EXPORT merchant_train_file_path := file_scope + '::' + project_scope + '::' + out_files_scope +  '::yellow_tripdata_train.thor';

        EXPORT merchant_train_layout := RECORD
            unsigned2 pickup_year;
            unsigned2 pickup_month;
            unsigned2 pickup_day_of_month;
            unsigned2 pickup_day_of_week;
            unsigned4 cnt;
        END;

        EXPORT merchant_train_ds := DATASET(merchant_train_file_path, merchant_train_layout, THOR);    
 
        /* 
            Build the GLM model for predecting traffic
        */
        // EXPORT merchant_model_file_path := file_scope + '::merchant::out::yellow_tripdata_2015_model.thor';

        // EXPORT merchant_model_layout := RECORD

        // END;

        // EXPORT merchant_model_ds := DATASET(merchant_model_file_path, merchant_model_layout, THOR);    

        /*
           Export
        */ 

        EXPORT merchant_analysis_lz_file_path := '/var/lib/HPCCSystems/mydropzone/yellow_tripdata_analysis.csv';  
        EXPORT merchant_analyze_csv_file_path := file_scope + '::' + project_scope + '::' + out_files_scope +  '::yellow_tripdata_analyze.csv';
END;