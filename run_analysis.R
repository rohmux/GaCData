library(reshape)
library(reshape2)
## Reading Features and fixing names (remove "-" "()")
colheaders <- read.table("data/features.txt")
colheaders[,2] <- gsub("[-(),]", "", colheaders[,2])
colheaders[,2] <- gsub("fBody", "frequencybody", colheaders[,2])
colheaders[,2] <- gsub("tBody", "timedbody", colheaders[,2])
colheaders[,2] <- gsub("Acc", "acceleration", colheaders[,2])
colheaders[,2] <- gsub("Gyro", "gyroscope", colheaders[,2])
colheaders[,2] <- gsub("tGravity", "timedgravity", colheaders[,2])
colheaders[,2] <- gsub("bodybody", "body", colheaders[,2])

## Reading activity labels
actlabels <- read.table("data/activity_labels.txt")

getdataset <- function(type){
    path <- paste("data/",type,"/", sep ="")
    ## Reading Testset
    # Samples
    xset <- data.frame(read.table(paste(path, "X_", type, ".txt", sep ="")))
    
    # Sampleactivity
    yset <- read.table(paste(path, "y_", type, ".txt", sep =""))
    
    # Samplesubject
    subjectnr <- read.table(paste(path, "subject_", type, ".txt", sep =""))
    
    # Assigning the Features Column 2 for Variablenames to xset (Column 1 is just a numeration, Column 2 is the real name)
    names(xset) <- tolower(colheaders[,2])
    
    # Stripping out unwanted Variables
    toMatch <- c("mean", "std")
    xset <- xset[, grep(paste(toMatch,collapse="|"), names(xset))]
    
    # Merge Subject and Activity with Samples
    xset <- cbind(subjectnr, yset, xset)
    names(xset)[1] <- "subjectnr"
    names(xset)[2] <- "activity"
    
    # Replace activity numbers by its label
    for(i in 1:6){
        replacestring <- actlabels[i,2]
        xset$activity[xset$activity == i] <- as.character(replacestring)
    }
    
    # Add Column of set type (train or test)
    xset <- data.frame(settype = type, xset)
    
    xset
}

# Merges Training and Testset
mergeset <- function(set1, set2){
    mergedset <- rbind(set1, set2)
    
    mergedset
}

# Just write the dataset into a file calles meanvalues.txt
writeset <- function(ds){
    if(!file.exists("data/meanvalues.txt")){
        write.csv(ds, file="data/meanvalues.txt")
        "file written"
    }
    else{
        "file exists"
    }
}

createtidyset <- function(ds){
    moltenset <- melt(ds, id=c("activity", "subjectnr", "settype"), measure.vars=c(4:89))
    tidyset <- cast(moltenset, subjectnr+activity~variable, mean)
    tidyset
}

trainset <- getdataset("train")
testset <- getdataset("test")
mergedset <- mergeset(trainset, testset)
tidyset <- createtidyset(mergedset)
writeset(tidyset)