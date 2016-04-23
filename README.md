# assignment
 For this assignment, we need to:
 1.Merges the training and the test sets to create one data set
 2.Extracts only the measurements on the mean and standard deviation for each measurement
 3.Uses descriptive activity names to name the activities in the data set
 4.Appropriately labels the data set with descriptive variable names
 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

 The instruction will be,
 1. download the data set from the website
 2. unzip the data to the working directory and save them in their original names of the directories
 3. start a RStudio session and creat a script
 4. use libraries "data.table" and "dplyr"
 5. split training and test data sets and they are present in three different files, such as "activity", "subject", "features"
 6. merge the two datasets by using cbind
 7. extract the column indices that have either "mean" or "std"
 8. Acc can be replaced with Accelerometer Gyro can be replaced with Gyroscope BodyBody can be replaced with Body Mag can be replaced with Magnitude Character f can be replaced with Frequency Character t can be replaced with Time
 9. create tidyData as a data set with average for each activity and subject
 10. write tidy data into file Tidy.txt 
