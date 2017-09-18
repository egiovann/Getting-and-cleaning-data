## run_analysis.R
##################

#You need to fill the adress 

#Directories where the data are stored
#Name you working directory (dir variable), where you unzip the data for the project
#"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- ""


#-------------------------------------------------------
#-------------------------------------------------------
# test data and train data merging
df1 <- data.frame(read.table(paste(dir,"UCI HAR Dataset/X_test.txt",sep="")))
df2 <- data.frame(read.table(paste(dir,"UCI HAR Dataset/X_train.txt",sep="")))
df <- rbind(df1, df2)

#feature.txt gives the names of the variables in X_test.txt and X_train.txt
#these names are in the variable V2, 1 column, 561 rows
feature <- data.frame(read.table(paste(dir,"UCI HAR Dataset/features.txt",sep="")))

v <- as.vector(feature$V2) 
y <- data.frame(matrix(nrow=1,ncol=561))

#transposition  of v to get all the names in different columns and not different rows
#the result is put in y
for(i in 1:561){
  y[1,i] <- (v[i]) 
}

#"V" (automatically generated in y) is replaced by "X" to get the same column name than df and do rbind
names(y) <- gsub("X","V",names(y))
df_new <- rbind(y,df)

data1<- data.frame(ID=1:10300)

#Seeking for variables name  with "mean" or "std"
#gathering these variables into a new data frame -> "data1"
for(i in 1:561){
  if (grepl("mean|std",df_new[1,i])==TRUE){
    data1 <- cbind(data1,df_new[,i],stringsAsFactors = FALSE)  
  }
}

#Putting the appropriate variable name instead of "X1" "X2".... etc
#These names are stored in the first row of each column of the data frame "data1"

names(data1)[1] <- "ID"
for(i in 2:80){
  names(data1)[i] <- as.character(data1[1,i])
}

#removing the first row which is now useless 
data2 <- data1[-1,-1]

#-------------------------------------------------------
#-------------------------------------------------------
#reading activity and subject datasets
act1 <- data.frame(read.table(paste(dir_test,"y_test.txt",sep="")))
act2 <- data.frame(read.table(paste(dir_train,"y_train.txt",sep="")))
sub1 <- data.frame(read.table(paste(dir_test,"subject_test.txt",sep="")))
sub2 <- data.frame(read.table(paste(dir_train,"subject_train.txt",sep="")))

#Merging of the training and the test datasets for "Activity" and "Subject" variables.
act <- rbind(act1, act2)
sub <- rbind(sub1,sub2)

#Adding "Activity" and "Subject" variables to the "data2" data frame that contains the values of each "mean" and "std" variables
data3 <- cbind(sub,act,data2,stringsAsFactors = FALSE)
names(data3)[1:2] <- c("Subject","Activity")

#-------------------------------------------------------
#-------------------------------------------------------
#Converting all the variables in the last data frame into numeric (all the variables were factor type previously)
data4 <- lapply(data3, FUN = as.numeric)
data4 <- as.data.frame(data4)

#-------------------------------------------------------
#-------------------------------------------------------
#Grouping data by "Subject" then "Activity"
#summarise function used to calculate the average of each variable for each activity and each subject.

