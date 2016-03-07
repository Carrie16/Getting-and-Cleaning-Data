## Set working directory
## Saved extracted data to working directory, folder UCI HAR Dataset
## Loaded needed libraries
library(data.table)
library(dplyr)
library(tidyr)
library(plyr)

## Read in used data
xtest <- read.table("USI HAR Dataset/test/X_test.txt")
subtest <- read.table("USI HAR Dataset/test/subject_test.txt")
ytest <- read.table("USI HAR Dataset/test/y_test.txt")
xtrain <- read.table("USI HAR Dataset/train/X_train.txt")
subtrain <- read.table("USI HAR Dataset/train/subject_train.txt")
ytrain <- read.table("USI HAR Dataset/train/y_train.txt")
features <- read.table("USI HAR Dataset/features.txt")
actvlabels <- read.table("USI HAR Dataset/activity_labels.txt")

## combine the activity, subject and feature data
subdata <- rbind(subtrain,subtest)
actvdata <- rbind(ytrain,ytest)
featdata <- rbind(xtrain, xtest)

## Add column names to actvdata and subdata
colnames <- (actvdata) <- "activity"
colnames <- (subdata) <- "subject"

## Assigned descriptive activity names to the activities
colnames <- (featdata) <- t(features[2])

## combine datasets into one, this was done in two parts.
data1 <- cbind(subdata,actvdata)
compdata <- cbind(data1, featdata)

## select out the mean and statndard deviation.
## done as two seperate selects then a combine
grepmean <- grep("*mean\\(\\)", names(compdata), ignore.case = TRUE, value = TRUE)
grepstd <- grep("*std\\(\\)", names(compdata), ignore.case = TRUE, value = TRUE)
selcol <- c(grepmean,grepstd, "subject", "activity")

## The grep functions returned the wanted column names.
##select out of the compdataset the selected columns.
seldata <- compdata[,selcol]

## Added activty names to the data, replacing the numeric value.
seldata$activity[seldata$activity == 1] <- as.character(actvlabels[1,2])
seldata$activity[seldata$activity == 2] <- as.character(actvlabels[2,2])
seldata$activity[seldata$activity == 3] <- as.character(actvlabels[3,2])
seldata$activity[seldata$activity == 4] <- as.character(actvlabels[4,2])
seldata$activity[seldata$activity == 5] <- as.character(actvlabels[5,2])
seldata$activity[seldata$activity == 6] <- as.character(actvlabels[6,2])
seldata$sctivity <- as.factor(seldata$activity)

## Create tidy data with the average of each varable for each activity and subject
## Calculate the mean
medata <- aggregate(.~subject + activity, seldata, mean)
## order the data
orderdata <- medata[order(medata$subject, medata$activity),]
## Created tidydata.txt
write.table(orderdata, file = "tidydata.txt", row.names = FALSE)


