# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

require(plyr)

# read each of the relevant files from the dataset

# read the activity labels files
activity_labels <- read.delim("./activity_labels.txt", header=FALSE, sep="")
names(activity_labels) <- c("label","activity")

# read the feature listing
features <- read.delim("./features.txt", header=FALSE, sep="")
names(features) <- c("index","feature")

# read the training data
x_train <-  read.delim("./train/X_train.txt", header=FALSE, sep="")
y_train <-  read.delim("./train/y_train.txt", header=FALSE, sep="")
subject_train <-  read.delim("./train/subject_train.txt", header=FALSE, sep="")

# read the Inertial Signals training set
body_acc_x_train  <- read.delim("./train/Inertial Signals/body_acc_x_train.txt", header=FALSE, sep="")
body_acc_y_train  <- read.delim("./train/Inertial Signals/body_acc_y_train.txt", header=FALSE, sep="")
body_acc_z_train  <- read.delim("./train/Inertial Signals/body_acc_z_train.txt", header=FALSE, sep="")
body_gyro_x_train <- read.delim("./train/Inertial Signals/body_gyro_x_train.txt", header=FALSE, sep="")
body_gyro_y_train <- read.delim("./train/Inertial Signals/body_gyro_y_train.txt", header=FALSE, sep="")
body_gyro_z_train <- read.delim("./train/Inertial Signals/body_gyro_z_train.txt", header=FALSE, sep="")
total_acc_x_train <- read.delim("./train/Inertial Signals/total_acc_x_train.txt", header=FALSE, sep="")
total_acc_y_train <- read.delim("./train/Inertial Signals/total_acc_y_train.txt", header=FALSE, sep="")
total_acc_z_train <- read.delim("./train/Inertial Signals/total_acc_z_train.txt", header=FALSE, sep="")

# read the test data
x_test <-  read.delim("./test/X_test.txt", header=FALSE, sep="")
y_test <-  read.delim("./test/y_test.txt", header=FALSE, sep="")
subject_test <-  read.delim("./test/subject_test.txt", header=FALSE, sep="")

# read the Inertial Signals testing set
body_acc_x_test  <- read.delim("./test/Inertial Signals/body_acc_x_test.txt", header=FALSE, sep="")
body_acc_y_test  <- read.delim("./test/Inertial Signals/body_acc_y_test.txt", header=FALSE, sep="")
body_acc_z_test  <- read.delim("./test/Inertial Signals/body_acc_z_test.txt", header=FALSE, sep="")
body_gyro_x_test <- read.delim("./test/Inertial Signals/body_gyro_x_test.txt", header=FALSE, sep="")
body_gyro_y_test <- read.delim("./test/Inertial Signals/body_gyro_y_test.txt", header=FALSE, sep="")
body_gyro_z_test <- read.delim("./test/Inertial Signals/body_gyro_z_test.txt", header=FALSE, sep="")
total_acc_x_test <- read.delim("./test/Inertial Signals/total_acc_x_test.txt", header=FALSE, sep="")
total_acc_y_test <- read.delim("./test/Inertial Signals/total_acc_y_test.txt", header=FALSE, sep="")
total_acc_z_test <- read.delim("./test/Inertial Signals/total_acc_z_test.txt", header=FALSE, sep="")

# merge the training and test sets
x <- rbind(x_train,x_test)
y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)

body_acc_x  <- rbind(body_acc_x_train ,body_acc_x_test )
body_acc_y  <- rbind(body_acc_y_train ,body_acc_y_test )
body_acc_z  <- rbind(body_acc_z_train ,body_acc_z_test )
body_gyro_x <- rbind(body_gyro_x_train,body_gyro_x_test)
body_gyro_y <- rbind(body_gyro_y_train,body_gyro_y_test)
body_gyro_z <- rbind(body_gyro_z_train,body_gyro_z_test)
total_acc_x <- rbind(total_acc_x_train,total_acc_x_test)
total_acc_y <- rbind(total_acc_y_train,total_acc_y_test)
total_acc_z <- rbind(total_acc_z_train,total_acc_z_test)

# find the variables containing information about means and standard deviations
columns <- c(grep("mean",features$feature),grep("std",features$feature))
columns <- columns[order(columns)]

# merge subject, activity and measurements and assign variable names
names(y) <- c("label")
y <- join(y, activity_labels, by="label")

tidy_set <- cbind(subject,y$activity,x[features[columns,"index"]])
names(tidy_set) <- c("subject", "activity", as.character(features[columns,"feature"]))
tidy_set$subject <- factor(tidy_set$subject)

# find the column means for each variable by subject and activity
tidy_summary <- ddply(tidy_set[3:length(tidy_set)], .(tidy_set$subject, tidy_set$activity), colMeans)

# clean up the column names
names(tidy_summary) <- names(tidy_set)