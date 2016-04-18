setwd("/Users/apple/Desktop/UCI HAR Dataset")

features <- read.csv("/Users/apple/Desktop/UCI HAR Dataset/features.txt", header = FALSE, sep = ' ')
features <- as.character(features[,2])

# Read X_train, y_train, subject_train, X_test, y_test and subject_test into a new data frame 
x <- read.table("/Users/apple/Desktop/UCI HAR Dataset/train/X_train.txt")
y <- read.csv("/Users/apple/Desktop/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = ' ')
subject <- read.csv("/Users/apple/Desktop/UCI HAR Dataset/train/subject_train.txt",header = FALSE, sep = ' ')
train <- data.frame(subject, y, x)
names(train) <- c(c("subject", "activity"), features)

x2<- read.table("/Users/apple/Desktop/UCI HAR Dataset/test/X_test.txt")
y2 <- read.csv("/Users/apple/Desktop/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = ' ')
subject2 <- read.csv("/Users/apple/Desktop/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = ' ')
test <-  data.frame(x2, y2, subject2)
names(test) <- c(c("subject", "activity"), features)

# Merges them to create one data set
all <- rbind(train, test)

#Extracts only the measurements on the mean and standard deviation for each measurement.
coselect <- grep('mean|std', features)
sub <- all[,c(1,2,coselect + 2)]

#Uses descriptive activity names to name the activities in the data set
labels <- read.table("/Users/apple/Desktop/UCI HAR Dataset/activity_labels.txt", header = FALSE)
labels <- as.character(labels[,2])
sub$activity <- labels[sub$activity]

# Appropriately labels the data set with descriptive variable names
names(all)<-gsub("^t", "time", names(all))
names(all)<-gsub("^f", "frequency", names(all))
names(all)<-gsub("Acc", "Accelerometer", names(all))
names(all)<-gsub("Gyro", "Gyroscope", names(all))
names(all)<-gsub("Mag", "Magnitude", names(all))
names(all)<-gsub("BodyBody", "Body", names(all))

#Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy <- aggregate(sub[,3:81], by = list(activity = sub$activity, subject = sub$subject),FUN = mean)
write.table(x = tidy, file = "data_tidy.txt", row.names = FALSE)