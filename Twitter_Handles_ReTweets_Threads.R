############################################################################################################
## Twitter Getting Re-Tweets of Company Tweets that apply Corporate Social Advocacy
## Author: Surya Knöbel for Institute of Interactive Marketing
## Date: 15.09.2022
############################################################################################################

# load some needed packages
library(academictwitteR)
library(tidyverse)
library(dplyr)
library(tidyr)

#Sys.setenv(LANG = "en")

# Load the mined dataset of all Company accounts of interest (--> For this see Twitter_handles.r script)
all_handles <- readRDS("C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining\\all_handles_merged.rds")

sub_handles <- readRDS("C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining\\Tweets_all_handles_05.rds")

# have a look at the data 
head(all_handles)
names(all_handles)


# check if there are conversation IDs that are not unique in the df --> not the case, they are all unique
all_handles %>% 
  select(conversation_id) %>% 
  unique() %>% 
  summarize(n = n())

all_handles %>% 
  select(author_id) %>% 
  unique() %>% 
  summarize(n = n()) # --> there are several author Ids that are not unique.


# create a subset of "all_handles" to use for testing
# take a random sample of size 1000 from my dataset

# sample without replacement
all_handles_sample <- all_handles[sample(1:nrow(all_handles), 1000,
                          replace=FALSE),]

saveRDS(all_handles_sample, "all_handles_sample.rds")


# Loop Logic:
# create a list of conv_ids with replies/retweets
# if conversation_id xy has public.metric.retweet.count != 0 -->get retweets of this conversation Id
#  run through list of convIds (iterate) and put each call to a placeholder, 
#  then if iteration == 1, add to df, if iteration != 1, add placeholder to df (merge)



# using dplyer
subsample_thread_conv <- filter(all_handles_sample, all_handles_sample$public_metrics$reply_count > 0) 
subsample_thread_conv2 <- filter(all_handles_sample, all_handles_sample$public_metrics$retweet_count > 0) 
# these are the conv_idS from the subsample which have replies to replies (basically threads)

# save the subsample of conversation Ids which have more than one reply.  
saveRDS(all_handles_sample, "all_handles_sample.rds")


# Now create a list of conv_ids that have replies
conv_id_list <- as.list(subsample_thread_conv$conversation_id)



# create a micro list with only 3 conv_ids
conv_id_list_micro <- list("1470869757050118153", "1387769601606492162", "1217262677673873408")


# test run with a conversation Id
get_all_tweets(start_tweets = "2020-01-01T00:00:00Z",
               end_tweets = "2021-12-31T00:00:00Z",
               n = 500,
               data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
               file = "test_convID_thread",
               conversation_id = 1288206193559777280) # this convId should have 16 replies

test_one_ConvID <- readRDS("C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining\\test_convID_thread.rds")

# --> seems to work fine

##############################################################################
##   Attempt 1: Api call with looping over shortened conv_id list --> does not work due to rbind function
#############################################################################

for(i in 1:length(conv_id_list_micro)){
  holder <- get_all_tweets(start_tweets = "2020-01-01T00:00:00Z",
                           end_tweets = "2021-12-31T00:00:00Z",
                           n = 500,
                           data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
                           file = "thread_df",
                           conversation_id = conv_id_list_micro[i])
  ifelse(i == 1, thread_df <- holder, thread_df <- rbind(thread_df, holder))} # assign ith iteration to df if i = 1, if I is not 1, then stack/append holder to df

# --> does not work due to rbind function needing same amount of columns
#holder2 = subset(holder, select = -c(geo.place_id))

##############################################################################
##   Attempt 1: Api call with looping over shortened conv_id list --> # attempt with dplyers bind_rowse as rbind needs same amount of cols --> Works
#############################################################################



for(i in 1:length(conv_id_list_micro)){
  holder <- get_all_tweets(start_tweets = "2020-01-01T00:00:00Z",
                           end_tweets = "2021-12-31T00:00:00Z",
                           n = 500,
                           data_path = "C:\\Users\\Surya\\Desktop\\WU_IMSM_Research\\Twitter_Python_Mining",
                           file = "thread_df",
                           conversation_id = conv_id_list_micro[i])
  ifelse(i == 1, thread_df <- holder, thread_df <- bind_rows(thread_df, holder))} # assign ith iteration to df if i = 1, if I is not 1, then stack/append holder to df

# this actually works! At least it seems so. 

#



