# GaCData Readme

## Summary
Repo for the Getting and Cleaning Data Coursera course project.
Repo link (github) -> https://github.com/rohmux/GaCData

## Data analyzed for this project
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## How to store the data
Extract data inside of the working directory and rename the folder to "data" (it's easier to deal with simple pathnames)

## How to get the tidy data set for the course project
run the R-Script run_analysis.R (script must be in the working directory where the data folder has been prepared, described above)
All function calls are in the script and the tidy data set file "meanvalues.txt" will be written inside the "data" directory

## What the script does
### Description of the golbal variables

#### colheaders (list)
Used for the names of all columns inside the dataset and will just read in all names from the "features.txt" file inside the "data" directory.
The names will be changed in the following way:
1. remove following characters (without the quotes) '[]-()'
2. change "fBody" to "frequencybody" (Jeff wants some descriptive names)
3. change "tBody" to "timedbody"
4. change "Acc" to "acceleration"
5. change "Gyro" to Gyroscope
6. change "tGravity" to "timedgravity"
7. change "bodybody" to "body" (one is enough)

#### actlabels (list)
Contains all activity labels


### Description of the functions
#### getdataset
This will read in the dataset and remove all unwanted variables (the ones without "mean", or "std" in the name) and turn them to lowercase (Jeff likes it this way).
It will also add a column for subject (number), one for the activity (character) and one for the settype (character)

Arguments:
settype ("train" or "test")

Return: (list)
stripped dataset for one settype (train or test)

#### mergeset
If you have two sets ("train" and "test") this will merge them together (simply adds all rows together)

Arguments:
two lists ("train" and "test")

Return: (list)
merged dataset for (train and test)

#### writeset
Just checks if the target file "data/meanvalues" exists and if not write the dataset into this file, if not, do nothing.

Arguments:
tidydataset (created from the merged one)

Return:
Characterstring "File written" (if not exists) or "file exists" (if already exists).

#### createtidyset
Creates a tidy set by meltin the set by ids "activity", "subjectnr" and "settype" and then cast it to a tidy data set with all mean variables ordered by subjectnr and activity and then by variable

Arguments:
ds (created from the createtidyset function)

Return: (list)
Tidy data set according the coursera project goal.

### Following code will finaly give you the tidy dataset and write it as csv (ends with txt) to your harddrive
trainset <- getdataset("train")

testset <- getdataset("test")

mergedset <- mergeset(trainset, testset)

tidyset <- createtidyset(mergedset)

writeset(tidyset)

## Further information
Details of the variables are documented in the CodeBook.md