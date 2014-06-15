## 1) Merges the training and the test sets to create one data set.
 
testSubj = read.table("UCI HAR Dataset/test/subject_test.txt")                       
testSet = read.table("UCI HAR Dataset/test/X_test.txt") 
testLabels = read.table("UCI HAR Dataset/test/y_test.txt")
trainSubj = read.table("UCI HAR Dataset/train/subject_train.txt")                       
trainSet = read.table("UCI HAR Dataset/train/X_train.txt")
trainLabels = read.table("UCI HAR Dataset/train/y_train.txt")

## Test dataset
setwd("./UCI HAR Dataset/test/Inertial Signals")
temp1 = list.files (pattern="*.txt")	
myfilesTest = lapply (temp1, read.table)
Test <- data.frame (myfilesTest)             
dbtest <- data.frame(testSet,testSubj,testLabels,Test)

## Train dataset
setwd("/Users/coursera/getDataPrg/UCI HAR Dataset/train/Inertial Signals")
temp2 = list.files (pattern="*.txt")	
myfilesTrain = lapply (temp2, read.table)
Train <- data.frame (myfilesTrain)              
dbtrain <- data.frame(trainSet,trainSubj,trainLabels,Train)

## COMPLETE DATASET
db <- rbind (dbtest, dbtrain)
                                                 
                                                
## 2. 3. 4. Extracts only the measurements on the mean and standard deviation for each measurement, labels dataset, activity descriptions

setwd("/Users/coursera/getDataPrg/UCI HAR Dataset")

## Selects and names mean
labels = read.table("features.txt") 
vecMean <- labels[grep("mean", labels[,2]), ]
colMean <- c(vecMean [ , 1])
labMean <- vecMean [ , 2]
labMeanok <- c(gsub ("-", "",labMean))
dbselMean <- db[,colMean]
names(dbselMean) <- labMean 

## Selects and names std
vecStd <- labels[grep("std", labels[,2]), ]
colStd <- c(vecStd [ , 1])
labStd <- vecStd [ , 2]
labStdok <- c(gsub ("-", "",labStd))
dbselStd <- db[,colStd]
names(dbselStd) <- labStd

dbSubAct <- db[,562:563]
names(dbSubAct) <- c ("subject", "activity")

## complete selected dataset
dbsel <- data.frame(dbSubAct,dbselMean,dbselStd)

## aggregate and mean value
aggdata <-aggregate(dbsel, by=list(dbsel$activity,dbsel$subject), FUN=mean, na.rm=TRUE)

## activity desciptive names
aggdata$activity[aggdata$activity == "1"] <- "WALKING"
aggdata$activity[aggdata$activity == "2"] <- "WALKING_UPSTAIRS"
aggdata$activity[aggdata$activity == "3"] <- "WALKING_DOWNSTAIRS"
aggdata$activity[aggdata$activity == "4"] <- "SITTING"
aggdata$activity[aggdata$activity == "5"] <- "STANDING"
aggdata$activity[aggdata$activity == "6"] <- "LAYING"

## aggregate and mean, create a new data set

aggdata <-aggregate(dbsel, by=list(dbsel$activity,dbsel$subject), FUN=mean, na.rm=TRUE)
tidyData <- aggdata[,3:83]
write.table(tidyData, "tidydata.txt", sep="\t")

