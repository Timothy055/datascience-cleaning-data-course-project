#Cleaning Smarthphone Activity Data

This project hosts a script (run\_analysis.R) which reads a dataset published by Samsung called "Human Activity Recognition Using Smartphones" to create a cleaned dataset.  This script was written as part of the course project for the Data Science specialization on Coursera.

The data set can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

##Running the script

The run\_analysis.R script assumes that all data is in the current working director of the script and that you have the the reshape2 package installed.  If you do not, just run the command:
`install.packages("reshape2")` from your R prompt.

This script will assume that the original directory structure remains in-tact, so please do not move or re-name any files.

Source the file in your R command prompt to run the script using the command:

`source("run_analysis.R")`

When complete, the script will write a file called cleaned\_activity\_data.txt in the same directory.

