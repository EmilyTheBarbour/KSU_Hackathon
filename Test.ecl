// ** THIS WAS SIMPLY COPIED FROM http://wpc.423a.rhocdn.net/00423A/pdf/machinelearning.pdf
// All documentation on what each of these functions do is included.
//
//

IMPORT KSU_Hackathon;
IMPORT Mast.ML;

// id = counter of records, x is an entity, y is an entity
lMatrix:={UNSIGNED id;REAL x;REAL y;};

// Test dataset of
dEntityMatrix:=DATASET([
 {1,2.4639,7.8579},
 {2,0.5573,9.4681},
 {3,4.6054,8.4723},
 {4,1.24,7.3835},
 {5,7.8253,4.8205},
 {6,3.0965,3.4085},
 {7,8.8631,1.4446},
 {8,5.8085,9.1887},
 {9,1.3813,0.515},
 {10,2.7123,9.2429},
 {11,6.786,4.9368},
 {12,9.0227,5.8075},
 {13,8.55,0.074},
 {14,1.7074,3.9685},
 {15,5.7943,3.4692},
 {16,8.3931,8.5849},
 {17,4.7333,5.3947},
 {18,1.069,3.2497},
 {19,9.3669,7.7855},
 {20,2.3341,8.5196}
],lMatrix);
ML.ToField(dEntityMatrix,dEntities);

// Centroid dataset
dCentroidMatrix:=DATASET([
 {1,1,1},
 {2,2,2},
 {3,3,3},
 {4,4,4}
],lMatrix);
ML.ToField(dCentroidMatrix,dCentroids);

// Cluster entities based on centroids with a maximum number of iterations 
// set to 30% convergence
MyKMeans:=ML.Cluster.KMeans(dEntities,dCentroids,30,.3);

MyKMeans.AllResults;

MyKMeans.Convergence;

MyKMeans.Result(); // The final locations of the centroids
MyKMeans.Result(3); // The results of iteration 3

MyKMeans.Delta(3,5); // The distance every centroid travelled across each axis from iterations 3 to 5
MyKMeans.Delta(0); // The total distance the centroids travelled on each axis from the beginning to the end

MyKMeans.DistanceDelta(3,5); // The straight-line distance travelled by each centroid from iterations 3 to 5
MyKMeans.DistanceDelta(0); // The total straight-line distance each centroid travelled
MyKMeans.DistanceDelta(); // The distance traveled by each centroid during the last iteration.

MyKMeans.Allegiances(); // The table of allegiances after convergence
MyKMeans.Allegiance(10,5); // The centroid to which entity #10 is closest after iteration 5

// Passing sample dataset with a max of 4 iterations 
MyAggloN:=ML.Cluster.AggloN(dEntities,4);
MyAggloN.Dendrogram;
MyAggloN.Distances;