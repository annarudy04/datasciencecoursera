library(dplyr)
library(ggplot2)

# Download and read air pollution data. 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipfileName <- "exdata_data_NEI_data.zip"
folderName <- "exdata_data_NEI_data"
if(!dir.exists(folderName)){
  download.file(fileUrl, destfile = zipfileName, method="curl")
  unzip(zipfile = zipfileName, exdir = "exdata_data_NEI_data")
}
download_data()
if(!exists("NEI")){
  NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
}

# Plot total yearly emissions in Baltimore (fips = "24510") and LA (fips = "06037")
# from vehicle sources. 
sector_emissions <- left_join(NEI, select(SCC, SCC, EI.Sector), by = c("SCC"))
bmd_la_yearly_vehicle_totals <- sector_emissions %>%
  filter(fips %in% c("24510", "06037") & grepl("Vehicle", EI.Sector)) %>%
  group_by(year, fips) %>%
  summarize(total = sum(Emissions))
g <- ggplot(bmd_la_yearly_vehicle_totals, aes(year, total, group = fips))
g + geom_line(aes(col = fips)) + 
  scale_color_discrete(name = "County", labels = c("Los Angeles", "Baltimore")) + 
  xlab("Year") +
  ylab("Total Emissions (tons)") + 
  ggtitle("Yearly Emissions from Vehicles")
ggsave("plot_files/plot6.png", width = 6, height = 4)