groups <- group_by(data4,Subject,Activity)
tidy_data <- summarise(groups, mean(tBodyAcc.mean...X),  mean(tBodyAcc.mean...Y),  mean(tBodyAcc.mean...Z), 
                       mean(tBodyAcc.std...X), mean(tBodyAcc.std...Y),  mean(tBodyAcc.std...Z), 
                       mean(tGravityAcc.mean...X),mean(tGravityAcc.mean...Y),mean(tGravityAcc.mean...Z),
                       mean(tGravityAcc.std...X),mean( tGravityAcc.std...Y),mean( tGravityAcc.std...Z),
                       mean(tBodyAccJerk.mean...X) ,mean( tBodyAccJerk.mean...Y) ,mean( tBodyAccJerk.mean...Z),
                       mean(tBodyAccJerk.std...X),mean( tBodyAccJerk.std...Y),mean( tBodyAccJerk.std...Z),
                       mean(tBodyGyro.mean...X) ,mean( tBodyGyro.mean...Y) ,mean( tBodyGyro.mean...Z),
                       mean(tBodyGyro.std...X),mean( tBodyGyro.std...Y) ,mean( tBodyGyro.std...Z),
                       mean(tBodyGyroJerk.mean...X)   ,mean( tBodyGyroJerk.mean...Y) ,mean( tBodyGyroJerk.mean...Z),
                       mean(tBodyGyroJerk.std...X)   ,mean( tBodyGyroJerk.std...Y)  ,mean( tBodyGyroJerk.std...Z),
                       mean(tBodyAccMag.mean..)  ,mean( tBodyAccMag.std..)   ,mean( tGravityAccMag.mean..)   ,
                       mean(tGravityAccMag.std..) ,mean( tBodyAccJerkMag.mean..)   ,mean( tBodyAccJerkMag.std..) ,
                       mean(tBodyGyroMag.mean..),mean( tBodyGyroMag.std..),mean(tBodyGyroJerkMag.mean..),
                       mean(tBodyGyroJerkMag.std..) ,mean(fBodyAcc.mean...X),mean( fBodyAcc.mean...Y) ,
                       mean(fBodyAcc.mean...Z),mean( fBodyAcc.std...X),mean( fBodyAcc.std...Y),mean( fBodyAcc.std...Z),
                       mean(fBodyAcc.meanFreq...X),mean( fBodyAcc.meanFreq...Y) ,mean( fBodyAcc.meanFreq...Z) ,
                       mean(fBodyAccJerk.mean...X) ,mean( fBodyAccJerk.mean...Y),mean( fBodyAccJerk.mean...Z) ,
                       mean(fBodyAccJerk.std...X) ,mean( fBodyAccJerk.std...Y),mean( fBodyAccJerk.std...Z),
                       mean(fBodyAccJerk.meanFreq...X),mean( fBodyAccJerk.meanFreq...Y) ,mean( fBodyAccJerk.meanFreq...Z),
                       mean(fBodyGyro.mean...X),mean( fBodyGyro.mean...Y) ,mean( fBodyGyro.mean...Z),
                       mean(fBodyGyro.std...X),mean( fBodyGyro.std...Y) ,mean( fBodyGyro.std...Z),
                       mean(fBodyGyro.meanFreq...X) ,mean( fBodyGyro.meanFreq...Y) ,
                       mean( fBodyGyro.meanFreq...Z) ,mean(fBodyAccMag.mean..),mean(fBodyAccMag.std..) ,
                       mean( fBodyAccMag.meanFreq..),mean(fBodyBodyAccJerkMag.mean..),
                       mean(fBodyBodyAccJerkMag.std..),mean(fBodyBodyAccJerkMag.meanFreq..) ,
                       mean( fBodyBodyGyroMag.mean..),mean( fBodyBodyGyroMag.std..),
                       mean(fBodyBodyGyroMag.meanFreq..)   ,mean( fBodyBodyGyroJerkMag.mean..) ,
                       mean(fBodyBodyGyroJerkMag.std..) ,mean( fBodyBodyGyroJerkMag.meanFreq..))


#-------------------------------------------------------
#-------------------------------------------------------

#Using descriptive activity names to name the activities in the data set
# Activity_labels.txt
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

for (i in 1:180){
  if (tidy_data$"Activity"[i] == "1") {tidy_data$"Activity"[i] <-  "WALKING"}
  if (tidy_data$"Activity"[i] == "2") {tidy_data$"Activity"[i] <-  "WALKING_UPSTAIRS"}
  if (tidy_data$"Activity"[i] == "3") {tidy_data$"Activity"[i] <-  "WALKING_DOWNSTAIRS"}
  if (tidy_data$"Activity"[i] == "4") {tidy_data$"Activity"[i] <-  "SITTING"}
  if (tidy_data$"Activity"[i] == "5") {tidy_data$"Activity"[i] <-  "STANDING"}
  if (tidy_data$"Activity"[i] == "6") {tidy_data$"Activity"[i] <-  "LAYING"}
}

#-------------------------------------------------------
#-------------------------------------------------------
