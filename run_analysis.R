## Reading Features
colheaders <- read.table("data/features.txt")

## Reading Testset
# Samples
xtest <- data.frame(read.table("data/test/X_test.txt"))

# Sampleactivity
ytest <- read.table("data/test/y_test.txt")

# Samplesubject
stest <- read.table("data/test/subject_test.txt")

# Assigning the Features Column 2 as Variablenames to xtest (Column 1 is just a numeration, Column 2 is the real name)
names(xtest) <- tolower(colheaders[,2])

# Merge Subject and Activity with Samples
xtest <- cbind(stest, ytest, xtest)
names(xtest)[1] <- "subjectnr"
names(xtest)[2] <- "activity"
