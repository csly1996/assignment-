#loading the appropriate libraries
library(data.table)
library(dplyr)

#setting the working directory
setwd("/Users/apple/Desktop/UCI HAR Dataset")

#reading the files from the working directory
feature_Names<-read.table("features.txt")
activityLabels<-read.table("activity_labels.txt", header = FALSE)

# Read X_train, y_train, subject_train, X_test, y_test and subject_test 
subjectTrain<-read.table("train/subject_train.txt", header = FALSE)
activityTrain<-read.table("train/y_train.txt", header = FALSE)
featuresTrain<-read.table("train/X_train.txt", header = FALSE)
subjectTest<-read.table("test/subject_test.txt", header = FALSE)
activityTest<-read.table("test/y_test.txt", header = FALSE)
featuresTest<-read.table("test/X_test.txt", header = FALSE)

# combine the data into one new data
subject<-rbind(subjectTrain, subjectTest)
activity<-rbind(activityTrain, activityTest)
features<-rbind(featuresTrain, featuresTest)

# rename the columns 
colnames(features)<-t(feature_Names[2])
names(features)

colnames(activity)<-"Activity"
colnames(subject)<-"Subject"
names(activity)
names(subject)

# merge the two datasets
newdata<-cbind(activity, subject, features)

# Extracting only the measurements on the mean and standard deviation for each measurement
mean_and_std<-grepl(".*Mean.*|.*Std.*", names(newdata), ignore.case = TRUE)
final<-newdata[ ,which(mean_and_std==TRUE)]
final$Activity<-activity
final$Subject<-as.factor(newdata$Subject)

# rename
final$Activity<-as.character(final$Activity)
for (i in 1:6)
{
  final$Activity[final$Activity == i]<-
    as.character(activityLabels[i,2])
}

final$Activity<-as.factor(final$Activity)

#Appropriately labels the data set with descriptive variable names
names(final)<-gsub("Acc", "Accelerometer", names(final))
names(final)<-gsub("Gyro", "Gyroscope", names(final))
names(final)<-gsub("BodyBody", "Body", names(final))
names(final)<-gsub("Mag", "Magnitude", names(final))
names(final)<-gsub("^t", "Time", names(final))
names(final)<-gsub("^f", "Frequency", names(final))
names(final)<-gsub("tBody", "TimeBody", names(final))
names(final)<-gsub("-mean()", "Mean", names(final), ignore.case = TRUE)
names(final)<-gsub("-std()", "STD", names(final), ignore.case = TRUE)
names(final)<-gsub("-freq()", "Frequency", names(final), ignore.case = TRUE)
names(final)<-gsub("angle", "Angle", names(final))
names(final)<-gsub("gravity", "Gravity", names(final))
names(final)

#creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidyData <- aggregate(. ~Subject + Activity, final, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
