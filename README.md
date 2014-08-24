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
  4. check_record(str) searches the column names from features.txt to see which columns have the string -mean() and -std(). These are the only columns which will be used for the data cleaning. 
4. read_in_data()
  1. Function reads in the dataset from the X, subject and y files within the train and test folders.
  2. Data is stored in the main_result data frame which hold 66 columns of mean and standard deviation data as well as two columns for subject and activity IDs.
  3. conv_activity(id) converts the activity number IDs into readable activity labels. 
5. process_data()
  1. Function processes main_result data frame to find the averages for the 66 columns containing the mean and standard deviations.
  2. Function accomplishes this by using a for loop to step through the subject IDs and then using a nested for loop to step through the activity IDs.
  3. We subselect the data frame based on subject then activity ID and calculate the average for the 66 data columns.
  4. We store the averages of the 66 columns as well as the subject and actiivty ID used to subselect the data in the tidy_set data frame. 
5. Main function
  1. Runs the above functions in this order then prints to file the tidy_set data frame in a  space delimited file called tidy_data_set.txt with a header specifying column names. Prints to file all the column names in file named column_names.txt.