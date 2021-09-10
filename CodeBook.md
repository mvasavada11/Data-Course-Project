Getting and Cleaning Data Course Project Code book

The run_analysis.R script prepares the data and then performs the 5 steps required by the instructions.

1. Download the dataset
	a. The dataset was downloaded and extracted in folder called “UCI HAR Dataset”
2. Assign each data to variables
	a. features <- features.txt: 561 rows and 2 columns
		The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ
	b. activities <- activity_labels.txt: 6 rows and 2 columns
		list of activities with codes
	c. subject_test <- test/subject_test.txt: 2947 rows and 1 column
	    test data volunteer test subjects being observed
	d. x_test <- test/X_test.txt: 2947 rows and 561 columns	
	    recorded features test data
    e. y_test <- test/y_test.txt: 2947 rows and 1 column
        test data of activities’ code labels
    f. subject_train <- test/subject_train.txt: 7352 rows and 1 column
        train data of volunteer subjects being observed
	g. x_train <- test/X_train.txt: 7352 rows and 561 columns	
	    recorded features train data
	h. y_train <- test/y_train.txt: 7352 rows and 1 column
	    train data of activities’ code labels
3. Merge the training and test files to create a dataset
	a. Subject (10299 rows and 1 column): created by using rbind() to merge subject_train and subject_text 
	b. Y (10299 rows and 1 column): created by using rbind() to merge y_train and y_text 
	c. X (10299 rows and 561 columns): created by using rbind() to merge x_train and x_text
	d. merged_data (10299 rows and 563 columns): created by using cbind() to merge Subject, Y, and X
4. Extracts only the measurements on the mean and standard deviation for each measurement
	a. mean_sd (10299 rows, 88 columns): created by subsetting merged_data, selecting only columns- subject, code, and the measurements of mean and standard deviation
5. Uses descriptive activity names to name the activities in the data set
	a. Numbers in the code column of the mean_sd dataset were replaced with the corresponding activity taken 
		from column 2 of the activities variable.
6. Appropriately labels the data set with descriptive variable names
	a. code column in mean_sd renamed into activities
	b. Acc replaced by Accelerometer
	c. Gyro replaced by Gyroscope
	d. BodyBody replaced by Body
	e. Mag replaced by Magnitude
	f. f* replaced by Frequency
	g. t* in column’s name replaced by Time
7. From data set created in step 4, create a second, independent tidy data set with the average of each variable for each activity
		a. Final_Data.txt (180 rows and 88 columns): created by grouping by subject and activity, and taking the mean of each                    variable for each activity and each subject
