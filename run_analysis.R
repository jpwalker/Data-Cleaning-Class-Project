initialize <- function() {
    main_dir <<- getwd() ## Starting directory where the code was started and 
                        ## where output will be saved
    data_dir <<- file.path(main_dir, "data") ## Temporary directory storing 
                                            ## the data
    data_filename <<- file.path(data_dir, "data.zip") ## Downloaded filepath
    ## Download URL
    link <<- paste("https://d396qusza40orc.cloudfront.net/", 
                 "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", sep = "")
    ## Unzipped folder containing data
    main_unzip_dir <<- file.path(data_dir, "UCI HAR Dataset")
    ## Folder paths containing data
    folders <<- list(c(file.path(main_unzip_dir, "test"), "_test"),
                  c(file.path(main_unzip_dir, "train"), "_train"))
    ## Tidy_dataset output filename
    output_filename <<- file.path(main_dir, "tidy_data_set.txt")
     ## File containing column names
    output_col_filename <<- file.path(main_dir, "column_names.txt")
}

download <- function() {
    if (!file.exists(data_dir)) {
        dir.create(data_dir)
    }
    if (!file.exists(data_filename)) {
        download.file(link, data_filename, method = "curl")
        unzip(data_filename, exdir = data_dir)
    }
}

read_in_metadata <- function() {
    ## Function returns true if string contains -mean() or -std()
    check_record <- function(str) {
        ## Search for -mean() in string
        logic1 <- length(grep("-mean()", str, fixed = TRUE, value = TRUE)) != 0
        ## Search for -std() in string
        logic2 <- length(grep("-std()", str, fixed = TRUE, value = TRUE)) != 0
        return(logic1 | logic2)
    }
    
    fname <- file.path(main_unzip_dir, "activity_labels.txt")
    ## Activity metadata from activity_labels.txt
    activity_metadata <<- read.delim(fname, header = FALSE, 
                                     sep = " ", col.names = 
                                         c("activity_id", "activity_name"))
    fname <- file.path(main_unzip_dir, "features.txt")
    ## Column metadata from features.txt
    column_metadata <<- read.delim(fname, header = FALSE, sep = " ", 
                                   col.names = c("col_id", "col_name"))
    ## This determines if the column will be used in the new dataset
    column_metadata$record <<- sapply(column_metadata$col_name, check_record)
}

read_in_data <- function() {
    conv_activity <- function(id) {
        activity_metadata$activity_name[activity_metadata$activity_id == id]
    }
    
    for (i in folders) {
        w_dir <- i[1]; postfix <- i[2]
        ## Read in large dataset with all columns included
        f_name <- file.path(w_dir, paste("X", postfix, ".txt", sep = ""))
        main_dataset <- read.delim(f_name, header = FALSE, sep = "", 
                               col.names = column_metadata$col_name, 
                               colClasses = "numeric")
        main_dataset <- main_dataset[column_metadata$record]
        ## Read in the subject data from subject file
        f_name <- file.path(w_dir, paste("subject", postfix, ".txt", sep = ""))
        subject_dataset <- read.delim(f_name, header = FALSE, sep = "",
                                   col.names = "subject.id", 
                                   colClasses = "integer")
        main_dataset["subject.id"] <- subject_dataset$subject.id
        ## Read in the activity data from y file
        f_name <- file.path(w_dir, paste("y", postfix, ".txt", sep = ""))
        activity_dataset <- read.delim(f_name, header = FALSE, sep = "",
                                   col.names = "activity", 
                                   colClasses = "integer")
        activity_dataset["activity_name"] <- sapply(activity_dataset$activity, 
                                                conv_activity)
        main_dataset["activity"] <- activity_dataset$activity_name
        if (i[1] == folders[[1]][1]) {
            main_result <<- main_dataset
        }
        else
        {
            main_result <<- merge(main_result, main_dataset, all = TRUE)
        }
    }
}

