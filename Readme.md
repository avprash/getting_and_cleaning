### Introduction

This script is to read all the files from UCI HAR Dataset. And the data is cleaned and transformed into a understandable format into a final table "tidy_data".

The data files are first read into their respective vectors.

The data in the vectors are then assigned with column names to make it more easy to understand the data.

The training and test data are then merged into a consolidated vector "alldata".

Now the only the needed columns which are related to mean and standard deviation are selected and aggregated into the final table called tidy_data.

