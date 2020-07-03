library(dplyr)

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

# Plot total yearly emissions in Baltimore (fips = "24510")
png("plot_files/plot2.png", width = 480, height = 480, units = "px")
bmd_yearly_totals <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))
with(
  bmd_yearly_totals,
  plot(
    year, 
    total, 
    main = "Baltimore County Yearly Emissions", 
    ylab = "Total Emissions (Tons)", 
    xlab = "Year", 
    type = "b"
  )
)
dev.off()