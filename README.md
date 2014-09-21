Coursera-Getting-and-cleaning-Data-Course-Project
=================================================

This repository contains my work for the course project for the Coursera course "Getting and Cleaning data", 
part of the Data Science specialization.
================================================

Overview

This project serves to demonstrate the collection and cleaning of a tidy data set that can be used for subsequent analysis.
A full description of the data used in this project can be found at The UCI Machine Learning Repository
The source data for this project can be found here.
=================================================
Making Modifications to This Script

Once you have obtained and unzipped the source files, you will need to make one modification to the R file before
you can process the data. Note that you will set the path of the working directory to relect
the location of the source files in your own directory at the required lines in the code(reading the text files)
================================================
About the script and the tidy dataset

I created a script called run_analysis.R which will merge the test and training sets together. Prerequisites for this script:

the UCI HAR Dataset must be extracted and..
the UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset"
After merging testing and training, labels are added and only columns that have to do with mean and standard deviation are kept.

Lastly, the script will create a tidy data set containing the means of all the columns per test subject and per activity. 
This tidy dataset will be written to a tab-delimited file called tidydata.txt, which can also be found in this repository.
================================================
About the Code Book

The CodeBook.md file explains the transformations performed and the resulting data and variables.