## Creates a data frame to store the cleaned data.
## Step through each subject id then activity id and obtains the averages 
process_data <- function() {
    tidy_set <<- data.frame()
    tidy_activities <- character()
    subjects <- factor(main_result$subject.id)
    activities <- factor(main_result$activity)
    activity_levels <- levels(activities)
    subject_levels <- levels(subjects)
    measures <- column_metadata$col_name[column_metadata$record]
    for (id in subject_levels) {
        tempdata_id <- main_result[main_result$subject.id == id,]
        for (act in activity_levels) {
            tempdata <- tempdata_id[tempdata_id$activity == act,]
            newrow <- list()
            if (length(tempdata$subject.id) != 0) {
                for (measure in 1:length(measures)) {
                    average <- mean(tempdata[,measure], na.rm = TRUE)
                    newrow <- c(newrow, average)
                }
                newrow <- c(newrow, as.integer(id))
                tidy_activities <- c(tidy_activities, act)
                tidy_set <<- rbind(tidy_set, newrow)
            } 
        }
    }
    tidy_set <<- cbind(tidy_set, tidy_activities)
    names(tidy_set) <<- c("tBodyAcc.mean.X", "tBodyAcc.mean.Y", 
                          "tBodyAcc.mean.Z", "tBodyAcc.std.X", "tBodyAcc.std.Y", "tBodyAcc.std.Z", 
                          "tGravityAcc.mean.X", "tGravityAcc.mean.Y", "tGravityAcc.mean.Z", 
                          "tGravityAcc.std.X", "tGravityAcc.std.Y", "tGravityAcc.std.Z", 
                          "tBodyAccJerk.mean.X", "tBodyAccJerk.mean.Y", "tBodyAccJerk.mean.Z", 
                          "tBodyAccJerk.std.X", "tBodyAccJerk.std.Y", "tBodyAccJerk.std.Z", 
                          "tBodyGyro.mean.X", "tBodyGyro.mean.Y", "tBodyGyro.mean.Z", "tBodyGyro.std.X", 
                          "tBodyGyro.std.Y", "tBodyGyro.std.Z", "tBodyGyroJerk.mean.X", 
                          "tBodyGyroJerk.mean.Y", "tBodyGyroJerk.mean.Z", "tBodyGyroJerk.std.X", 
                          "tBodyGyroJerk.std.Y", "tBodyGyroJerk.std.Z", "tBodyAccMag.mean", 
                          "tBodyAccMag.std", "tGravityAccMag.mean", "tGravityAccMag.std", 
                          "tBodyAccJerkMag.mean", "tBodyAccJerkMag.std", "tBodyGyroMag.mean", 
                          "tBodyGyroMag.std", "tBodyGyroJerkMag.mean", "tBodyGyroJerkMag.std", 
                          "fBodyAcc.mean.X", "fBodyAcc.mean.Y", "fBodyAcc.mean.Z", "fBodyAcc.std.X", 
                          "fBodyAcc.std.Y",  "fBodyAcc.std.Z", "fBodyAccJerk.mean.X", 
                          "fBodyAccJerk.mean.Y", "fBodyAccJerk.mean.Z", "fBodyAccJerk.std.X", 
                          "fBodyAccJerk.std.Y", "fBodyAccJerk.std.Z", "fBodyGyro.mean.X", 
                          "fBodyGyro.mean.Y", "fBodyGyro.mean.Z", "fBodyGyro.std.X", "fBodyGyro.std.Y", 
                          "fBodyGyro.std.Z", "fBodyAccMag.mean", "fBodyAccMag.std", 
                          "fBodyBodyAccJerkMag.mean", "fBodyBodyAccJerkMag.std", "fBodyBodyGyroMag.mean", 
                          "fBodyBodyGyroMag.std", "fBodyBodyGyroJerkMag.mean", "fBodyBodyGyroJerkMag.std",
                          "subject.id", "activity")
}

## Data Ceaning Script 
initialize()
download()
read_in_metadata()
read_in_data()
process_data()
write.table(tidy_set, file = output_filename, row.names = FALSE, quote = FALSE)
write.table(names(tidy_set), file = output_col_filename, col.names = FALSE,
            row.names = FALSE, quote = FALSE)