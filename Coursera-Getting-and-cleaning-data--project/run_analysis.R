# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Installing and getting required package
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

if (!require("dplyr")) {
  install.packages("dplyr")
}


require("data.table")
require("reshape2")
require("plyr")

# Set working directory
setwd("D:/Users/ZHIYONG/Desktop/getting-and-cleaning-data-course-project/Getting-and-cleaning-data-course-project")

# Reading files into data table
activityLabel <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
subjectTrain  <-read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
xTrain  <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
yTrain  <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
subjectTest <-read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
xTrainHeader <-read.table("./UCI HAR Dataset/features.txt",header=FALSE)

# Assigning column names
colnames(activityLabel) <- c("activityID","activityName")

colnames(subjectTrain) <- c("subjectID")
colnames(xTrain) <- xTrainHeader[,2]
colnames(yTrain) <- c("activityID")

colnames(subjectTest) <- c("subjectID")
colnames(xTest) <- xTrainHeader[,2]
colnames(yTest) <- c("activityID")

### 1. Merges the training and the test sets to create one data set
# Merge training and testing data by column
trainData <- cbind(subjectTrain,xTrain,yTrain)
testData <- cbind(subjectTest,xTest,yTest)

# Merge training and testing data
mergedData <- rbind(trainData,testData)

### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
data  <-mergedData[,grepl("mean|std|subjectID|activityID",colnames(mergedData))]

### 3. Uses descriptive activity names to name the activities in the data set
data <- join(data, activityLabel, by = "activityID", match = "first")[,-1]

### 4. Appropriately labels the data set with descriptive variable names. 
colnames(data) <- gsub("[^[:alpha:]]", " ", colnames(data))
colnames(data) <- gsub("\\s+", "_", colnames(data))

### 5. From the data set in step 4, creates a second, independent tidy data set with 
###    the average of each variable for each activity and each subject.
dataActSub_mean <- aggregate(. ~ subjectID + activityName data=data, mean)

# Output data
write.table(dataActSub_mean,file="output.txt")
