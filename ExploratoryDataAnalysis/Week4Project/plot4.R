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

# Plot yearly emissions from coal sources. 
sector_emissions <- left_join(NEI, select(SCC, SCC, EI.Sector), by = c("SCC"))
coal_yearly_emissions <- sector_emissions %>%
  filter(grepl("Coal", EI.Sector)) %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))
qplot(
  year, 
  total, 
  data=coal_yearly_emissions, 
  geom = "line", 
  main = "Yearly Emissions from Coal", 
  xlab = "Year", 
  ylab = "Total Emissions (tons)"
)
ggsave("plot4.png", width = 6, height = 4)