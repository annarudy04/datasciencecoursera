library(dplyr)
source("get_data.R")

# Obtain relevant data
elect_dat <- get_data()

# create a line graph for sub meterings 1-3 over time
# in a png file device
png("plot3.png", width = 480, height = 480, units = "px")
with(dat, plot(
    datetime, 
    Sub_metering_1, 
    type = "n", 
    xlab = "", 
    ylab = "Energy sub metering"
  )
)
with(dat, lines(datetime, Sub_metering_1))
with(dat, lines(datetime, Sub_metering_2, col = "red"))
with(dat, lines(datetime, Sub_metering_3, col = "blue"))
legend(
  "topright", 
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
  lty = c(1, 1, 1), 
  col = c("black", "red", "blue")
)
dev.off()