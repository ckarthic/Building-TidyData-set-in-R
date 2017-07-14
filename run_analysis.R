
#run_analysis.R is the R script submitted for the Week 4 programming assignment of the 'Getting and
# Cleaning Data' class in the DataScience specialization. This script assumes that the original 
#dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#is downloaded and unzipped to the current working directory.

#This script performs the following actions
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#include necessary libraries
library(dplyr)
library(tidyr)
library(data.table)

# variables containing file paths

#activity label file for training data set
train_act_lbl_path <- "./UCI HAR Dataset/train/y_train.txt" 

#file path for training data
train_data_path <- "./UCI HAR Dataset/train/x_train.txt"

#filepath for subjects in training data
train_sub_path <- "./UCI HAR Dataset/train/subject_train.txt"

#activity label file for test data set
test_act_lbl_path <- "./UCI HAR Dataset/test/y_test.txt"

#file path for test data
test_data_path <- "./UCI HAR Dataset/test/x_test.txt"

#filepath for subjects in test data
test_sub_path <- "./UCI HAR Dataset/test/subject_test.txt"


#features file path
features_path <- "./UCI HAR Dataset/features.txt"

#activity lables file path
activity_labels_path <- "./UCI HAR Dataset/activity_labels.txt"



#Step 1. Merges the training and the test sets to create one data set.


#merging activity labels
training_activity_labels <- read.table(train_act_lbl_path)
test_activity_labels <- read.table(test_act_lbl_path)
total_activity_labels <- rbind(test_activity_labels, training_activity_labels)

#merging data
train_data <- read.table(train_data_path)
test_data <- read.table(test_data_path)
total_data<- rbind(test_data, train_data)

# merging subjects
train_subjects <- read.table(train_sub_path)
test_subjects <- read.table(test_sub_path)
total_subjects <- rbind(test_subjects, train_subjects)


#setp 2. Extracts only the measurements on the mean and standard deviation for each measurement.


#extract the mean or std columns from features file
features <- read.table(features_path)
cols_of_interest <- grep("[m|M]ean|std",features[,2])
desc_col_names <- grep("[m|M]ean|std",features[,2], value = TRUE)


#step 3. Uses descriptive activity names to name the activities in the data set

#apply descriptive col name for activity table
total_activity_labels <- rename(total_activity_labels, activity = V1)

activity_labels <- read.table(activity_labels_path)
total_activity_labels_desc <-  transmute(total_activity_labels, activity = activity_labels[activity,2])


#step 4. Appropriately label the data set with descriptive variable names


#apply descriptive col names then extract mean and std columns
setnames(total_data, cols_of_interest, desc_col_names)
total_data_mean_std_cols <- total_data[,cols_of_interest]

#apply descriptive col name for subjects table
total_subjects <- rename(total_subjects, subjectid = V1)



# Step 5.From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.


total_dataset <- cbind(total_activity_labels_desc, total_subjects, total_data_mean_std_cols)
summary_dataset <- total_dataset %>% group_by(activity, subjectid) %>% summarise_all(funs(mean))








