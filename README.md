dataCleanRepo
=============

Module 2 : Getting and cleaning Data

How the Scrit works: run_analysis.R

Input Data Files: 

1. \dataCleanRepo\UCIDataset\activity_labels.txt
2. \dataCleanRepo\UCIDataset\test\subject_test.txt
3. \dataCleanRepo\UCIDataset\test\X_test.txt
4. \dataCleanRepo\UCIDataset\test\y_test.txt
5. \dataCleanRepo\UCIDataset\train\subject_test.txt
6. \dataCleanRepo\UCIDataset\train\X_test.txt
7. \dataCleanRepo\UCIDataset\train\y_test.txt
 
Processing: Follwoing are the steps the script follows - 

1. Combines all test data into one test dataframe
2. Combines all train data into one train daraframe
3. Merges test and train data 
4. Aggregates the merged data by activity and by Subject 
5. Derives the Mean of this aggregated data set 
6. Outputs the results to  tidy2.csv file 
7. 


Output: tidy2.csv
