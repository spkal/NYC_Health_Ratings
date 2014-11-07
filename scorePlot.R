# Histograms of scores
library(ggplot2)
library(dplyr)
# Get scores from each inspection date
scoreData <- nycData %>%
select(CAMIS, BORO, CUISINECODE, INSPDATE, SCORE, CURRENTGRADE) %>%
group_by(CAMIS, INSPDATE) %>%
slice(1) %>%  # only want one observation per (CAMIS, INSPDATE) pair
filter(SCORE > -1) %>%  # only valid numeric scores
filter(BORO > 0)
# Make BORO a factor with appropriate labels:
scoreData$BORO <- factor(scoreData$BORO, levels=1:5,
    labels=c("Manhattan", "The Bronx", "Brooklyn", "Queens", "Staten Island"))
p1 <- ggplot(data=scoreData, aes(x=SCORE))
p1 + geom_histogram(binwidth=1)
# Want density on y-axis when facetting so you can compare across panels:
p1 + aes(y = ..density..) + geom_histogram(binwidth=2) + facet_wrap(~ BORO) +
    ylab("percent") +
    ggtitle("Scores by Borough")
