## Getting and Cleaning Data Course Project

### Background
The datasets produced in this repo utilize the [UCI HAR DATASET]("UCI HAR DATASET") on Samsung accelerometer data. The README for this dataset can be found [here]("UCI HAR DATASET/README.txt"), and the codebook for the dataset, which explains the variables can be found [here](UCI HAR DATASET/features_info.txt). 

### Requirements
Usage of the script contained in this project will require installation of the following libraries: 
* dplyr
* tidyr

### Usage
All code is located in [run_analysis.R](run_analysis.R). After running the following command, the functions in the script will become available: 
```source("run_analysis.R")```

#### Obtaining a Full, Descriptive, Clean Dataset
The function `get_mean_and_std_data()` achieves the first four requirements of the script. It:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.

The function will return a tibble, whose column descriptions can be found in the [codebook](codebook.MD). 

After sourcing the script, the function is ready for use. To see the tibble's contents, use: 
```print(get_mean_and_std_data())```

#### Obtaining Mean Aggregates based on Combinations of Subjects, Activties and Measurements
The functions `get_long_mean_summary()` and `get_wide_mean_summary()` both achieve the fifth and final requirement of the script. They: 
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

Both return tibbles with same data, but in different formats. If you wish to have the data returned in long format in which each row contains a subject, an activity, one measurement, and the mean for that measurement, use `get_long_mean_summary()`. If you wish to have the data format, in which each row contains a subject, an activity, and means for all measurements, use `get_wide_mean_summary()`. The column descriptions for both tibbles can be found in the [codebook] (codebook.MD). 

After sourcing the script, the functions are ready for use. To see the tibbles' contents, use: 

```print(get_long_mean_summary())```

or 

```print(get_wide_mean_summary())```
