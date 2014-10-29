streetAddress <- with(nycData, paste(BUILDING, STREET))
fullAddress <- with(nycData, paste0(streetAddress, ", New York, NY, ", ZIPCODE))
uniqueAddress <- unique(fullAddress)

# from http://stackoverflow.com/questions/22887833/r-how-to-geocode-a-simple-address-using-data-science-toolbox
library(httr)
library(rjson)
jdata <- paste0("[",
    paste(paste0("\"", uniqueAddress, "\""), collapse=","),
    "]")
url  <- "http://www.datasciencetoolkit.org/street2coordinates"
response <- POST(url, body=jdata)
json <- fromJSON(content(response, type="text"))
geocode <- do.call(rbind, lapply(json,
    function(x) c(long=x$longitude, lat=x$latitude)))

# Results from street2coordinates are in random order, put back in order
#   of uniqueAddress. Note names of geocode are uniqueAddress
geocode <- geocode[uniqueAddress, ]

# Fill in lat, long for all rows in nycData
m <- match(fullAddress, uniqueAddress)
nycData$lat <- geocode[m, "lat"]
nycData$long <- geocode[m, "long"]
