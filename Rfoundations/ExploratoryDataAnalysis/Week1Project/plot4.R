library(dplyr)
source("get_data.R")

# Obtain relevant data
elect_dat <- get_data()

# plot line graphs for global active power, voltage, energy sub metering, 
# and global reactive power over time in a png file device
png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))
# Global Active Power line graph in spot 1,1
with(elect_dat, plot(
    datetime, 
    Global_active_power, 
    type = "n", 
    xlab = "", 
    ylab = "Global Active Power"
  )
)
with(dat, lines(datetime, Global_active_power))

# Voltage line graph in spot 1,2
with(elect_dat, plot(datetime, Voltage, type = "n"))
with(elect_dat, lines(datetime, Voltage))

# Energy sub metering graph in spot 2,1
with(elect_dat, plot(
    datetime, 
    Sub_metering_1, 
    type = "n", 
    xlab = "", 
    ylab = "Energy sub metering"
  )
)
with(elect_dat, lines(datetime, Sub_metering_1))
with(elect_dat, lines(datetime, Sub_metering_2, col = "red"))
with(elect_dat, lines(datetime, Sub_metering_3, col = "blue"))
legend(
  "topright", 
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
  lty = c(1, 1, 1), 
  col = c("black", "red", "blue")
)

# Global reactive power line graph in spot 2,2
with(elect_dat, plot(datetime, Global_reactive_power, type = "n"))
with(elect_dat, lines(datetime, Global_reactive_power))

dev.off()