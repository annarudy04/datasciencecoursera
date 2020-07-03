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

# Plot total yearly emissions in Baltimore (fips = "24510") from vehicle sources. 
sector_emissions <- left_join(NEI, select(SCC, SCC, EI.Sector), by = c("SCC"))
bmd_yearly_vehicle_totals <- sector_emissions %>%
  filter(fips == "24510" & grepl("Vehicle", EI.Sector)) %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))
qplot(
  year, 
  total, 
  data=bmd_yearly_vehicle_totals, 
  geom = "line", 
  main = "Baltimore County Yearly Emissions from Vehicles", 
  xlab = "Year", 
  ylab = "Total Emissions (tons)"
)
ggsave("plot_files/plot5.png", width = 6, height = 4)