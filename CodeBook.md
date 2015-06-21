# Coursera_Getting_And_Cleaning_Data
Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

run_analysis.R cleans up the data as following:

* Merges the training and test sets to create one data set.

* Reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement. .

* Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set.

* The script also appropriately labels the data set with descriptive names: all feature names (attributes) and activity names are converted to lower case, underscores and brackets () are removed. Then it merges the 10299x66 data frame containing features with 10299x1 data frames containing activity labels and subject IDs. The result is saved as merged_clean_data.txt.

* Finally, the script creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject. The result is saved as data_set_with_the_averages.txt.
