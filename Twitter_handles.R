
############################################################################################################
## Twitter Mining of Company Tweets that apply Corporate Social Advocacy
## Author: Surya Knöbel for Institute of Interactive Marketing
## Date: 10.03.2022
############################################################################################################

# Twitter API v.2 Full academic archive
# packaged used: https://cran.r-project.org/web/packages/academictwitteR/readme/README.html
# Github Page: https://github.com/cjbarrie/academictwitteR/tree/master/R

# Package citation:
# Barrie, Christopher and Ho, Justin Chun-ting. (2021). academictwitteR: an R package to access the Twitter Academic Research Product 
# Track v2 API endpoint. Journal of Open Source Software, 6(62), 3272, https://doi.org/10.21105/joss.03272

Sys.setenv(LANG = "en")

library(academictwitteR)
library(tidyverse)
library(dplyr)
library(tidyr)
library(feather)

set_bearer() # lThis will open your .Renviron file in the home directory. Enter your bearer token --> Ask Ulrike Phieler for TWITTER_BEARER
get_bearer()

########################################################################################################
# lets try pulling some tweets. Option 1 - Test
#######################################################################################################
tweets4 <- get_all_tweets(
  #query = "LGBTQ", this would pull tweets containing the word "LGBTQ
  users = c("amazonnews", "WeAreNetflix"), #  this will be capturing tweets by users @amazonnews AND @WeAreNetflix
  start_tweets = "2020-01-01T00:00:00Z",
  end_tweets = "2021-12-31T00:00:00Z",
  data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
  n = 100, # n = Inf -->would provide us with no limit of pulled tweets (alternatively n = 1000)
  file = "amazon_netflix_tweets"
)

# the data is saved as a rds file in the path. now open it

amazon_netflix <- readRDS("C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining\\amazon_netflix_tweets")
head(amazon_netflix)
names(amazon_netflix)
#--> this test seems to work. So in option 4 I will pull an "infinite" number of tweets from 10 twitter accounts (twitter handles)


#################################################################################################################################
#  Mine all tweets from three lists from January 2020 to December 2021
#################################################################################################################################

# tweet handles /user names are taken from the following lists provided by Doris Geafar:
# Interbrand Global US 2021
# Kantar Brand Footp FMCG US 2020
# Corebrand Bran Power US 2020


# tweets are called in chunks/batches because of the high amount of handles.
# an alternative would be to loop over a list of users. 


# first batch/chunk --> already collected
tweets_all_handles_01 <- get_all_tweets(
  users = c("amazonnews", "WeAreNetflix", "MSFTnews", "CocaCola", "CocaColaCo", "WaltDisneyCo", "abinbev",
            "StarbucksNews", "KellogCompany", "LinkedInNews", "McDonaldsCorp", "tim_cook", "Google", "McDonalds",
            "Nike", "MetaNewsroom", "Cisco", "IBMNews", "Instagram", "Adobe", "AdobeNews"), 
  start_tweets = "2020-01-01T00:00:00Z",
  end_tweets = "2021-12-31T00:00:00Z",
  data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
  n = Inf, # n = Inf -->would provide us with no limit of pulled tweets (alternatively n = 1000)
  file = "Tweets_all_handles_01" #If a filename is supplied, the functions will save the resulting tweet-level information as a .rds file.
)

head(tweets_all_handles_01)
names(tweets_all_handles_01)

# second batch/chunk
tweets_all_handles_02 <- get_all_tweets(
  users = c("Citi", "GoldmanSachs", "eBayNewsroom", "Gillette", "HP", "HP_Newsroom", "3M", "3MNews", "MorganStanley", "FedExPolicy", "FedEx",
            "brownforman", "CatFoundationTS", "JNJNews"), 
  start_tweets = "2020-01-01T00:00:00Z",
  end_tweets = "2021-12-31T00:00:00Z",
  data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
  n = Inf, # n = Inf -->would provide us with no limit of pulled tweets (alternatively n = 1000)
  file = "Tweets_all_handles_02" #If a filename is supplied, the functions will save the resulting tweet-level information as a .rds file.
)
#
head(tweets_all_handles_02)
names(tweets_all_handles_02) ## lacks geo variable, but thats no problem


