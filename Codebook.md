# Codebook 

## Source data

The source data and details can be found in this link: https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones.
The data for this project has been downloaded from this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Details of the files can be found in the README.txt distributed along with the data set:
* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


## run_analysis.R script
The script reads the data and performs some transformations as requested by the instructions of the Peer-graded Assignment: Getting and Cleaning Data Course Project.

1. Download the dataset
Manually downloaded the dataset

2. Data set consolidation
* reads the function names from the file features.txt into features variable
* reads the training data and creates the following tables:
  * xtraining from the file train/X_train.txt - measurements
  * ytraining from the file train/y_train.txt - activity id of each measurement
  * straining from the file train/subject_train.txt - subjects of each measurement
* reads the test data and creates the following tables:
  * xtest from the file test/X_test.txt - measurements
  * ytest from the file test/y_test.txt - activity id of each measurement
  * stest from the file test/subject_test.txt - subjects of each measurement
* concatenates the data:
  * subjects (straining and stest)
  * measurements (xtraining and xtest)
  * activity (ytraining and ytest)
* binds the 3 tables above to generate the dataframe step1

3. Extracts only the measurements on the mean and standard deviation for each measurement. 
Data frame step2 is created by selecting the columns subject, activity, plus all other columns that contain mean or std in their names.

4. Uses descriptive activity names to name the activities in the data set
Loads the activity list and updates the activity id, replacing it with the activity description.
The second column contains now the activity (for instance LAYING, instead of its id which is 6)

5. Appropriately labels the data set with descriptive variable names. 
* While loading the data into xtraining and xtest, the column names are updated from the file features.txt, so they are descriptive
* That helps the column filtering later, so only the columns with mean and std names are selected.
* Also I update the column names of the consolidated data set, so it has the subject as the 1st column name and activity description as the 2nd column name.

6. Create a second, independent tidy data set with the average of each variable for each activity and each subject
* Used the data frame step2 to create the data frame step5.
* group by subject and activity, and calculated the mean for all features
* write the output and generates the file step5.txt uploaded