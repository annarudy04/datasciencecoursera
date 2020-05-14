if (!file.exists("data")){
  dir.create("data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method="curl")
dateDownloaded <- date() # keep track of this in case the source changes the data at a later date