# third chunk
tweets_all_handles_03 <- get_all_tweets(
  users = c("HersheyCompany", "Hersheys", "Fritolay", "PepsiCo", "UPS", "UPS_News",
            "AmericanExpress", "GEpublicaffairs", "Accenture", "AccentureCmty"), 
  start_tweets = "2020-01-01T00:00:00Z",
  end_tweets = "2021-12-31T00:00:00Z",
  data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
  n = Inf, # n = Inf -->would provide us with no limit of pulled tweets (alternatively n = 1000)
  file = "Tweets_all_handles_03" #If a filename is supplied, the functions will save the resulting tweet-level information as a .rds file.
)

tweets_all_handles_03 <- readRDS("C:/Users/Surya/Desktop/WU_IMSM_Research/Twitter_Python_Mining/Tweets_all_handles_03")
head(tweets_all_handles_03)
names(tweets_all_handles_03)

#options(timeout = 4000000) 
#timeout(4000000)

#Error in curl::curl_fetch_memory(url, handle = handle) : 
#Timeout was reached: [api.twitter.com] Send failure: Connection was reset



# fourth chunk
tweets_all_handles_04 <- get_all_tweets(
  users = c("Danone", "Oreo", "MDLZ", 
            "mmschocolate", "Dove", "Unilever", "CloroxCo", "TysonFoods", "CP_News", "BarillaUS", "BarillaGroup","Bounty", "Chobani",
            "Policy", "exxonmobil", "BankofAmerica", "BofA_News", "bmsnews", "WhirlpoolCorp", "ATT", "pfizer", "pfizer_news", "GM", "Chevron"), 
  start_tweets = "2020-01-01T00:00:00Z",
  end_tweets = "2021-12-31T00:00:00Z",
  data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
  n = Inf, # n = Inf -->would provide us with no limit of pulled tweets (alternatively n = 1000)
  file = "Tweets_all_handles_04" #If a filename is supplied, the functions will save the resulting tweet-level information as a .rds file.
)

head(tweets_all_handles_04)
names(tweets_all_handles_04)


# fifth chunk
tweets_all_handles_05 <- get_all_tweets(
  users = c("salesforce", "VisaNews", "Visa",
            "PayPal", "PayPalNews", "Pampers", "ProcterGamble", "Mastercard", "MastercardNews", "Ford", "FordFund"), 
  start_tweets = "2020-01-01T00:00:00Z",
  end_tweets = "2021-12-31T00:00:00Z",
  data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
  n = Inf, # n = Inf -->would provide us with no limit of pulled tweets (alternatively n = 1000)
  file = "Tweets_all_handles_05" #If a filename is supplied, the functions will save the resulting tweet-level information as a .rds file.
)

#
head(tweets_all_handles_05)
names(tweets_all_handles_05) # has geo and withheld in comparison to the other chunks (can both be excluded in the merge)


# sixth chunk
tweets_all_handles_06 <- get_all_tweets(
  users = c("Starbucks", "yumbrands", "UberComms", "Uber", "KraftHeinzCo",
            "NestleUSA", "CampbellSoupCo", "GeneralMills", "Zoom", "TiffanyAndCo"), 
  start_tweets = "2020-01-01T00:00:00Z",
  end_tweets = "2021-12-31T00:00:00Z",
  data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
  n = Inf, # n = Inf -->would provide us with no limit of pulled tweets (alternatively n = 1000)
  file = "Tweets_all_handles_06" #If a filename is supplied, the functions will save the resulting tweet-level information as a .rds file.
)

head(tweets_all_handles_06)
names(tweets_all_handles_06)

##############################################################################################################
## Merge the dataframes into one
##############################################################################################################
# To join two data frames (datasets) vertically, use the rbind function. 
# The two data frames must have the same variables, but they do not have to be in the same order.

# first delete extra variables from other Dataframes (like geo or withheld variable)

tweets_all_handles_01 <- subset(tweets_all_handles_01, select = -c(geo))
tweets_all_handles_04 <- subset(tweets_all_handles_04, select = -c(geo))
tweets_all_handles_05 <- subset(tweets_all_handles_05, select = -c(geo, withheld))



# now merge them into one df

#one option that normally would work, but here has issues with row names. So I will use dplyr instead
#all_handles_merged <- rbind(tweets_all_handles_01, tweets_all_handles_02, tweets_all_handles_03, tweets_all_handles_04, tweets_all_handles_05, tweets_all_handles_06) #make.row.names = TRUE

