# Code Book
* This code book that describes the variables, the data, and any transformations or work performed to clean up the data 

# Data
* The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy Smartphone.
* The data for the project is obtained from the link: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

* The files that are used for the project are as follows:

* test/subject_test.txt
* test/X_test.txt
* test/y_test.txt
* train/subject_train.txt
* train/X_train.txt
* train/y_train.txt

# Variables

* Values of Varible Activity consist of data from “Y_train.txt” and “Y_test.txt”
* values of Varible Subject consist of data from “subject_train.txt” and subject_test.txt"
* Values of Varibles Features consist of data from “X_train.txt” and “X_test.txt”
* Names of Varibles Features come from “features.txt”
* levels of Varible Activity come from “activity_labels.txt”

## So we have used "Activity", "Subject" and "Features" as part of descriptive variable names for data in data frame.

# Transformations
## 1. Merges the training and the test sets to create one data set
* Concatenate the data tables by rows with new variables named as "dataSubject, "dataActivity" and "dataFeatures"
* set names to variables
* Merge columns to get the data frame "Data" for all data

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
* Taken Names of Features with “mean()” or “std()”
* Subset the data frame Data by seleted names of Features

## 3. Uses descriptive activity names to name the activities in the data set
* Descriptive activity names are taken from “activity_labels.txt”
* Facorize Variale activity in the data frame Data using descriptive activity names. Labels used are ("Walking",
    "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
    
## 4. Appropriately labels the data set with descriptive variable names. 
*     prefix t is replaced by time
*     Acc is replaced by Accelerometer
* 		Gyro is replaced by Gyroscope
* 		prefix f is replaced by frequency
* 		Mag is replaced by Magnitude
* 		BodyBody is replaced by Body

## 5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.

* "tidydata.txt" is the file file generated as output of thuis step
