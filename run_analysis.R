library(plyr) 
library(data.table) 
library(dplyr) 
file<- tempfile()
url<- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file)
testY <- read.table(unzip(file, "UCI HAR Dataset/test/y_test.txt"))
testX <- read.table(unzip(file, "UCI HAR Dataset/test/X_test.txt"))
testsub <- read.table(unzip(file,"UCI HAR Dataset/test/subject_test.txt"))

trainY <- read.table(unzip(file, "UCI HAR Dataset/train/y_train.txt"))
trainX <- read.table(unzip(file, "UCI HAR Dataset/train/X_train.txt"))
trainsub <- read.table(unzip(file,"UCI HAR Dataset/train/subject_train.txt"))
features <- read.table(unzip(file, "UCI HAR Dataset/features.txt"))
unlink(file)
colnames(testX)<- t(features[2])
colnames(trainX)<- t(features[2])

trainX$activities<- trainY[,1]
trainX$participants<- trainsub[,1]
testX$activities<- testY[,1]
testX$participants<- testsub[,1]

## merges train and test
data <- rbind(trainX, testX)
data<- data[,!duplicated(colnames(data))]

## find mean and std
mean <- grep("mean()", names(data), value = FALSE, fixed = TRUE)
meanmatrix<- data[mean]
std <- grep("std()", names(data), value = FALSE)
stdmatrix <- data[std]

## adding discriptive names to activites
data$activities <- as.character(data$activities)
data$activities[data$activities == 1] <- "WALKING"
data$activities[data$activities == 2] <- "WALKING_UPSTAIRS"
data$activities[data$activities == 3] <- "WALKING_DOWNSTAIRS"
data$activities[data$activities == 4] <- "SITTING"
data$activities[data$activities == 5] <- "STANDING"
data$activities[data$activities == 6] <- "LAYING"
data$activities <- as.factor(data$activities)

## use approptiate lables
names(data)<- gsub("^t", "time.", names(data))
names(data)<- gsub("^f", "freq.", names(data))
names(data)<- gsub("-", "_", names(data))
names(data)

##create tidydata
data.dt<- data.table(data)
tidydata<- data.dt[,lapply(.SD, mean), by = 'participants,activities']
write.table(tidydata, file = "Tidy.txt", row.names = FALSE)