q1 <- function(){
  library(httr)
  library(jsonlite)
  # find OAuth settings for github: http://developer.github.com/v3/oauth/
  oauth_endpoints("github")
  
  # to make your own application, register at
  #    https://github.com/settings/developers. Use any URL for the homepage URL
  #    (http://github.com is fine) and  http://localhost:1410 as the callback url
  #
  #    key is Client ID, secret is Client secret
  myapp <- oauth_app("github",
                     key = "Iv1.2329cd3933c92fff",
                     secret = "d6f906b4d2246d99a2f10f02e55ba9ea9b3a4a4d"
  )
  # get OAuth credentials
  github_token <- oauth1.0_token(oauth_endpoints("github"), myapp)
  
  # use the api to get jtleek's repos
  gtoken <- config(token = github_token)
  req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
  
  # print out any http errors that occur
  stop_for_status(req)
  
  # load the content of the request
  cont <- content(req)
  
  # convert the content to json and convert the json to a df
  df <- fromJSON(toJSON(cont))
  
  # use subsetting to find the date that the datasharing repo was created
  datasharing_created_date <- df[df$name=="datasharing",]["created_at"]
  print(datasharing_created_date)
}

q2_and_q3 <- function(){
  if (!file.exists("acs.csv")){
    download.file(
      "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
      "acs.csv"
    )
  }
  acs <- read.csv("acs.csv")
  # probability weights with age less than 50:
  print(head(sqldf("select pwgtp1 from acs where AGEP < 50")))
  # equivalent function to unique(acs$AGEP):
  print(head(sqldf("select distinct AGEP from acs")))
}

q4 <- function(){
  url <- "http://biostat.jhsph.edu/~jleek/contact.html"
  html_content <- readLines(url, encoding = "UTF-8")
  lines_of_interst <- html_content[c(10, 20, 30, 100)]
  l <- lapply(lines_of_interst, nchar)
  print(l)
}

q5 <- function(){
  if (!file.exists("sst.for")){
    download.file(
      "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",
      "sst.for"
    )
  }
  sst <- read.fwf(
          "sst.for", 
          widths=c(12,7,7,6,7,7,7,6,7), #note: I had to do trial and error to get these widths
          skip=4,
          header=FALSE,
          col.names = c(
            "week", 
            "nino_1_and_2_sst",
            "nino_1_and_2_ssta",
            "nino_3_sst",
            "nino_3_ssta",
            "nino_3_and_4_sst",
            "nino_3_and_4_ssta",
            "nino_4_sst",
            "nino_4_ssta"
          )
  )
  print(sum(sst["nino_3_sst"]))
  print(head(sst["nino_3_sst"]))
}