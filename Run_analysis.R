
# This file run_analysis.R intends to do the following.

# Step 1: Merges the training and the test sets to create one data set.
# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# Step 3: Uses descriptive activity names to name the activities in the data set
# Step 4: Appropriately labels the data set with descriptive variable names.
# Step 5: From the data set in step 4, creates a second, independent tidy data set 
#         with the average of each variable for each activity and each subject.

# From the related files, we can see:

# 	Values of Varible Activity consist of data from “Y_train.txt” and “Y_test.txt”
# 	values of Varible Subject consist of data from “subject_train.txt” and subject_test.txt"
# 	Values of Varibles Features consist of data from “X_train.txt” and “X_test.txt”
# 	Names of Varibles Features come from “features.txt”
# 	levels of Varible Activity come from “activity_labels.txt”
# 	So we will use Activity, Subject and Features as part of descriptive variable 
# 	names for data in data frame.

# Step 1: Merges the training and the test sets to create one data set.

# Set working directory to ../UCI HAR Dataset
# Read the Activity files

ActivityTest  <- read.table("test/Y_test.txt",header = FALSE)
ActivityTrain  <- read.table("train/Y_train.txt",header = FALSE)

SubjectTrain <- read.table("train/subject_train.txt",header = FALSE)
SubjectTest <- read.table("test/subject_test.txt",header = FALSE)

FeatureTest  <- read.table("test/X_test.txt",header = FALSE)
FeatureTrain  <- read.table("train/X_train.txt",header = FALSE)

# (a) Concatenate the data tables by rows

dataSubject <- rbind(SubjectTrain, SubjectTest)
dataActivity<- rbind(ActivityTrain, ActivityTest)
dataFeatures<- rbind(FeatureTrain, FeatureTest)

# (b) set names to variables

names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table("features.txt",head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

# (c) Merge columns to get the data frame Data for all data

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement

# Subset Name of Features by measurements on the mean and standard deviation
# i.e taken Names of Features with “mean()” or “std()”

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

# Subset the data frame Data by seleted names of Features

selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

# Step 3: Uses descriptive activity names to name the activities in the data set
# (a)Read descriptive activity names from “activity_labels.txt”

activityLabels <- read.table("activity_labels.txt",header = FALSE)

# (b) Facorize Variale activity in the data frame Data using descriptive activity names

Data$activity <- factor(Data$activity, labels=c("Walking",
    "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))


# Step 4: Appropriately labels the data set with descriptive variable names

# 		prefix t is replaced by time
# 		Acc is replaced by Accelerometer
# 		Gyro is replaced by Gyroscope
# 		prefix f is replaced by frequency
# 		Mag is replaced by Magnitude
# 		BodyBody is replaced by Body

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

# Step 5: Creates a second,independent tidy data set and ouput it
# 	In this part,a second, independent tidy data set will be created with the 
# 	average of each variable for each activity and each subject based on the 
# 	data set in above step

library(plyr)
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
