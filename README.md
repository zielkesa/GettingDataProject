This script and data set was created for the Getting and Cleaning Data course project Mar 2015.

The origional data set can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

When running the script ensure that the dplyr package is installed and that the working directory contains the 'UCI HAR Dataset' directory.

The script combines the data test and training data into a single data set.  It lists the activities used in the data with descriptive titles and adds variable names to the data.  Only data that has the mean or std of the collected data is used in the final data set.

A tidy data set is produced at the end of the script which contains the average of each of the mean and std data collected for each subject and activity type.

The repository contains:
-README.md
-run_analysis.R - analysis script described above
-CodeBook.md - description of the data in the tidy dataset
-tidy_data.txt - the tidy dataset produced by run_analysis
