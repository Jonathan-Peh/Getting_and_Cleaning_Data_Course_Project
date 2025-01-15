# Code Book for Getting and Cleaning Data Course Project

---

Raw data downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. Full information can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

Structure of raw data:

> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals/...(9 .txt files)  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals/...(9 .txt files)  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features_info.txt  
> ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/README.txt


File Name | Description
 :---: | :--- 
README.txt| gives experimental information and clarity to the information in the other files
train/X_train.txt|unlabelled training set
train/y_train.txt|identifies the activity performed for each observation/row in train/X_train.txt in a factor-like format with integers 1 to 6 (see activity_labels.txt)  
train/subject_train.txt|identifies the subject who performed the activity for each observation/row in train/X_train.txt  
train/Inertial Signals/...|the 9 files in this directory are not relevant to the analysis and will thus be ignored  
test/X_test.txt| unlabelled testing set  
test/y_test.txt| identifies the activity performed for each observation/row in test/X_test.txt in a factor-like format with integers 1 to 6 (see activity_labels.txt)  
test/subject_test.txt| identifies the subject who performed the activity for each observation/row in test/X_test.txt  
test/Inertial Signals/...| the 9 files in this directory are not relevant to the analysis and will thus be ignored
activity_labels.txt| maps integer values in train/y_train.txt and test/y_test.txt to understandable string formats  
features.txt| labels for each variable in the data ie column names of train/X_train.txt and test/X_test.txt  
features_info.txt| Shows information about the variables in features.txt  
