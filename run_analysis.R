
# runAnalysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each
#activity and each subject. 

######################################################################################
# 1. Merge the training and the test sets to create one data set
# Read in the data from files
#Training
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", 
                           col.names=c("subject_id"))
x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/Y_train.txt",col.names="activity_label")

# Create the final training set by merging yTrain, subjectTrain, and xTrain
training_data<-cbind(subject_train,x_train,y_train)


#Testing
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt",
                         col.names=c("subject_id"))
x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/Y_test.txt",col.names="activity_label")

# Create the final test set by merging the xTest, yTest and subjectTest data
testing_data<-cbind(subject_test,x_test,y_test)



# Combine training and test data to create a final data set
merged_data<-rbind(training_data,testing_data)
##################################################################################
#2.Extracts only the measurements on the mean and standard deviation 
#for each measurement.

#read Features text
features<- read.table('./features.txt',header=FALSE); 

#select only those coloumn with mean()and std() as its variable
selected_features <- features[grepl("mean\\(\\)", features$V2)
                              | grepl("std\\(\\)", features$V2), ]

#table(grepl("mean\\(\\)", features$V2)
#     | grepl("std\\(\\)", features$V2))  to find out how many are true

# Subset Data table based on the selected features to keep only desired columns
merged_selected<-merged_data[,c(1,selected_features$V1+1,563)]

##################################################################################
# 3. Use descriptive activity names to name the activities in the data set

# Merge the finalData set with the acitivityType table to include 
# descriptive activity names

merged_selected_activity<-merge(merged_selected,activity_labels)
##################################################################################
#4.Columns are already named before descriptively according to
#that given in features table

##################################################################################

# 5. Create a second, independent tidy data set with the average of each variable
#for each activity and each subject.
final_data<-merged_selected_activity%>%
  aggregate(by=list(subject=merged_selected_activity$subject_id,
                    activity=merged_selected_activity$activity_name),
            FUN=mean, na.rm=TRUE)%>%
  select(-subject_id,-activity_name)
  
##################################################################################
# Export the final_Data set  
write.table(final_data, 'UCI HAR Dataset/tidyData.txt',row.names=FALSE,sep='\t')
