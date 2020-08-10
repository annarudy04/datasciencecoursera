q1 <- function(){
  acs_file_name = "acs.csv"
  if(!file.exists(acs_file_name)){
    download.file(
      "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
      acs_file_name
    )
  }
  acs <- read.csv(acs_file_name)
  print(strsplit(names(acs), "wgtp")[[123]])
}
if(!file.exists("gdp.csv")){
  download.file(
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
    "gdp.csv"
  )
}
# data is only in the first 195 rows, after that is some extra meta data
gdp <- read.csv("gdp.csv", skip = 4, stringsAsFactors = FALSE)[1:195,]

if(!file.exists("edu.csv")){
  download.file(
    "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
    "edu.csv"
  )
}
edu <- read.csv("edu.csv")

q2 <- function(){
  # skip the first 4 rows of header, don't read columns as factors
  gdp_mill_str <- gdp$X.4
  gdp_mill_num <- as.numeric(gsub(",", "", gdp_mill_str))
  print(mean(gdp_mill_num[!is.na(gdp_mill_num)]))
}

q3 <- function(){
  countryNames <- gdp$X.3
  print(length(grep("^United", countryNames)))
}

q4 <- function(){
  m <- merge(gdp, edu, by.x = "X", by.y = "CountryCode")
  special_notes <- m$Special.Notes
  print(length(grep("Fiscal year end: June", special_notes)))
}

q5 <- function(){
  library(quantmod)
  amzn = getSymbols("AMZN",auto.assign=FALSE)
  sampleTimes = index(amzn)
  dates12 <- grep("2012", sampleTimes, value = TRUE)
  wkd <- wday(dates12, label = TRUE)
  mon <- wkd[wkd == "Mon"]
  print(paste(length(dates12), length(mon)))
}