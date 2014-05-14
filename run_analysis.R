##
## R script for Course Project of course course "Getting and Cleaning Data" (by Jeff Leek)
##

## temporary variable for reading only parts of data:
nRows <- 1000

## read features (for use as variable names)
features<-read.csv("features.txt",sep=" ",stringsAsFactors=FALSE,header=FALSE)
featureNames <- features[,2]

## read training data:
trainSubjects <- read.csv("train/subject_train.txt",header=FALSE)
trainLabels <- read.csv("train/y_train.txt",header=FALSE)
trainData <- read.table("train/X_train.txt",header=FALSE)
trainLabels <- as.character(trainLabels[,1])

## get rid of some carriage return/line feed sequences in labels:
trainLabels <- gsub("\n","",trainLabels)

## replace labels 1,2,3 ... by descriptive activity names:
trainLabels <- gsub("1","walking",trainLabels)
trainLabels <- gsub("2","walking-upstairs",trainLabels)
trainLabels <- gsub("3","walking-downstairs",trainLabels)
trainLabels <- gsub("4","sitting",trainLabels)
trainLabels <- gsub("5","standing",trainLabels)
trainLabels <- gsub("6","laying",trainLabels)

## add subject and label columns to "trainData" dataframe (at the beginning, i.e. to the left):
trainData <- cbind(trainLabels,trainData)
trainData <- cbind(trainSubjects,trainData)

## assign features as column names to training data:
featureNames <- c("subject","activity",featureNames)
colnames(trainData) <- featureNames

## read test data:
testSubjects <- read.csv("test/subject_test.txt",header=FALSE)
testLabels <- read.csv("test/y_test.txt",header=FALSE)
testData <- read.table("test/X_test.txt",header=FALSE)
testLabels <- as.character(testLabels[,1])

## get rid of some carriage return/line feed sequences in labels:
testLabels <- gsub("\n","",testLabels)

## replace labels 1,2,3 ... by descriptive activity names:
testLabels <- gsub("1","walking",testLabels)
testLabels <- gsub("2","walking-upstairs",testLabels)
testLabels <- gsub("3","walking-downstairs",testLabels)
testLabels <- gsub("4","sitting",testLabels)
testLabels <- gsub("5","standing",testLabels)
testLabels <- gsub("6","laying",testLabels)

## add subject and label columns to "testData" dataframe (at the beginning, i.e. to the left):
testData <- cbind(testLabels,testData)
testData <- cbind(testSubjects,testData)

## assign features as column names to training data:
colnames(testData) <- featureNames

## merge training and test data:
allData <- rbind(trainData,testData)

## extract mean and standard deviation for each measurement (plus subject and activity, of course):
coreData <- allData[,grep("subject|activity|.*mean.*|.*Mean.*|.*std.*|.*Std.",names(allData))]


