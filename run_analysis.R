# Step1. Merges the training and the test sets to create one data set.
temp1 <- read.table("/Users/shoubunetou/Downloads/UCI\ HAR\ Dataset/test/X_test.txt")
temp2 <- read.table("/Users/shoubunetou/Downloads/UCI\ HAR\ Dataset/train/X_train.txt")
X <- rbind(temp1, temp2)

temp1 <- read.table("/Users/shoubunetou/Downloads/UCI\ HAR\ Dataset/test/y_test.txt")
temp2 <- read.table("/Users/shoubunetou/Downloads/UCI\ HAR\ Dataset/train/y_train.txt")
y <- rbind(temp1, temp2)

temp1 <- read.table("/Users/shoubunetou/Downloads/UCI\ HAR\ Dataset/test/subject_test.txt")
temp2 <- read.table("/Users/shoubunetou/Downloads/UCI\ HAR\ Dataset/train/subject_train.txt")
subject <- rbind(temp1, temp2)

# Step2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("/Users/shoubunetou/Downloads/UCI\ HAR\ Dataset/features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, indices_of_good_features]
names(X) <- features[indices_of_good_features, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("/Users/shoubunetou/Downloads/UCI\ HAR\ Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
y[,1] = activities[y[,1], 2]
names(y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(subject) <- "subject"
cleaned <- cbind(subject, y, X)
write.table(cleaned, "merged_clean_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(subject)[,1]
numSubjects = length(unique(subject)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
        for (a in 1:numActivities) {
                result[row, 1] = uniqueSubjects[s]
                result[row, 2] = activities[a, 2]
                tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
                result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
                row = row+1
        }
}
write.table(result, "/Users/shoubunetou/Downloads/UCI\ HAR\ Dataset/data_set_with_the_averages.txt")
