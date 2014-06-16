## Reading Features
colheaders <- read.table("data/features.txt")

## Reading Testset
# Samples
xtest <- read.table("data/test/X_test.txt")

# Sampleactivity
ytest <- read.table("data/test/y_test.txt")

# Samplesubject
stest <- read.table("data/test/subject_test.txt")
