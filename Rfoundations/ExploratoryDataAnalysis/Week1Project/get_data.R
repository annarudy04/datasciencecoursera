get_data <- function(){
  # downlaod data and return rows from 2/6/2007 - 2/7/2007
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipfileName <- "household_power_consumption.zip"
  fileName <- "household_power_consumption.txt"
  if(!file.exists(fileName)){
    download.file(fileUrl, destfile = zipfileName, method="curl")
    unzip(zipfile = zipfileName, files = fileName)
  }
  
  read.csv(
    file = "household_power_consumption.txt", 
    sep = ';', 
    stringsAsFactors = FALSE
  )  %>% 
    mutate(datetime = paste(Date, Time)) %>%
    mutate(datetime = as.POSIXct(
      strptime(datetime, format = "%d/%m/%Y %H:%M:%S"))
    ) %>%
    select(-c("Date", "Time")) %>%
    filter(datetime >= "2007-02-01" & datetime < "2007-02-03") %>%
    mutate_if(is.character,as.numeric)
}