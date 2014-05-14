## Repository for Coursera Course "Getting and Cleaning Data" by Jeff Leek.

##Files:


* run_analysis.R 
   => R script, containing the complete analysis
   Please run this script in the folder containing the unzipped data files,
   i.e. in the folder "UCI HAR Dataset"
   The script was created and tested with R 3.0.2 and RStudio 0.98.501

* tidy-data-measurements.csv 
   => tidy measurement data in CSV format (items 1 through 4 of course project),
   with headers, without row names

* tidy-data-averages.csv 
   => tidy averages in CSV format (item 5 of course project),
   with headers, without row names

* code-book.pdf 
   => code book describing the variables

##Subsetting of data:
As requested, only variables representing mean and standard deviations of 
measurements are in the final tidy data set. To achieve this, I selected
all variable names containing at least one of the following strings:
mean   Mean    std      Std
For these variables, averages (mean values) are calculated per combination
of subject and activity, the results are found in "tidy-data-averages.csv"
