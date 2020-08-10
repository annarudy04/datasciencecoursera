library(dplyr)
source("get_data.R")

# Obtain relevant data
elect_dat <- get_data()

# create a line graph for Global Active Power over time 
# in a png file device
png("plot2.png", width = 480, height = 480, units = "px")
with(elect_dat, plot(
    datetime, 
    Global_active_power, 
    type = "n", 
    xlab = "", 
    ylab = "Global Active Power (kilowatts)"
  )
)
with(dat, lines(datetime, Global_active_power))
dev.off()
