## Script for merging the test and train data sets in accordance with
## instructions for Coursera's Getting and Cleaning Data course project.
## The result of the script is a tidy data set that contains the means
## (averages) of each subject for each activity.

## Original data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Initialize libraries that contain dependent functions for the program.
library(data.table)
library(dplyr)

## Read files for analysis.
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test<- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

## Create appropriate column names for the data frames.
## The column names for the x_ data frames come from the features file.
colnames(x_test) <- as.vector(features[,2])
colnames(x_train) <- as.vector(features[,2])
colnames(y_test) <- "Activity_id"
colnames(y_train) <- "Activity_id"
colnames(subject_test) <- "Subject"
colnames(subject_train) <- "Subject"
colnames(activity_labels) <- c("Activity_id", "Activity")

## Merge the training and the test sets to create one data set.
## Combine the subject_, y_, and x_ files for the test and train
## data sets, then rbind those two large data frames together for the
## final merged set.
mergedset <- data.frame()
x_test <- cbind(subject_test, y_test, x_test)
x_train <- cbind(subject_train, y_train, x_train)
mergedset <- rbind(x_test, x_train)

## Remove variables (columns) from the merged data set that do not
## include the strings "std," "mean," or "Mean" in their name.
## The Activity and Subject columns are included in the grep command
## as they're needed for the eventual summary.
mergedset <- mergedset[,grepl("Activity|Subject|std|mean|Mean", names(mergedset))]

## Replace the activity ids (codes 1 through 6) with the natural 
## language name of that activity as found in the activity_labels file.
mergedset <- merge(activity_labels, mergedset, by = "Activity_id")

## Remove the extraneous Activity_id column.
mergedset <- mergedset[,-1]

## Reorder the columns so that the Subject is first.
mergedset <- select(mergedset, Subject, Activity, 3:ncol(mergedset))

## Calculate the means (averages) of each subject for each activity.
mergedset <- mergedset %>% 
    group_by(Subject, Activity) %>% 
    summarise_each(funs(mean))

## Other cleanup of column names to make them tidy.
colnames(mergedset) <- sub("Acc", "Acceleration", colnames(mergedset), fixed = TRUE)
colnames(mergedset) <- sub("Gyro", "Gyroscope", colnames(mergedset), fixed = TRUE)
colnames(mergedset) <- sub("Mag", "Magnitude", colnames(mergedset), fixed = TRUE)
colnames(mergedset) <- sub("BodyBody", "Body", colnames(mergedset), fixed = TRUE)
colnames(mergedset) <- sub("Freq", "Frequency", colnames(mergedset), fixed = TRUE)
colnames(mergedset) <- sub("\\(\\)", "", colnames(mergedset))

## Revise the names of the column variables to indicate that they are 
## now the mean of their original values.
colnames(mergedset) <- paste("Mean of:", colnames(mergedset), sep = " ")
colnames(mergedset)[1] <- "Subject"
colnames(mergedset)[2] <- "Activity"

## Create a text file of the final merged data set.
write.table(mergedset, file = "mergedset.txt", row.name = FALSE)