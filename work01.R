t <- table(nycData$CURRENTGRADE)
grades <- names(t)


library("dplyr")
nycData_sorted <- arrange(nycData, CAMIS, INSPDATE, CURRENTGRADE)
nycData_with_grade <- filter(nycData_sorted, CURRENTGRADE != "")
nycData_by_date <- group_by(nycData_with_grade, CAMIS, GRADEDATE)
