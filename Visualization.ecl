IMPORT Visualizer;

R1 := RECORD
    STRING25 merchant_name;
    INTEGER4 x;
    INTEGER4 y;
END;

ds := DATASET([ {'', 5, 20},
                {'', 6, 15},
                {'', 11, 10},
                {'', 14, 18},
                {'', 11, 8},
                {'', 19, 2},
                {'', 15, 6},
                {'', 5, 12},
                {'', 14, 15},
                {'', 4, 7},
                {'', 1, 16},
                {'', 19, 3}],
                {R1});

        

OUTPUT(ds, NAMED('TestCoordinates'));

mappings :=  DATASET([  {'X Coordinate', 'X'}, 
                        {'Y Coordinate', 'Y'}], Visualizer.Visualizer.KeyValueDef);

//  Declare some "dermatology" properties
properties := DATASET([ {'xAxisGuideLines', 'false'}, 
                        {'yAxisGuideLines', 'false'} 
                        
                        ], Visualizer.Visualizer.KeyValueDef);

Visualizer.Visualizer.MultiD.Scatter('scatter', /*datasource*/, 'TestCoordinates', mappings, /*filteredBy*/, properties )