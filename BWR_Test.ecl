IMPORT KSU_Hackathon;
IMPORT DataPatterns;
// Output the first few records of the three data files
OUTPUT(KSU_Hackathon.Files.MerchantData.File, NAMED('MerchantData'));
OUTPUT(KSU_Hackathon.Files.Customers.File, NAMED('Customers'));
OUTPUT(KSU_Hackathon.Files.OFACMaster.File, NAMED('OFACMaster'));
// Find customers whose last name begins with 'C'
customerLastC := KSU_Hackathon.Files.Customers.File(last_name[1] = 'C');
// Create a new file with those 'C' last names
customerLastCPath := KSU_Hackathon.Files.FullPath('customer_last_names_start_with_c');
OUTPUT(customerLastC,,customerLastCPath,OVERWRITE,COMPRESSED);
// Sort the customer file and show the first few records
sortedCustomers := SORT(KSU_Hackathon.Files.Customers.File, last_name, first_name);
OUTPUT(sortedCustomers, NAMED('sortedCustomers'));
// Perform a simple data profiling against the customer data
customerProfile := DataPatterns.Profile
    (
        KSU_Hackathon.Files.Customers.File,
        features := 'fill_rate,cardinality,modes,lengths,patterns'
    );
OUTPUT(customerProfile, NAMED('customerProfile'), ALL);