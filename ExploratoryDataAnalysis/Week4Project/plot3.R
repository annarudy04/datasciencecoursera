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

# Plot total yearly emissions by type in Baltimore (fips = "24510").
bmd_yearly_type_totals <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarize(total = sum(Emissions))
qplot(
  year, 
  total, 
  data = bmd_yearly_type_totals, 
  main = "Baltimore County Yearly Emissions by Type", 
  xlab = "Year", 
  ylab = "Total Emissions (Tons)",
  geom = "line", 
  color = type
)
ggsave("plot3.png", width = 6, height = 4)