coreNames <- c("subject","activity",
               "time.domain.body.acceleration.mean.x","time.domain.body.acceleration.mean.y",
               "time.domain.body.acceleration.mean.z","time.domain.body.acceleration.standard.deviation.x",
               "time.domain.body.acceleration.standard.deviation.y","time.domain.body.acceleration.standard.deviation.z",
               "time.domain.gravity.acceleration.mean.x","time.domain.gravity.acceleration.mean.Y","time.domain.gravity.acceleration.mean.z",
               "time.domain.gravity.acceleration.standard.deviation.x","time.domain.gravity.acceleration.standard.deviation.y",
               "time.domain.gravity.acceleration.standard.deviation.z","time.domain.body.acceleration.jerk.mean.x",
               "time.domain.body.acceleration.jerk.mean.Y","time.domain.body.acceleration.jerk.mean.z",
               "time.domain.body.acceleration.jerk.standard.deviation.x","time.domain.body.acceleration.jerk.standard.deviation.y",
               "time.domain.body.acceleration.jerk.standard.deviation.z","time.domain.body.gyroscope.mean.X","time.domain.body.Gyroscopmean.y",
               "time.domain.body.gyroscope.mean.z","time.domain.body.gyroscope.standard.deviation.x","time.domain.body.gyroscope.standard.deviation.y",
               "time.domain.body.gyroscope.mean.standard.deviation.z","time.domain.body.gyroscope.jerk.mean.x","time.domain.body.gyroscope.jerk.mean.y",
               "time.domain.body.gyroscope.jerk.mean.z","time.domain.body.gyroscope.jerk.standard.deviation.x","time.domain.body.gyroscope.jerk.standard.deviation.y",
               "time.domain.body.gyroscope.jerk.standard.deviation.z","time.domain.body.acceleration.magnitude.mean",
               "time.domain.body.acceleration.magnitude.standard.deviation","time.domain.gravity.acceleration.magnitude.mean",
               "time.domain.gravity.acceleration.magnitude.standard.deviation","time.domain.body.acceleration.jerk.magnitude.mean",
               "time.domain.body.acceleration.jerk.magnitude.standard.deviation","time.domain.body.gyroscope.magnitude.mean",
               "time.domain.body.gyroscope.magnitude.standard.deviation","time.domain.body.gyroscope.jerk.magnitude.mean",
               "time.domain.body.gyroscope.jerk.magnitude.standard.deviation",
               "frequency.domain.body.acceleration.mean.x","frequency.domain.body.acceleration.mean.y",
               "frequency.domain.body.acceleration.mean.z","frequency.domain.body.acceleration.standard.deviation.x",
               "frequency.domain.body.acceleration.standard.deviation.y","frequency.domain.body.acceleration.standard.deviation.z",
               "frequency.domain.body.acceleration.mean.frequency.x","frequency.domain.body.acceleration.mean.frequency.y",
               "frequency.domain.body.acceleration.mean.frequency.z","frequency.domain.body.acceleration.jerk.mean.x",
               "frequency.domain.body.acceleration.jerk.mean.y","frequency.domain.body.acceleration.jerk.mean.z",
               "frequency.domain.body.acceleration.jerk.standard.deviation.x","frequency.domain.body.acceleration.jerk.standard.deviation.y",
               "frequency.domain.body.acceleration.jerk.standard.deviation.z","frequency.domain.body.acceleration.jerk.mean.frequency.x",
               "frequency.domain.body.acceleration.jerk.mean.frequency.y","frequency.domain.body.acceleration.jerk.mean.frequency.z",
               "frequency.domain.body.gyroscope.mean.x","frequency.domain.body.gyroscope.mean.y","frequency.domain.body.gyroscope.mean.z",
               "frequency.domain.body.gyroscope.standard.deviation.x","frequency.domain.body.gyroscope.standard.deviation.y",
               "frequency.domain.body.gyroscope.standard.deviation.z","frequency.domain.body.gyroscope.mean.frequency.x",
               "frequency.domain.body.gyroscope.mean.frequency.y","frequency.domain.body.gyroscope.mean.frequency.z",
               "frequency.domain.body.acceleration.mean","frequency.domain.body.acceleration.magnitude.standard.deviation",
               "frequency.domain.body.acceleration.magnitude.mean.frequency","frequency.domain.body.body.acceleration.jerk.magnitude.mean",
               "frequency.domain.body.body.acceleration.jerk.magnitude.standard.deviation",
               "frequency.domain.body.body.acceleration.jerk.magnitude.mean.frequency","frequency.domain.body.body.gyroscope.magnitude.mean",
               "frequency.domain.body.body.gyroscope.magnitude.standard.deviation","frequency.domain.body.body.gyroscope.magnitude.mean.frequency",
               "frequency.domain.body.body.gyroscope.jerk.magnitude.mean","frequency.domain.body.body.gyroscope.magnitude.standard.deviation",
               "frequency.domain.body.body.gyroscope.magnitude.mean.frequency",
               "angleOfTimeDomainbody.acceleration.mean.gravity.","angle.of.time.domain.body.acceleration.jerk.mean.vs.gravity.mean",
               "angleOfTimeDomainbody.gyroscope.mean.vs.gravity.mean","angle.of.time.domain.body.gyroscope.jerk.mean.vs.gravity.mean",
               "angleOfXVsgravity.mean.","angle.of.y.vs.gravity.mean","angle.of.z.vs.gravity.mean")
colnames(coreData) <- coreNames

## write measurement data to CSV file:
write.csv(coreData,file="tidy-data-measurements.csv",row.names=FALSE)

## calculate average for each variable grouped by subject and activity:
require(data.table)
dt <- data.table(coreData)
coreAverages <- dt[,lapply(.SD,mean),by=list(subject,activity)]

## write averages to separate file:
write.csv(coreAverages,file="tidy-data-averages.csv",row.names=FALSE)
