dataFile <- "data/WebExtract.txt"
# Problem with Fontana's written as Fontana"s
z1 <- scan(dataFile, sep="\n", wh="")
z2 <- gsub('\"Fontana\"s\"', "\"Fontana's\"", z1)
tfile <- tempfile("data", fileext = ".csv")
write(z2, file=tfile)
rm(z1, z2)

# Check that all fields in all rows are coonsidered comma delimited:
cf <- count.fields(tfile, sep=",", quote='"', comment="")
table(cf)  # Should be all 15

# Read modified data:
nycData <- read.csv(tfile, header=TRUE, stringsAsFactor=FALSE)
rm(tfile)
nycData$INSPDATE <- as.Date(nycData$INSPDATE)
nycData$GRADEDATE <- as.Date(nycData$GRADEDATE)
nycData$RECORDDATE <- gsub(" .*", "", nycData$RECORDDATE)
nycData$RECORDDATE <- as.Date(nycData$RECORDDATE)

# Clean up string data:
library(stringr)
nycData$BUILDING <- str_trim(nycData$BUILDING)
nycData$STREET <- str_trim(nycData$STREET)
nycData$PHONE <- str_trim(nycData$PHONE)

# Drop bad data:
# INSPDATE not right:
indxBadINSPDATE <- which(nycData$INSPDATE == "1900-01-01")
if(length(indxBadINSPDATE) > 0) {
    nycData <- nycData[-indxBadINSPDATE,]
}
