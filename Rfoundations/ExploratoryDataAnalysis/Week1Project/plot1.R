library(dplyr)
source("get_data.R")

# Obtain relevant data
elect_dat <- get_data()

# create a histogram for Global Active Power in a png file device
png("plot1.png", width = 480, height = 480, units = "px")
with(elect_dat, hist(
  Global_active_power, 
  col = "red", 
  main = "Global Active Power", 
  xlab = "Global Active Power (kilowatts)",
  ylab = "Frequency"
  )
)
dev.off()
