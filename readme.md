README FILE 

This file contains analysis steps followed in “run_analysis.R” which analyses Samsung data (provided in Course Project –  Getting Cleaning Data  - Coursera - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and creates a new data set “tidyData” following the instructions required by the assigment.
Information about variables, data and trasfomations are available “Codebook.md". 

“run_analysis.R”

1)  Merges the training and the test sets to create one data set.
Read files in folder “test” and “train” and create two dataframes “dbtest” and “dbtrain”. Create a complete dataset “db” merging “dbtest” and “dbtrain”. 	

2)	Extracts only the measurements on the mean and standard deviation for each measurement.
3)	Appropriately labels the data set with descriptive variable names

A.Mean variables
Reads "features.txt" into a dataframe and subsets for any values (secound columns) equal to mean (“vecMean”). Subsetting “vecMean” columns get a vecton with the column index (colMean) and one with labels (labMean).
Using gsub function it cleans labels from "-". Than it subsets the complete dataset (db) for variables “means” and names the resulting data frame – “dbselMean”

B.Std variables
	The same as Mean variables. Resulting data frame – “dbselMean”

C. Subject and activity
Subsets the complete dataset (db) for subject and activity of measurement and names the resultin data frame – “dbSubAct”

D. Merge dbSubAct, dbselMean, dbselStd in a dataset – “dbsel”


5)	Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Using the function “aggregate” on “dbsel” calculates the average of each variable grouping by activity and subject (aggdata) and subsets to remove grouping columns (tidyData).

4)  Uses descriptive activity names to name the activities in the data set
Change activity code in “aggdata” (column “activity”) with descriptive names (CodeBook.md). 

Creates a new file containing the tidy dataset (tidyData.txt)
