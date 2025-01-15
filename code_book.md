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
README.txt| gives experimental information and clarity to the information in the other files. Read for more information
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

Going from the raw data to the tidy dataset involves 5 steps (which can be seen in run_analysis.R):
### Step 1: Merges the training and the test sets to create one data set
``` R
  xtrain = read.table(paste0(directory,"/train/X_train.txt"))
  ytrain = read.table(paste0(directory,"/train/y_train.txt"))
  subjecttrain = read.table(paste0(directory,"/train/subject_train.txt"))
  trainset = cbind(xtrain,ytrain,subjecttrain)
  
  #puts together testing data into a table
  xtest = read.table(paste0(directory,"/test/X_test.txt"))
  ytest = read.table(paste0(directory,"/test/y_test.txt"))
  subjecttest = read.table(paste0(directory,"/test/subject_test.txt"))
  testset = cbind(xtest,ytest,subjecttest)
  
  #combines and labels both traning and test data, using features.txt
  measurementNames = read.table(paste0(directory,"/features.txt"))[,2]
  combinedData = data.frame(rbind(trainset,testset))
  colnames(combinedData) = c(measurementNames,"activity_id","subject_id")
  #answer to Step 1 is combinedData
```
### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
```R
  #activity_id and #subject_id are added so that they do not get filtered away
  MeanAndStdVector = grepl("*mean*|*std*|activity_id|subject_id", names(combinedData))
  MeansAndStd = combinedData[,MeanAndStdVector]
  #answer to Step 2 is MeansAndStd
```
### Step 3: Uses descriptive activity names to name the activities in the data set
```R
  activity_labels = read.table(paste0(directory,"/activity_labels.txt"))[,2]
  #instead of for loop, could have done:
  #MeansAndStd$activity_id = factor(MeansAndStd$activity_id, labels = activity_labels)
  counter = 1
  activity = vector(mode = "character")
  for (i in MeansAndStd$activity_id){
    activity[counter] = activity_labels[i]
    counter = counter +1
  }
  MeansAndStd$activity_id = activity
  #answer to Step 3 is this reformed MeansAndStd
```
### Step 4: Appropriately labels the data set with descriptive variable names. 
```R
  colnames(MeansAndStd) = sub("\\(\\)","",gsub("-","_",(tolower(names(MeansAndStd)))))
```
### Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```R
  Step5melt = melt(MeansAndStd,id=c("activity_id","subject_id"))
  Step5recast = dcast(Step5melt,activity_id + subject_id~variable,mean)
  write.table(Step5recast,file = "TidyDataSet.txt")
  return(Step5recast)
```
