IMPORT KSU_Hackathon;
IMPORT STD;
IMPORT Visualizer.Visualizer;

clusterRecord := RECORD
    STRING25 cluster_name;
    INTEGER4 num;
END;

ds := DATASET([ {'WALLMART', 550},
                {'AMAZON', 530},
                {'BESTBUY', 527},
                {'TARGET', 478},
                {'CHUCKECHEESE', 400},
                {'ROUND1', 322},
                {'STARSANDSTRIKES', 300},
                {'SUPREME', 150},
                {'TOYSRUS', 100},
                {'KMART', 35},
                {'Spirit Solutions',500},
                {'Beedle Motors',250},
                {'Shrub Sports',175},
                {'Pixystems',356},
                {'Ceasarts',125},
                {'Bullimited',453},
                {'Dynamico',234},
                {'Deserthive',143},
                {'Jetwares',123},
                {'Spiderstone',156},
                {'Parable Systems',178},
                {'Soul Solutions',432},
                {'Lucent Softwares',213},
                {'Granitelligence',154},
                {'Crypticorps',111},
                {'Ogreprises',222},
                {'Mysticorps',333},
                {'Dreamdale',444},
                {'Stormdale',512},
                {'Owlspace',324},
                {'Whirlpool Electronics',123},
                {'Heart Navigations',324},
                {'Titanium Corporation',214},
                {'Diamontronics',513},
                {'Nightelligence',153},
                {'Antelligence',176},
                {'Signetworks',254},
                {'Lifesearch',165},
                {'Nymphhive',123},
                {'Pixyway',156},
                {'Gold Microsystems',256},
                {'Fire Softwares',154},
                {'North Star Media',254},
                {'Houndnavigations',241},
                {'Galerprises',111},
                {'Bumblebeelectrics',222},
                {'Lagoonavigations',333},
                {'Amazonwares',444},
                {'Oystermedia',512},
                {'Alphashadow',234},
                {'Tortoise Motors',354},
                {'Moonlight Technologies',231},
                {'Sprite Lighting',321},
                {'Vertexoftwards',341},
                {'Lucentertainment',152},
                {'Apexi',165},
                {'Alpire',185},
                {'Pixelways',123},
                {'Phantomnways',512},
                {'Beeshack',234},
                {'Great White Co.',431},
                {'Mermaid Corporation',153},
                {'Flower',125},
                {'Omegacoustics',128},
                {'Honeytelligence',111},
                {'Firetronics',222},
                {'Vortexecurity',333},
                {'Peachbooks',444},
                {'Griffincast',555},
                {'Wondersys',165}],
                {clusterRecord});


OUTPUT(ds);

dsSort := SORT(ds,-num, RECORD, STABLE);

OUTPUT(dsSort, NAMED('clusters'));

dsTop5 := DATASET([ dsSort[1],
                    dsSort[2],
                    dsSort[3],
                    dsSort[4],
                    dsSort[5],
                    dsSort[6],
                    dsSort[7],
                    dsSort[8],
                    dsSort[9],
                    dsSort[10]
                    ], {clusterRecord});


OUTPUT(dsTop5, NAMED('clustersTop5'));

mappingsBubble :=  DATASET([    {'Merchant Name', 'cluster_name'}, 
                                {'Occurences', 'num'}
                                ], Visualizer.KeyValueDef);

propertiesBubble := DATASET([   {'title', 'Merchant Clusters'},
                                {'palleteID', 'category10'},
                                {'gridRowSpan', '3'},
                                {'gridColSpan', '3'},
                                {'gridRow', '0'},
                                {'gridCol', '0'}
                                ], Visualizer.KeyValueDef);

mappingsPie := DATASET([        {'Merchant Name', 'cluster_name'},
                                {'Occurences', 'num'}], Visualizer.keyValueDef);

propertiesPie := DATASET([      {'title', 'Top 10 Merchants'},
                                {'palleteID', 'category10'},
                                {'gridRowSpan', '1'},
                                {'gridColSpan', '1'},
                                {'gridRow', '0'},
                                {'gridCol', '3'}
                                ], Visualizer.KeyValueDef);

Visualizer.TwoD.Bubble('Merchant_Clusters',,'clusters', mappingsBubble, ,propertiesBubble);
Visualizer.MultiD.Column('Top_10_Merchants',,'clustersTop5', mappingsPie, ,propertiesPie);