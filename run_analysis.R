#path <- paste("local folder path")

allfiles <- list.files(path, recursive = TRUE)
#read train data
xtrain <- read.table(file.path(path,"train","X_train.txt"), header = FALSE)
ytrain <- read.table(file.path(path,"train","y_train.txt"), header = FALSE)
subtrain <- read.table(file.path(path,"train","subject_train.txt"), header = FALSE)
#read test data
xtest <- read.table(file.path(path,"test","X_test.txt"), header = FALSE)
ytest <- read.table(file.path(path,"test","y_test.txt"), header = FALSE)
subtest <- read.table(file.path(path,"test","subject_test.txt"), header = FALSE)
#Read activity labels
act_lab <- read.table(file.path(path,"activity_labels.txt"), header = FALSE)
#Read features 
features <- read.table(file.path(path,"features.txt"), header = FALSE)
#cleanup the column names 
#for train data
colnames(xtrain) <- features[,2]
colnames(ytrain) <- "ActivityID"
colnames(subtrain) <- "SubjectID"
#for test data
colnames(xtest) <- features[,2]
colnames(ytest) <- "ActivityID"
colnames(subtest) <- "SubjectID"
colnames(act_lab) <- c("ActivityID", "Activity")
#Merge train and test data
xytrain <- cbind(ytrain,subtrain,xtrain)
xytest <- cbind(ytest,subtest,xtest)
alldata <- rbind(xytrain,xytest)
#Mean and standard deviation dataset
columns <- colnames(alldata)
mn_std_var <- (grepl("ActivityID", columns)|grepl("SubjectID", columns)|grepl("mean..",columns)|grepl("std..", columns))
mn_std_data <- alldata[,mn_std_var==TRUE]
#Add activity descirptions
mn_std_act_data <- merge(mn_std_data, act_lab, by = "ActivityID", all.x = TRUE)
#Tidy data
tidy_data <- aggregate(.~SubjectID + ActivityID + Activity, mn_std_act_data, mean)
tidy_data <- tidy_data[order(tidy_data$SubjectID, tidy_data$ActivityID, tidy_data$Activity),]

