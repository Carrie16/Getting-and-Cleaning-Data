Getting and Cleaning Data – Final Project

Carrie Farwell 

Overview
This codebook provides further information on the Getting and Cleaning Data Final Project offered through Coursera, classes provided by John Hopkins University. This project consisted of obtaining data, reading it into R, formatting the data, creating a tidy dataset, and creating an R script.

Data
Data for this project was obtained from The UCI Machine Learning Repository. 
The data contains information on experiments conducted on volunteers perfoming various fitness activites will being recorded with a Galaxy S II smartphone.
More information in these datasets can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data was downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Packages Used
dplyr
data.table
tidyr
plyr

Process
1. Loading the data
The datasets used were:
1.	features.txt
2.	activity_labels.txt
3.	subject_train.txt
4.	X_train.txt
5.	y_train.txt
6.	subject_test.txt
7.	X_test.txt
8.	y_test.txt

These data sets were loaded in to R using the read.table function
1.	features.txt to features
2.	activity_labels.txt to actvlabels
3.	subject_train to subtrain
4.	X_train to xtrain
5.	y_train to ytrain
6.	subject_test to subtext
7.	X_text to xtext
8.	y_text to ytext

2. Combining the data sets 
The datasets were combined using the rbind() function into three new datasets:
1.	subdata
2.	actvdata
3.	featdata

3. Labeling the new datasets
Colnames was used to label the new datasets. The featdata set pulled the labels from the features dataset

4. Complete data set
All the datasets were merged to form one complete dataset using cbind(), name compdata.
5. Selecting out the mean and standard deviations
This was completed using the grep() function in two parts. Fist the means than the standard deviations. The result was the datasets grepmean and grepstd. These two datasets were then combined, along with the subject and activity names, to give us a list of columuns names to needed for the end data, name selcol.

6. Creating the tidy data
The selcol names was used to select out of the compdata the columns (with data) needed for the tidydata.txt.
The function used was seldata <- compdata[,selcol], resulting variable: seldata.
The activity names were added  to the seldata by using : seldata$activity[seldata$activity == 1] <- as.character(actvlabels[1,2]), where  the value for activity equals 1, we updated the corresponding activity name with a key value of 1 from the actvlabels dataset.
The tidy required that the data contain the average of each variable for each activity and subject. This done using the aggregate function and saved to a new variable called medata.
The data was also ordered by subject nd activity using the order function and saved to a variable called orderdata.
The tidydata.txt was created using the write.table function.







