##Created for 'Getting and Cleaning Data' course, Mar 2015

##Note: ensure that the working directory contains the 'UCI HAR Dataset' director
##Note: ensure that the dplyr package is installed

library(dplyr)
##function for nameing the activities
name_act <- function(n){
  activity <- NULL
  if(n == 1)
    activity <- "Walking"
  else if (n == 2)
    activity <- "Walking_Upstairs"
  else if (n == 3)
    activity <- "Walking_Downstairs"
  else if (n == 4)
    activity <- "Sitting"
  else if (n == 5)
    activity <- "Standing"
  else if (n == 6)
    activity <- "Laying"
  activity
}##name_act

##Reading in the train data and processing
f <- read.table("UCI HAR Dataset/features.txt")
f <- as.character(f$V2)
f <- make.names(f, unique = TRUE)
x <- read.table("UCI HAR Dataset/train/X_train.txt")
names(x) <- f ##naming variables Part 4
##selecting all columns with mean or std Part 2
x <- select(x, contains("mean", ignore.case = TRUE), contains("std", ignore.case = TRUE))
y <- read.table("UCI HAR Dataset/train/y_train.txt")
s <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(s) <- "subject"
train <- mutate(s, activity.Num = y$V1)
train <- cbind(train, x)
rm(x, y, s) ## removing to save memory


##Reading in the test data and processing
x <- read.table("UCI HAR Dataset/test/X_test.txt")
names(x) <- f ##naming variables Part 4
##selecting all columns with mean or std Part 2
x <- select(x, contains("mean", ignore.case = TRUE), contains("std", ignore.case = TRUE))
y <- read.table("UCI HAR Dataset/test/y_test.txt")
s <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(s) <- "subject"
test <- mutate(s, activity.Num = y$V1)
test <- cbind(test, x)
rm(x, y, s, f) ## removing to save memory


##Merging and arranging the data files Part 1
total <- rbind(train, test)
total <- arrange(total, subject, activity.Num)


##creating tidy data set Part 5
tidy <- NULL
for (i in 1:30){
  temp <- filter(total, subject == i)
  for (j in 1:6){
    temp2 <- filter(temp, activity.Num == j)
    temp2 <- t(colMeans(select(temp2, 3:ncol(temp2))))
    x <- data.frame(subject = i, activity = name_act(j)) ## renaming the activities: Part 3
    temp2 <- cbind(x, temp2)
    tidy <- rbind(tidy, temp2)
  }##for j
}##for i

##writing tidy data
write.table(tidy, file = "tidy_data.txt", row.names = FALSE, col.names = FALSE)
rm(temp, temp2, test, train, x, i, j)