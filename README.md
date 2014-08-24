# README Documentation for run_analysis.R

## Functions

1. initialize() 
  1. Function creates and initializes global variables which will be used in the rest of the file. 
2. download()
  1. Function creates a directory called data if needed.
  2. Downloads the zip file containing the data.
  3. Unzips the file. 
3. read_in_metadata()
  1. Function reads in feature.txt file which contains the names of all the columns within the dataset.
  2. Function reads in activity_labels.txt which provides the means to connect activity ID numbers with descriptive activity names. 
  3. Data from these files are stored in variables activity_metadata and column_metadata. 
  4. Function also searches the column names from features.txt to see which columns have the string -mean() and -std(). These are the only columns which will be used for the data cleaning. 
4. read_in_data()
  1. Function reads 