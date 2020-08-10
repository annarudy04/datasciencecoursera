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
