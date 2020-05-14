## Course Project Code Book

### Background
The datasets produced in this project utilize the UCI HAR Dataset, which contains data on Samsung accelerometer data. The orignal README and Codebook for the Data can be found in the `UCI HAR Dataset` directory. 

### Columns returned by get_mean_and_std_data():
Once the get_mean_and_std_data() function is run (see the [README](README.MD) for more info), a tibble is returned with the following columns:
* subject: A code from 1 to 30 identifing the subject who performed the activity for each window sample.
* activity: The activity the subject performed (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* aggregated measurements: The follwing 79 columns are aggregations of the measurements described in  `UCI HAR DATASET/features_info.txt`. While the original data contains several aggregates for each measurement, get_mean_and_std_data() extracts only mean and standard deviation aggregates. 

### Columns returned by get_long_mean_summary():
Once the get_long_mean_summary() funciton is run  (see the [README](README.MD) for more info), a tibble is returned with the following columns: 
* subject: A code from 1 to 30 identifing the subject who performed the activity for each window sample.
* activity: The activity the subject performed (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* measure: One of the 79 measurement aggregates that compose the last 79 columns in the tibble returned by get_mean_and_std_data() (see the above section). 
* mean value: The mean of the measurements for the given combination of subject, activity, and meaure. 

### Columns returned by get_wide_mean_summary():
Once the get_wide_mean_summary() funciton is run  (see the [README](README.MD) for more info), a tibble is returned with the following columns: 
* subject: A code from 1 to 30 identifing the subject who performed the activity for each window sample.
* activity: The activity the subject performed (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* mean measurements: The follwing 79 columns are the mean measurement value for the given combination of subject and activity. Each column will be the same as the last 79 columns in the tibble returned by get_mean_and_std_data() (see the above section), but each column will contain the prefix "mean_". 