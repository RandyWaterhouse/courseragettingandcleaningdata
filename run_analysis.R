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
               "timeDomainBodyAccelerationMeanX","timeDomainBodyAccelerationMeanY",
               "timeDomainBodyAccelerationMeanZ","timeDomainBodyAccelerationStandardDeviationX",
               "timeDomainBodyAccelerationStandardDeviationY","timeDomainBodyAccelerationStandardDeviationZ",
               "timeDomainGravityAccelerationMeanX","timeDomainGravityAccelerationMeanY","timeDomainGravityAccelerationMeanZ",
               "timeDomainGravityAccelerationStandardDeviationX","timeDomainGravityAccelerationStandardDeviationY",
               "timeDomainGravityAccelerationStandardDeviationZ","timeDomainBodyAccelerationJerkMeanX",
               "timeDomainBodyAccelerationJerkMeanY","timeDomainBodyAccelerationJerkMeanZ",
               "timeDomainBodyAccelerationJerkStandardDeviationX","timeDomainBodyAccelerationJerkStandardDeviationY",
               "timeDomainBodyAccelerationJerkStandardDeviationZ","timeDomainBodyGyroscopMeanX","timeDomainBodyGyroscopMeanY",
               "timeDomainBodyGyroscopMeanZ","timeDomainBodyGyroscopStandardDeviationX","timeDomainBodyGyroscopStandardDeviationY",
               "timeDomainBodyGyroscopMeanStandardDeviationZ","timeDomainBodyGyroscopJerkMeanX","timeDomainBodyGyroscopJerkMeanY",
               "timeDomainBodyGyroscopJerkMeanZ","timeDomainBodyGyroscopJerkStandardDeviationX","timeDomainBodyGyroscopJerkStandardDeviationY",
               "timeDomainBodyGyroscopJerkStandardDeviationZ","timeDomainBodyAccelerationMagnitudeMean",
               "timeDomainBodyAccelerationMagnitudeStandardDeviation","timeDomainGravityAccelerationMagnitudeMean",
               "timeDomainGravityAccelerationMagnitudeStandardDeviation","timeDomainBodyAccelerationJerkMagnitudeMean",
               "timeDomainBodyAccelerationJerkMagnitudeStandardDeviation","timeDomainBodyGyroscopeMagnitudeMean",
               "timeDomainBodyGyroscopeMagnitudeStandardDeviation","timeDomainBodyGyroscopeJerkMagnitudeMean",
               "timeDomainBodyGyroscopeJerkMagnitudeStandardDeviation",
               "frequencyDomainBodyAccelerationMeanX","frequencyDomainBodyAccelerationMeanY",
               "frequencyDomainBodyAccelerationMeanZ","frequencyDomainBodyAccelerationStandardDeviationX",
               "frequencyDomainBodyAccelerationStandardDeviationY","frequencyDomainBodyAccelerationStandardDeviationZ",
               "frequencyDomainBodyAccelerationMeanFrequencyX","frequencyDomainBodyAccelerationMeanFrequencyY",
               "frequencyDomainBodyAccelerationMeanFrequencyZ","frequencyDomainBodyAccelerationJerkMeanX",
               "frequencyDomainBodyAccelerationJerkMeanY","frequencyDomainBodyAccelerationJerkMeanZ",
               "frequencyDomainBodyAccelerationJerkStandardDeviationX","frequencyDomainBodyAccelerationJerkStandardDeviationY",
               "frequencyDomainBodyAccelerationJerkStandardDeviationZ","frequencyDomainBodyAccelerationJerkMeanFrequencyX",
               "frequencyDomainBodyAccelerationJerkMeanFrequencyY","frequencyDomainBodyAccelerationJerkMeanFrequencyZ",
               "frequencyDomainBodyGyroscopeMeanX","frequencyDomainBodyGyroscopeMeanY","frequencyDomainBodyGyroscopeMeanZ",
               "frequencyDomainBodyGyroscopeStandardDeviationX","frequencyDomainBodyGyroscopeStandardDeviationY",
               "frequencyDomainBodyGyroscopeStandardDeviationZ","frequencyDomainBodyGyroscopeMeanFrequencyX",
               "frequencyDomainBodyGyroscopeMeanFrequencyY","frequencyDomainBodyGyroscopeMeanFrequencyZ",
               "frequencyDomainBodyAccelerationMean","frequencyDomainBodyAccelerationMagnitudeStandardDeviation",
               "frequencyDomainBodyAccelerationMagnitudeMeanFrequency","frequencyDomainBodyBodyAccelerationJerkMagnitudeMean",
               "frequencyDomainBodyBodyAccelerationJerkMagnitudeStandardDeviation",
               "frequencyDomainBodyBodyAccelerationJerkMagnitudeMeanFrequency","frequencyDomainBodyBodyGyroscopeMagnitudeMean",
               "frequencyDomainBodyBodyGyroscopeMagnitudeStandardDeviation","frequencyDomainBodyBodyGyroscopeMagnitudeMeanFrequency",
               "frequencyDomainBodyBodyGyroscopeJerkMagnitudeMean","frequencyDomainBodyBodyGyroscopeMagnitudeStandardDeviation",
               "frequencyDomainBodyBodyGyroscopeMagnitudeMeanFrequency",
               "angleOfTimeDomainBodyAccelerationMeanGravity","angleOfTimeDomainBodyAccelerationJerkMeanVsGravityMean",
               "angleOfTimeDomainBodyGyroscopeMeanVsGravityMean","angleOfTimeDomainBodyGyroscopeJerkMeanVsGravityMean",
               "angleOfXVsGravityMean","angleOfYVsGravityMean","angleOfZVsGravityMean")
colnames(coreData) <- coreNames

## write measurement data to CSV file:
write.csv(coreData,file="tidy-data-measurements.csv",row.names=FALSE)

## calculate average for each variable grouped by subject and activity:
require(data.table)
dt <- data.table(coreData)
coreAverages <- dt[,lapply(.SD,mean),by=list(subject,activity)]

## write averages to separate file:
write.csv(coreAverages,file="tidy-data-averages.csv",row.names=FALSE)
