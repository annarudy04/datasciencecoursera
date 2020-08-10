library(dplyr)

q1 <- function(){
  if (!file.exists("idaho.csv")){
    download.file(
      "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
      "idaho.csv"
    )
  }
  df <- read.csv("idaho.csv")
  agriLogical <- df$ACR == 3 & df$AGS == 6
  print(which(agriLogical)[1:3])
}

q2 <- function(){
  library(jpeg)
  if (!file.exists("jeff.jpeg")){
    download.file(
      "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
      "jeff.jpg")
  }
  dat <- readJPEG("jeff.jpg", native = TRUE)
  print(quantile(dat, probs = c(0.30, 0.80)))
}

q3 <- function(){
  if (!file.exists("gdp.csv")){
    download.file(
      "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
      "gdp.csv"
    )
  }
  if (!file.exists("edu.csv")){
    download.file(
      "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
      "edu.csv"
    )
  }
  # skip the first 4 rows of header, don't read columns as factors
  gdp <- read.csv("gdp.csv", skip = 4, stringsAsFactors = FALSE) %>%
         # rename columns to something more meaningful
         rename(CountryCode = "X", ranking = "X.1") %>%
         # by casting the ranking column to numeric, the blank rankings 
         # at the bottom of the file will become NA
         mutate(ranking = as.numeric(ranking)) %>%
         # now we can remove the rows with blank rankings at the bottom
         filter(!is.na(ranking))
  edu <- read.csv("edu.csv")
  m <- merge(gdp, edu, by="CountryCode") 
  m %>%  arrange(desc(ranking)) %>%
    select(CountryCode, ranking, Long.Name) %>%
    # select the 13th row
    slice(13) %>%
    print
}

q4 <- function(){
  # Group m by income group
  m_grouped <- group_by(m, Income.Group) %>%
    # get the mean of rankings per group
    summarize(mean_rank=mean(ranking)) %>%
    # select only the income groups of interst
    filter(Income.Group == "High income: nonOECD" 
            | Income.Group == "High income: OECD") %>%
    print
}

q5 <- function(){
  # break m into 5 groups based on ranking
  c <- cut(m$ranking, breaks = 5)
  # make a table of ranking group vs income group
  rank_v_income <- table(c, m$Income.Group)
  # print out the 1st row (which corresponds to the 38 nations with highest GDP)
  # and the "Lower middle income" column
  print(rank_v_income[1, "Lower middle income"])
}