## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Initialize libraries that contain dependent functions for the program.
library(data.table)

## Read files
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test<- read.table("UCI HAR Dataset/test/y_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
features <- read.table("UCI HAR Dataset/features.txt")

## 
namevector <- as.vector(features[,2])


## 1 - Merges the training and the test sets to create one data set.
mergedFile <- data.frame()
mergedFile <- rbind(x_test, x_train)

## 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 


## 3 - Uses descriptive activity names to name the activities in the data set


## 4 - Appropriately labels the data set with descriptive variable names. 


## 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
