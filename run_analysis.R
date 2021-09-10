#Gettnig and Cleaning Data: Course Project

library(dplyr)

#download dataset
Course_Project_data <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Course_Project_data, destfile = "CP_data.zip", method = "curl")
unzip("CP_data.zip")

#Assign data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#merge the training and the test sets to create one data set
Subject <- rbind(subject_train, subject_test)
Y <- rbind(y_train, y_test)
X <- rbind(x_train, x_test)
merged_data <- cbind(Subject, Y, X)

#extract only the measurements on the mean and sd for each measurement
mean_sd <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

#use descriptive activity names to name the activities in the data set
mean_sd$code <- activities[mean_sd$code, 2]

#appropriately label the data set with descriptive varible names
names(mean_sd)[2] = "activity"
names(mean_sd) <- gsub("Acc", "Accelerometer", names(mean_sd))
names(mean_sd) <- gsub("Gyro", "Gyroscope", names(mean_sd))
names(mean_sd) <- gsub("BodyBody", "Body", names(mean_sd))
names(mean_sd) <- gsub("Mag", "Magnitude", names(mean_sd))
names(mean_sd) <- gsub("^t", "Time", names(mean_sd))
names(mean_sd) <- gsub("^f", "Frequency", names(mean_sd))
names(mean_sd) <- gsub("tBody", "TimeBody", names(mean_sd))
names(mean_sd) <- gsub("-mean()", "Mean", names(mean_sd), ignore.case = TRUE)
names(mean_sd) <- gsub("-std()", "STD", names(mean_sd), ignore.case = TRUE)
names(mean_sd) <- gsub("-freq()", "Frequency", names(mean_sd), ignore.case = TRUE)
names(mean_sd) <- gsub("angle", "Angle", names(mean_sd))
names(mean_sd) <- gsub("gravity", "Gravity", names(mean_sd))

#create a second, independent tidy data set with the ave of each var for each activity and each subj from "mean_sd"
Final_Data <- mean_sd %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(Final_Data, "Final_Data.txt", row.name = FALSE)