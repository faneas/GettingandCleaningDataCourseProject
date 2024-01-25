# Assumes the files are downloaded into D:\datascience\cleaning_data\final\UCI HAR Dataset
setwd ("D:\\datascience\\cleaning_data\\final\\UCI HAR Dataset")

# Load required library 
library (dplyr)

########## Step 1: Creating one data set

# Read the function names
features <- read.table ("features.txt", col.names = c("id","functionname"))

# Read the training data
xtraining <- read.table ("train/X_train.txt", col.names = features$functionname)
ytraining <- read.table ("train/y_train.txt", col.names = "activity")
strainining <- read.table ("train/subject_train.txt", col.names = "subject")

# Read the test data
xtest <- read.table ("test/X_test.txt", col.names = features$functionname)
ytest <- read.table ("test/y_test.txt", col.names = "activity")
stest <- read.table ("test/subject_test.txt", col.names = "subject")

# Merge the subjects. Since their identification is different from training and test
# we can simply rbind them
smerge <- rbind (strainining,stest)

# Merge training and set measurements
# order needs to match the order the subjects have been merged
xmerge <- rbind (xtraining, xtest)
ymerge <- rbind (ytraining, ytest)

# Final merge: subjects + y (activity labels) + x (measurements)
step1 <- cbind (smerge, ymerge, xmerge)

########## Step 2: selecting the data

step2 <- select(step1, subject, activity, contains("mean"), contains("std"))

########## Step 3: Uses descriptive activity names to name the activities in the data set

# Load activity list
aclist <- read.table ("activity_labels.txt", col.names = c("activity", "acdescription"))

# Since tidy data is required, we'll update the activity in step2, instead of adding a new column
step2$activity <- aclist [step2$activity, "acdescription"]

########## Step 4: Appropriately labels the data set with descriptive variable names

names (step2) [names (step2) == "subject"] <- "subjectid"
names (step2) [names (step2) == "activity"] <- "activityname"

########## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

# tested other functions (like summarize_at) but I guess I need to work more on that. 
# ended up using summarise for all variables as shown in the lesson video

