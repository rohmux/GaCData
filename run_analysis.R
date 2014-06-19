## Reading Features and fixing names (remove "-" "()")
colheaders <- read.table("data/features.txt")
colheaders[,2] <- gsub("[-(),]", "", colheaders[,2])

getdataset <- function(type){
    path <- paste("data/",type,"/", sep ="")
    ## Reading Testset
    # Samples
    xset <- data.frame(read.table(paste(path, "X_", type, ".txt", sep ="")))
    
    # Sampleactivity
    yset <- read.table(paste(path, "y_", type, ".txt", sep =""))
    
    # Samplesubject
    subjectnr <- read.table(paste(path, "subject_", type, ".txt", sep =""))
    
    # Assigning the Features Column 2 as Variablenames to xset (Column 1 is just a numeration, Column 2 is the real name)
    names(xset) <- tolower(colheaders[,2])
    
    # Stripping out unwanted Variables
    toMatch <- c("mean", "std")
    names(xset[, grep(paste(toMatch,collapse="|"), names(xset))])
    
    # Merge Subject and Activity with Samples
    xset <- cbind(subjectnr, yset, xset)
    names(xset)[1] <- "subjectnr"
    names(xset)[2] <- "activity"
    xset
}

trainset <- getdataset("train")
testset <- getdataset("test")
