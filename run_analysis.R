run_analysis = function(directory = "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset"){
  
  #Step 1
  
  #puts together training data into a table
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
  #First 7352 rows belong to trainset
  #Last 2947 rows belong to testset
  #column 562 is activity id
  #column 563 is subject id
  
  
  
  #Step 2
  #activity_id and #subject_id are added so that they do not get filtered away
  MeanAndStdVector = grepl("*mean*|*std*|activity_id|subject_id", names(combinedData))
  MeansAndStd = combinedData[,MeanAndStdVector]
  #answer to Step 2 is MeansAndStd
  
  
  
  #Step 3
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
  
  
  
  #Step 4
  #lowercase and dash to underscore
  colnames(MeansAndStd) = sub("\\(\\)","",gsub("-","_",(tolower(names(MeansAndStd)))))
  
  
  
  #Step 5
  Step5melt = melt(MeansAndStd,id=c("activity_id","subject_id"))
  Step5recast = dcast(Step5melt,activity_id + subject_id~variable,mean)
  write.table(Step5recast,file = "TidyDataSet.txt")
  return(Step5recast)
}