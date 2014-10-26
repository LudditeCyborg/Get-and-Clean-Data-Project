# Must set working directory to 
#this script's location

# Merge training and test data to create
#one data set.

    ## Read all the test and training data
    ###subject files are a column of subject IDs
    test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
    train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
    ###activity files are a column of activity IDs
    test_activ <- read.table("UCI HAR Dataset/test/y_test.txt", colClasses="factor")
    train_activ <- read.table("UCI HAR Dataset/train/y_train.txt", colClasses="factor")
    ###signal files are rows of 561 variables that are the signals
    test_signal <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE, colClasses=c(rep("numeric",561)))
    train_signal <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE, colClasses=c(rep("numeric",561)))
    ###features file lists the signal type for all 561 variables
    features <- read.table("UCI HAR Dataset/features.txt", colClasses=c("integer", "character"))[,2]

    ##merge raw data files
    subjects <- rbind(test_subjects, train_subjects)
    activity <- rbind(test_activ, train_activ)
    signal <- rbind(test_signal, train_signal)

    ##label the column headers
    names(subjects) <- "subject"
    names(activity) <- "activity"
    names(signal) <- features

# Extracts only the measurements on the
#mean and standard deviation for each
#measurement.

    ##Selects only the features with "mean()" or "std()" in the feature name
    ###function that is TRUE if element contains: "mean()" or "std()"
    is_selection <- function(x) {grepl("mean()", x, fixed=TRUE) | grepl("std()", x, fixed=TRUE)}
    ###produces a list of only the desired features
    selected_features <- subset(features, subset = is_selection(features))
    ###filters the signal data frame to only the desired columns
    signal <- subset(signal, select = selected_features)

# Appropriately labels the data set
#with descriptive variable names.
    
    ##Mostly already done above.

# Uses descriptive activity names to
#name the activities in the data set.

    ## Convert activity column numbers to activity names
    activity_map <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("numbers", "names"))
    map_activity <- function(x) {activity_map[activity_map$number==x,"names"]}
    activity$activity <- sapply(activity$activity, map_activity)
    
#Append subject column, activity column, and signal table
    
    full_data = cbind(subjects,activity, signal)

# From the data set (above), create
#a second, independent tidy data set
#with the average of each variable
#for each activity and each subject.
    tidy <- aggregate(.~subject+activity, full_data, mean)
    
#Writing output    
    write.table(tidy, file="TidyOutput.txt", row.name=FALSE)