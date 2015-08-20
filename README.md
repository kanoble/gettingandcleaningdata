# Course Project for Getting and Cleaning Data

Script for merging the test and train data sets in accordance with
instructions for Coursera's Getting and Cleaning Data course project.

Original data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script contained in this repository, run_analysis.R, outputs a .txt file of the final merged tidy data set (means of the variables for each subject for each activity) and does so by sequencing through the following steps.

## Initialize libraries that contain dependent functions for the program.

## Read files for analysis.
Read the x_test, x_train, y_test, y_train, subject_test, subject_train, features, and activity_labels txt files.

## Create appropriate column names for the data frames.
The column names for the x_test and x_train data frames come from the features file. Others are specified manual based on inspections of the content of the txt files.

## Merge the training and the test sets to create one data set.
Combine the subject_, y_, and x_ files for the test and train
data sets, then rbind those two large data frames together for the
final merged set.

## Filter out columns not needed for the final analysis.
Remove variables (columns) from the merged data set that do not
include the strings "std," "mean," or "Mean" in their name.

## Use natural language descriptions for the activity ids.
Replace the activity ids (codes 1 through 6) with the natural 
language name of that activity as found in the activity_labels file.

## Summarize the data by means.
Calculate the means (averages) of each subject for each activity.

## Cleanup column names to make them tidy.
Replace shortened forms of words with longer versions.
Remove some special characters.
Revise the names of the column variables to indicate that they are 
now the mean of their original values.

## Create a text file of the final merged data set.