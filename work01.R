t <- table(nycData$CURRENTGRADE)
grades <- names(t)


library("dplyr")
nycData_sorted <- arrange(nycData, CAMIS, INSPDATE, CURRENTGRADE)
nycData_with_grade <- filter(nycData_sorted, CURRENTGRADE != "")
nycData_by_date <- group_by(nycData_with_grade, CAMIS, GRADEDATE)
nycData_Grade_Date <- summarize(nycData_by_date,
    Grade=first(CURRENTGRADE), Date=as.Date(first(as.character(GRADEDATE))))
ta_Grade_Date <- mutate(nycData_Grade_Date, Days=Date - lag(Date))

# Grade transitions 
nycData_Grade_Date <- mutate(nycData_Grade_Date,
                                 Trans = paste0(lag(Grade), Grade))

# Days between grades:
nycData_Grade_Date <- mutate(nycData_Grade_Date, Days=Date - lag(Date))

# Grade transitions
nycData_Grade_Date <- mutate(nycData_Grade_Date,
    Trans = paste0(lag(Grade), Grade))
