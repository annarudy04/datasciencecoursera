library(dplyr)
library(tidyr)

# Set up global variables needed by multiple functions
data_path <-"UCI HAR Dataset/"
variables_names <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels)[2] <- "activity"

col_bind_data <- function(data_type){
# Bind X, y, and subject data column-wise
# Args:
#   data_type: The type of data ("test" or "training")
  
  # Read in the measurement data, and change the columns to the measurement names
  # found in the variables df. 
  x <- read.table(paste0(data_path, data_type, "/X_", data_type, ".txt"))
  names(x) <-variables$V2 
  # Read in the activity data, merge it with activity_lables, and select only
  # the descriptive activity name. 
  y <- read.table(paste0(data_path, data_type, "/y_", data_type, ".txt")) 
  y <- merge(activity_labels, y, by="V1")["activity"]
  # Read in the subject data and rename its column to subject. 
  subjects <- read.table(paste0(data_path, data_type, "/subject_", data_type, ".txt"))
  names(subjects) <- "subject"
  # Bind all data column wise. 
  bound_data <-cbind.data.frame(subjects, y, x)
}

get_full_data <- function(){
# Binds training and test data column wise, then binds the results row wise.
  train_bound_data <-col_bind_data("train")
  test_bound_data <-col_bind_data("test")
  full_data <- rbind.data.frame(train_bound_data, test_bound_data)
}

get_mean_and_std_data <- function(){
# Extracts mean and standard deviation aggregates from the full dataset. 
  full_data <- get_full_data()
  # Find all columns with "mean" or "std"
  mean_and_std_cols <- grep("mean|std", names(full_data), value = TRUE)
  # Select these columns, along with the first two "subject" and "activity" columns
  mean_and_std_data <- full_data[,append(c("subject", "activity"),mean_and_std_cols)]
  # Cast measurement columns to numeric
  numeric_cols <- 3:length(mean_and_std_data)
  mean_and_std_data[numeric_cols] <- sapply(mean_and_std_data[numeric_cols], as.numeric)
  mean_and_std_data
}

get_long_mean_summary <- function(){
# Returns summarized mean data in long format. 
  # Get the full mean and std dataset
  mean_and_std_data <- get_mean_and_std_data()
  # Convert the data into long format
  longer_data <- pivot_longer(
    mean_and_std_data, 
    -c(subject, activity), 
    names_to="measure", 
    values_to="value"
  )
  # Group the long data by combinations of subject, activity, and measure
  grp_longer <- group_by(longer_data, subject, activity, measure)
  # Get the mean for each group
  mean_summary_long <- summarize(grp_longer, mean_value=mean(value))
}

get_wide_mean_summary <-function(){
# Returns summarized mean data in wide format. 
  # Get the full mean and std dataset
  mean_and_std_data <- get_mean_and_std_data()
  # Get the long mean summary
  mean_summary_long <- get_long_mean_summary()
  # Convert the long mean summary to wide format
  mean_summary_wide <- pivot_wider(
    mean_summary_long, 
    names_from=measure, 
    values_from=mean_value
  )
  # Note, instead of getting the long summary and widening, 
  # you could have used:
  # mean_summary_wide <- aggregate(. ~subject + activity, mean_and_std_data, mean)
  # or:
  # mean_summary_wide <- mean_and_std_data %>%
  #       group_by(subject, activity) %>% 
  #       summarize_all(mean)
  
  # Add the prefix "_mean" to each measurement column
  names(mean_summary_wide)[numeric_cols] = paste0(
    "mean_", 
    names(mean_summary_wide[numeric_cols])
  )
  mean_summary_wide
}