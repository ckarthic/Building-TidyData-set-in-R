#CodeBook for run_analysis.R script file

## variables for file names

- train_act_lbl_path  : activity label file for training data set
- train_data_path : file path for training data
- train_sub_path : filepath for subjects in training data
- test_act_lbl_path : activity label file for test data set
- test_data_path : file path for test data
- test_sub_path : filepath for subjects in test data
- features_path : features file path
- activity_labels_path : activity lables file path

## variables

- training_activity_labels : table that stores the training activity data
- test_activity_labels : table that stores the test activity data
- total_activity_labels : merged test and training activity data

- train_data : table that stores the traning acc/gyro data
- test_data : table that stores the test acc/gyro data
- total_data : merged table containing training and test acc/gyro data

- train_subjects : table that stores training subjectids
- test_subjects : table that stores test subjectids
- total_subjects : merged subjectids from training and test tables

- features : tables with featureids and featurename. useful to assign descriptive 
variable names for the dataset
- cols_of_interest : column positions of mean/std columns in the dataset
- desc_col_names : descriptive names for these mean/std columns

- total_dataset - combined test and training data set combined into one
- summary_dataset - summarized dataset that contains the mean values of mean/std columns grouped by activity and subject

## Transformations
1. Read the activity, subject and acc/gyro data for test and training and merge them respectively.
2. use the features table to get the column positions and descriptive column names for the mean/std columns that is of interest
3. Use variables from step 2 to extract the mean/std columns from the combined dataset and rename the variable names to be descriptive.
4. Convert the ActivityIds into descriptive ActivityNames in the activity dataset
5. Create the summarized dataset by grouping the total dataset by activity and subject and then calculate the means of the grouped columns
