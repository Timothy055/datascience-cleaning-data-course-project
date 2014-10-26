
#Create the column headers for all the data we will read in.
feature.col.names <- read.table("features.txt")[, 2]
subject.col.names <- c("subject.id")
activity.col.names <- c("activity")

#Read in the training and test files.
training.files <- list.files(path="train", pattern=".txt", all.files=TRUE, full.names=TRUE);
test.files <- list.files(path="test", pattern=".txt", all.files=TRUE, full.names=TRUE);

# This is a function which reads the data and applies the appropriate column names
# based on the file name. For example a file with the word sujbect in it would be assumed
# to be the subject data file and it will be read in with the subject column names.
read.data.files <- function(file.name) {
  if (grepl("subject", file.name)) {
    print(paste("Reading", file.name))
    subject.data <- read.table(file.name, header=FALSE, col.names=subject.col.names)
  } else if (grepl("X", file.name)) {
    print(paste("Reading", file.name))
    X.data <- read.table(file.name, header=FALSE, col.names=feature.col.names)
  } else if (grepl("y", file.name)) {
    print(paste("Reading", file.name))
    y.data <- read.table(file.name, header=FALSE, col.names=activity.col.names)
  }
}

#Read in all the training data files and combine into a single data.frame.
training.data <- data.frame(lapply(training.files, read.data.files))

#Read in all the test data files and combine into a single data.frame
test.data <- data.frame(lapply(test.files, read.data.files))

# The combined data is an rbind of the training and test data.
# This assumes that both directories contain files with the same naming conventions
# and are traversed in alphabetical order.
combined.data <- rbind(training.data, test.data)

#Convert activity.id to factor with labels
activity.factors <- read.table("activity_labels.txt", col.names=c("id", "level"))
combined.data$activity <- as.factor(combined.data$activity)
levels(combined.data$activity) <- activity.factors$level

#Select any columns with mean or std in their name, plus the subject and activity columns.
selected.cols <- grepl("mean|std|subject|activity", names(combined.data))

selected.data <- combined.data[, selected.cols]

# Melt the data for later summarization
melted.data <- melt(selected.data, id=c("activity", "subject.id"))

# Next, we average the values for each subject and activity pair.
cleaned.data <- dcast(melted.data, activity + subject.id ~ variable, mean)

# Last, we write the data to file
write.table(cleaned.data, "cleaned_activity_data.txt", row.name=FALSE)


