#OVERVIEW
The R script, run_analysis.R, reads data files and outputs a selection of the data as a data table.

The initial data has 561 measurements for 30 subjects and 6 activities with many rows for each subject and activity pair.

The final data table has 66 measurements for 30 subjects doing 6 activities with 1 averaged row for each subject and activity pair.


#SET UP
The 'UCI HAR Dataset' folder must be placed in the R working directory


#FILES AND DATA
Two groups of files are combined into one data set: 'test' and 'train'.
The 'test' files found in the 'test' folder contain 2947 observations.
The 'train' files found in the 'train' folder contain 7352 observations.

Each folder has three types of file for subjects, activities, and signals

##Subject files
*subject_test.txt
*subject_train.txt
##Activity files
*y_test.txt
*y_train.txt
##Signal files
*X_test.txt
*X_train.txt

##Key files
The feature.txt file contains the name of each signal column
The activity_labels.txt contains a map for activity id to activity name

#METHOD

Training and test data is read for subject, activity, and signal.

Training and test data is combined (with rbind()).

The feature names are used to label columns in signal.

Signal table is subset to only have mean() and std() feature columns

Activity numbers are replaced by activity names in activity data

Full data table is made by combining subjects, activity, and signal tables (using cbind())

Final table is calculated by aggregating the full data table and calculating the mean signal for each unique subject and activity.
