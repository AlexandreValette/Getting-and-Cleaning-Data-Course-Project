library(dplyr)

## 1. Merges the training and the test sets to create one data set.

# Read features.txt to get signal names
features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activityId","activityName"))

# Read table and assign column names
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
x_test  <- read.table("./UCI HAR Dataset/test/X_test.txt" , col.names = features[,2])
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("activityId"))
y_test  <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("activityId"))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subjectId"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subjectId"))

# Merge train data and test data
train <- bind_cols(x_train, y_train, subject_train)
test <- bind_cols(x_test, y_test, subject_test)

# Keep track of slit category in the newly created splitCategory column
train <- mutate(train, splitCategory = "train")
test <-  mutate(test,  splitCategory = "test")
  
# Merge train and test
df <- bind_rows(train, test)

# Replace activity Id by activity Name
df$activityName <- sapply(df$activityId, function(x) {activities[x,2]})

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
featuresWanted <- grep("[.][Mm]ean[.]|[.][Ss]td[.] |activityName|subjectId|splitCategory", names(df), value=TRUE )
# NB: this excludes signals containing *meanFreq*. The exercice is not very clear if those should be contain or not.
# Perform the extraction
extracts <- df[,featuresWanted]

## 3. Uses descriptive activity names to name the activities in the data set
# Already done in line 30

## 4. Appropriately labels the data set with descriptive variable names. 
new_names <- gsub("[.]{2,}", ".", names(extracts))
new_names <- gsub("[.]$", "", new_names)
new_names <- gsub("[.]mean", ".Mean", new_names)
new_names <- gsub("[.]std", ".Std", new_names)
names(extracts) <- new_names

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
extracts.melted <- melt(extracts, id = c("subjectId","activityName", "splitCategory"))

extracts.mean <- extracts.melted %>% 
  group_by(subjectId, activityName, variable) %>%
  summarise(mean = mean(value))

# Output dataframe to tidy.txt
write.table(extracts.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
