# Problem with Fontana's written as Fontana"s
z1 <- scan("WebExtract.txt", sep="\n", wh="")
z2 <- gsub('\"Fontana\"s\"', "\"Fontana's\"", z1)
tfile <- tempfile("data", fileext = ".csv")
write(z2, file=tfile)
rm(z1, z2)

# Check that all fields in all rows are coonsidered comma delimited:
cf <- count.fields(tfile, sep=",", quote='"', comment="")
table(cf)  # Should be all 15

# Read modified data:
d <- read.csv(tfile, header=TRUE, stringsAsFactor=FALSE)
d$INSPDATE <- as.Date(d$INSPDATE)
d$GRADEDATE <- as.Date(d$GRADEDATE)
d$RECORDDATE <- gsub(" .*", "", d$RECORDDATE)
d$RECORDDATE <- as.Date(d$RECORDDATE)

t <- table(d$CURRENTGRADE)
