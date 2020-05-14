q1 <- function(){
  if(!file.exists('communities.csv')){
    download.file(
      'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv',
      destfile = 'communities.csv')
  }
  communities = fread('communities.csv')
  # VAL of 24 means home is worth $1 mill +
  print("Count of houses worth more than $1,000,000:")
  print("Using .N:")
  print(communities[, .N, by=VAL][VAL==24])
  print("Using regular subsetting:")
  print(nrow(communities[VAL==24]))
}

# q2 answer is "Tidy data has one variable per column"
# FES includes two variables: 
# family data (i.e. married/not married) AND employment status

q3 <- function(){
  if(!file.exists('nat_gas.xlsx')){
    download.file(
      'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx',
      destfile = 'nat_gas.xlsx')
  }
  dat <- read.xlsx('nat_gas.xlsx', sheetIndex=1, header=TRUE, colIndex=7:15,rowIndex = 18:23)
  print(sum(dat$Zip*dat$Ext,na.rm=T))
}

q4 <- function(){
  if(!file.exists("restaurants.xml"))
    download.file(
      "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",
      destfile = "restaurants.xml")
  }
  doc <- xmlTreeParse("restaurants.xml", useInternal=TRUE)
  rootNode <- xmlRoot(doc)
  zip_codes <- xpathSApply(rootNode, "//zipcode", xmlValue)
  zip_codes[zip_codes == 21231]
  print(length(zip_codes[zip_codes == 21231]))
}

q5<- function(){
  if(!file.exists("idaho.csv")){
    download.file(
      "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
      destfile = "idaho.csv")
  }
  idaho <- fread("idaho.csv")
  # Was going to time each operation, but I knew DT[,mean(pwgtp15),by=SEX] would 
  # be quickest since it is a data.table native function, which means it's going to 
  # be faster than functions that can be run on data.frames. 
}