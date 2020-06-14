# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.

The run_analysis.R script does the following:

- Read the raw data : train and test, X and Y
- Read the activities and subjects tables
- Merge data to one single dataframe, called df
- Change the label of activity from their Id to their Name
- Rename properly the columns
- Compute the mean by subject/activity/signal
- Output the result to the file tidy.txt