step5 <- step2 %>%  group_by(subjectid, activityname) %>% 
  summarise ( 
    steptBodyAcc.mean...X=mean(tBodyAcc.mean...X)
    ,tBodyAcc.mean...Y=mean(tBodyAcc.mean...Y)
    ,tBodyAcc.mean...Z=mean(tBodyAcc.mean...Z)
    ,tGravityAcc.mean...X=mean(tGravityAcc.mean...X)
    ,tGravityAcc.mean...Y=mean(tGravityAcc.mean...Y)
    ,tGravityAcc.mean...Z=mean(tGravityAcc.mean...Z)
    ,tBodyAccJerk.mean...X=mean(tBodyAccJerk.mean...X)
    ,tBodyAccJerk.mean...Y=mean(tBodyAccJerk.mean...Y)
    ,tBodyAccJerk.mean...Z=mean(tBodyAccJerk.mean...Z)
    ,tBodyGyro.mean...X=mean(tBodyGyro.mean...X)
    ,tBodyGyro.mean...Y=mean(tBodyGyro.mean...Y)
    ,tBodyGyro.mean...Z=mean(tBodyGyro.mean...Z)
    ,tBodyGyroJerk.mean...X=mean(tBodyGyroJerk.mean...X)
    ,tBodyGyroJerk.mean...Y=mean(tBodyGyroJerk.mean...Y)
    ,tBodyGyroJerk.mean...Z=mean(tBodyGyroJerk.mean...Z)
    ,tBodyAccMag.mean..=mean(tBodyAccMag.mean..)
    ,tGravityAccMag.mean..=mean(tGravityAccMag.mean..)
    ,tBodyAccJerkMag.mean..=mean(tBodyAccJerkMag.mean..)
    ,tBodyGyroMag.mean..=mean(tBodyGyroMag.mean..)
    ,tBodyGyroJerkMag.mean..=mean(tBodyGyroJerkMag.mean..)
    ,fBodyAcc.mean...X=mean(fBodyAcc.mean...X)
    ,fBodyAcc.mean...Y=mean(fBodyAcc.mean...Y)
    ,fBodyAcc.mean...Z=mean(fBodyAcc.mean...Z)
    ,fBodyAcc.meanFreq...X=mean(fBodyAcc.meanFreq...X)
    ,fBodyAcc.meanFreq...Y=mean(fBodyAcc.meanFreq...Y)
    ,fBodyAcc.meanFreq...Z=mean(fBodyAcc.meanFreq...Z)
    ,fBodyAccJerk.mean...X=mean(fBodyAccJerk.mean...X)
    ,fBodyAccJerk.mean...Y=mean(fBodyAccJerk.mean...Y)
    ,fBodyAccJerk.mean...Z=mean(fBodyAccJerk.mean...Z)
    ,fBodyAccJerk.meanFreq...X=mean(fBodyAccJerk.meanFreq...X)
    ,fBodyAccJerk.meanFreq...Y=mean(fBodyAccJerk.meanFreq...Y)
    ,fBodyAccJerk.meanFreq...Z=mean(fBodyAccJerk.meanFreq...Z)
    ,fBodyGyro.mean...X=mean(fBodyGyro.mean...X)
    ,fBodyGyro.mean...Y=mean(fBodyGyro.mean...Y)
    ,fBodyGyro.mean...Z=mean(fBodyGyro.mean...Z)
    ,fBodyGyro.meanFreq...X=mean(fBodyGyro.meanFreq...X)
    ,fBodyGyro.meanFreq...Y=mean(fBodyGyro.meanFreq...Y)
    ,fBodyGyro.meanFreq...Z=mean(fBodyGyro.meanFreq...Z)
    ,fBodyAccMag.mean..=mean(fBodyAccMag.mean..)
    ,fBodyAccMag.meanFreq..=mean(fBodyAccMag.meanFreq..)
    ,fBodyBodyAccJerkMag.mean..=mean(fBodyBodyAccJerkMag.mean..)
    ,fBodyBodyAccJerkMag.meanFreq..=mean(fBodyBodyAccJerkMag.meanFreq..)
    ,fBodyBodyGyroMag.mean..=mean(fBodyBodyGyroMag.mean..)
    ,fBodyBodyGyroMag.meanFreq..=mean(fBodyBodyGyroMag.meanFreq..)
    ,fBodyBodyGyroJerkMag.mean..=mean(fBodyBodyGyroJerkMag.mean..)
    ,fBodyBodyGyroJerkMag.meanFreq..=mean(fBodyBodyGyroJerkMag.meanFreq..)
    ,angle.tBodyAccMean.gravity.=mean(angle.tBodyAccMean.gravity.)
    ,angle.tBodyAccJerkMean..gravityMean.=mean(angle.tBodyAccJerkMean..gravityMean.)
    ,angle.tBodyGyroMean.gravityMean.=mean(angle.tBodyGyroMean.gravityMean.)
    ,angle.tBodyGyroJerkMean.gravityMean.=mean(angle.tBodyGyroJerkMean.gravityMean.)
    ,angle.X.gravityMean.=mean(angle.X.gravityMean.)
    ,angle.Y.gravityMean.=mean(angle.Y.gravityMean.)
    ,angle.Z.gravityMean.=mean(angle.Z.gravityMean.)
    ,tBodyAcc.std...X=mean(tBodyAcc.std...X)
    ,tBodyAcc.std...Y=mean(tBodyAcc.std...Y)
    ,tBodyAcc.std...Z=mean(tBodyAcc.std...Z)
    ,tGravityAcc.std...X=mean(tGravityAcc.std...X)
    ,tGravityAcc.std...Y=mean(tGravityAcc.std...Y)
    ,tGravityAcc.std...Z=mean(tGravityAcc.std...Z)
    ,tBodyAccJerk.std...X=mean(tBodyAccJerk.std...X)
    ,tBodyAccJerk.std...Y=mean(tBodyAccJerk.std...Y)
    ,tBodyAccJerk.std...Z=mean(tBodyAccJerk.std...Z)
    ,tBodyGyro.std...X=mean(tBodyGyro.std...X)
    ,tBodyGyro.std...Y=mean(tBodyGyro.std...Y)
    ,tBodyGyro.std...Z=mean(tBodyGyro.std...Z)
    ,tBodyGyroJerk.std...X=mean(tBodyGyroJerk.std...X)
    ,tBodyGyroJerk.std...Y=mean(tBodyGyroJerk.std...Y)
    ,tBodyGyroJerk.std...Z=mean(tBodyGyroJerk.std...Z)
    ,tBodyAccMag.std..=mean(tBodyAccMag.std..)
    ,tGravityAccMag.std..=mean(tGravityAccMag.std..)
    ,tBodyAccJerkMag.std..=mean(tBodyAccJerkMag.std..)
    ,tBodyGyroMag.std..=mean(tBodyGyroMag.std..)
    ,tBodyGyroJerkMag.std..=mean(tBodyGyroJerkMag.std..)
    ,fBodyAcc.std...X=mean(fBodyAcc.std...X)
    ,fBodyAcc.std...Y=mean(fBodyAcc.std...Y)
    ,fBodyAcc.std...Z=mean(fBodyAcc.std...Z)
    ,fBodyAccJerk.std...X=mean(fBodyAccJerk.std...X)
    ,fBodyAccJerk.std...Y=mean(fBodyAccJerk.std...Y)
    ,fBodyAccJerk.std...Z=mean(fBodyAccJerk.std...Z)
    ,fBodyGyro.std...X=mean(fBodyGyro.std...X)
    ,fBodyGyro.std...Y=mean(fBodyGyro.std...Y)
    ,fBodyGyro.std...Z=mean(fBodyGyro.std...Z)
    ,fBodyAccMag.std..=mean(fBodyAccMag.std..)
    ,fBodyBodyAccJerkMag.std..=mean(fBodyBodyAccJerkMag.std..)
    ,fBodyBodyGyroMag.std..=mean(fBodyBodyGyroMag.std..)
    ,fBodyBodyGyroJerkMag.std..=mean(fBodyBodyGyroJerkMag.std..)
)

# write step 5 data

write.table (step5, "step5.txt", row.name=FALSE)