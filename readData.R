
cf <- count.fields("WebExtract.txt", sep=",", comment.char = "", quote = "\"")
d <- read.csv("WebExtract.txt", header=TRUE, stringsAsFactor=FALSE)
d$INSPDATE <- as.Date(d$INSPDATE)
d$GRADEDATE <- as.Date(d$GRADEDATE)
d$RECORDDATE <- gsub(" .*", "", d$RECORDDATE)
d$RECORDDATE <- as.Date(d$RECORDDATE)

t <- table(d$CURRENTGRADE)

