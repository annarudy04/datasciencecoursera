# Parse webpage with XML
library(XML)
url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html_content <- readLines(url, encoding = "UTF-8")
parsedHtml <- htmlParse(html_content, encoding = "UTF-8")
title <- xpathSApply(doc=parsedHtml, path = '//title', fun=xmlValue)
h2 <-  xpathSApply(doc=parsedHtml, path = "//h2", fun=xmlValue)
print(title)
print(h2)
library(httr)
html <- GET(url)
html_content2 <- content(html, as='text')
parsedHtml <- htmlParse(html_content2,asText = TRUE)
title2 <- xpathSApply(parsedHtml, '//title', xmlValue)
print(title2)

