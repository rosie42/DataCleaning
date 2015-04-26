# Variables 
Variables recorded are the mean values of the various measurements, means and standard deviations in the three axes (X,Y,Z).

Variable names indicate the specific variable followed by whether the source variable was a mean or standard deviation as well as the axis measured.

# Data 
Observations are recorded by subject labelled 1 through 30 as well as by activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

Values are the means calculated from the individual observations for each subject and activity.

# Transformations
The following transformations were applied:
1. Test and training sets were appended to create a single data sets
2. Columns with labels relating to mean and standard deviation were extracted via regular expression matching
3. Subject, activity and observations were merged to create a single data sets
4. Means were calculated for each variable by subject and activity