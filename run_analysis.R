library(dplyr)

merge_sets <- function() {
  
  # File path
  file_x_train = "./UCI HAR Dataset/train/X_train.txt"
  file_y_train = "./UCI HAR Dataset/train/y_train.txt"
  file_x_test  = "./UCI HAR Dataset/test/X_test.txt"
  file_y_test  = "./UCI HAR Dataset/test/y_test.txt"
  
  y_train <- fread(file_y_train)
  
}