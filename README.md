# Getting-and-cleaning-data
Coursera course project

This repository contains the code for my solution to the assignment of the course "Getting and Cleaning Data".

Description of the assignment

One of the most exciting areas in all of data science right now is wearable computing - see for example this article ( http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/ ). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive activity names.
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

My solution

To run the analysis, perform the following steps:

1- Unzip the file getdata-projectfiles-UCI HAR Dataset.zip in your working directory.
Place the scripts run_analysis.R, analysis_functions.R and constants.R in your working directory.
2- Fill the location of the following directories as it is asked in run_analysis.R : dir, data_dir, data_test, data_train 

3- Load the source run_analysis.R at your session in R, with source("run_analysis.R")

PS : you would need dplyr package to be installed and loaded to make run_analysis script work.

Sourcing "run_analysis.R" generates a file called tidy_data.txt in your working directory.