# merge with dplyr bind_rows
all_handles_merged <- bind_rows(tweets_all_handles_01, tweets_all_handles_02, tweets_all_handles_03, tweets_all_handles_04, tweets_all_handles_05, tweets_all_handles_06, .id = 'id')


##############################################################################################################
# Save the merged df into a feather file (easier to load again and send)
##############################################################################################################

# define path where it shall be written to
path = "all_handles_merged.feather"

test_1 <- saveRDS(all_handles_merged, "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining\\all_handles_merged.rds" )

# write to faether
write_feather(all_handles_merged, path) # did not work
#
# 
tweets_all_handles <- readRDS("C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining\\all_handles_merged.rds")
head(Tweets_all_handles)

#users = c("amazonnews", "WeAreNetflix", "MSFTnews", "CocaCola", "CocaColaCo", "WaltDisneyCo", "abinbev",
#"StarbucksNews", "KellogCompany", "LinkedInNews", "McDonaldsCorp", "tim_cook", "Google", "McDonalds",
#"Nike", "MetaNewsroom", "Cisco", "IBMNews", "Instagram", "Adobe", "AdobeNews", 


#"Citi", "GoldmanSachs", "eBayNewsroom", "Gillette", "HP", "HP_Newsroom", "3M", "3MNews", "MorganStanley", "FedExPolicy", "FedEx",
#"brownforman", "CatFoundationTS", "JNJNews", "Zoom", "TiffanyAndCo", "yumbrands", "UberComms", "Uber", "KraftHeinzCo",
#"NestleUSA", "CampbellSoupCo", "GeneralMills", 

#""HersheyCompany", "Hersheys", "Fritolay", PepsiCo", "UPS", "UPS_News",
#"AmericanExpress", "GEpublicaffairs", "Accenture", "AccentureCmty", "SalesforceNews", "salesforce", "VisaNews", "Visa",
#"PayPal", "PayPalNews", "Pampers", "ProcterGamble", "Mastercard", "MastercardNews", "Starbucks", "Ford", "FordFund",

#"Danone", "Oreo", "MDLZ", 
#"mmschocolate", "Dove", "Unilever", "CloroxCo", "TysonFoods", "CP_News", "BarillaUS", "BarillaGroup","Bounty", "Chobani",
#"Policy", "exxonmobil", "BankofAmerica", "BofA_News", "bmsnews", "WhirlpoolCorp", "ATT", "pfizer", "pfizer_news", "GM", "Chevron")



####################################################################################################################################
##  Attempt to get retweets of tweets - 
####################################################################################################################################





retweets_test_03 <- get_all_tweets(start_tweets = "2020-01-01T00:00:00Z",
                                   end_tweets = "2021-12-31T00:00:00Z",
                                   n = 500,
                                   data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
                                   file = "Re-Tweets_of_Tweets_03",
                                   conversation_id = "1476700364992917505","1476691089004404740","1476481258796589061","1476603130964029443","1315339498096668672","1315339413535305732","1315339355473547264") #
######################################################


# --> might need to try it with a loop

dat <- data.frame(conv_id = c("1476700364992917505","1476691089004404740","1476481258796589061","1476603130964029443","1315339498096668672","1315339413535305732","1315339355473547264"))

# test the loop and if it runs throigh the needed conv_ids
for (i in 1:length(dat$conv_id)){
  print(dat$conv_id[i])
} # --> seems to work

df_test <- get_all_tweets(start_tweets = "2020-01-01T00:00:00Z",
                          end_tweets = "2021-12-31T00:00:00Z",
                          n = 500,
                          data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
                          conversation_id = "1476481258796589061")




###########################################################################################
# attempt 2: Should work logically but I still run into some issues.
###########################################################################################

for(i in 1:length(dat$conv_id))
{
  df[i] <- get_all_tweets(start_tweets = "2020-01-01T00:00:00Z",
                              end_tweets = "2021-12-31T00:00:00Z",
                              n = 500,
                              data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
                              conversation_id = dat$conv_id[i])
    holder_vars <- names(df) %in% c("referenced_tweets", "entities") # get rid of these two variables (they are nested and we dont need them)
    datafr_retw <- df[!holder_vars] 
    datafr_retw <- bind_rows(df[i], datafr_retw)
  }#

# https://www.statology.org/undefined-columns-selected-r/ - problem seems to be in the subset function













