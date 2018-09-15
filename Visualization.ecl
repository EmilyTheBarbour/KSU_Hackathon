IMPORT Visualizer.Visualizer;
IMPORT KSU_Hackathon;

R1 := RECORD
    UNSIGNED4 merchant_id;
    REAL x;
    REAL y;
END;

R2 := RECORD
    STRING25 merchant_name;
    REAL num_of_matches;
END;

R3 := RECORD
    STRING process;
    UNSIGNED4 time;
END;

ds := DATASET([ {1, 5, 20},
                {2, 6, 15},
                {3,11, 10},
                {4, 14, 18},
                {5, 11, 8},
                {6, 19, 2},
                {7, 15, 6},
                {8, 5, 12},
                {9, 14, 15},
                {10, 4, 7},
                {11, 1, 16},
                {12, 19, 3}],
                {R1});

ds2 := DATASET([{'walmart', 100},
                {'amazon', 57},
                {'kmart', 2},
                {'c', 1},
                {'a', 100},
                {'q', 57},
                {'frt', 2},
                {'ab', 100},
                {'qw', 57},
                {'fgrt', 2},
                {'abc', 100},
                {'qwe', 57},
                {'fghrt', 2},
                {'abcd', 100},
                {'qwer', 57},
                {'fghjrt', 2},
                {'abcde', 100},
                {'qwert', 57},
                {'fghjkrt', 2},
                {'abcdef', 100},
                {'qwerty', 57},
                {'fghjklrt', 2}
                ],
                {R2});

ds3 := DATASET([{'generating model', 15},
                {'Calculating', 50}],{R3});

OUTPUT(ds2, NAMED('testBubble'));
        

OUTPUT(ds, NAMED('TestCoordinates'));

OUTPUT(ds3, NAMED('testBar'));

mappings :=  DATASET([  {'X Coordinate', 'X'}, 
                        {'Y Coordinate', 'Y'}
                        ], Visualizer.KeyValueDef);

//  Declare some "dermatology" properties
properties := DATASET([ {'xAxisGuideLines', 'false'}, 
                        {'yAxisGuideLines', 'false'} 
                        
                        ], Visualizer.KeyValueDef);

Visualizer.TwoD.Bubble('bubble', /*datasource*/, 'testBubble', , /*filteredBy*/,  );
Visualizer.MultiD.Bar('bar', /*datasource*/, 'testBar', , /*filteredBy*/,  );
Visualizer.MultiD.Scatter('scatter', /*datasource*/, 'TestCoordinates', mappings, /*filteredBy*/, properties );