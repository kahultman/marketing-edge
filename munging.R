# Create test and train sets and clean data sets to share with
# Chicago R User Group

library(tidyverse)



load("./data/appeal.Rdata")
load("./data/donor.Rdata")
load("./data/trans.Rdata")
load("./data/source.Rdata")
load("./data/infocode.Rdata")

#Split into train/test data sets
trans_train <- filter(trans, giftdate < "2005-11-10")
trans_test <- filter(trans, giftdate >= "2005-11-10")
saveRDS(trans_train, file = "./data/trans_train.RDS")
saveRDS(trans_test, file = "./data/trans_test.RDS")


head(appeal)
head(trans)
head(donor)
head(infocode)
head(source)

infocode <- tbl_df(infocode)

# id is double numeric in most tables, but should be character. infocode has id as character, but also has leading zeros.
# convert to double and back to remove leading zeros
infocode$id <- as.double(infocode$id)
infocode$id <- as.character(infocode$id)
# convert all other id columns to character

appeal$id <- as.character(appeal$id)
trans$id <- as.character(trans$id)
donor$id <- as.character(donor$id)

# combine source information with appeal table
# source is no longer needed
# source in source file has leading zeros

appeal <- left_join(appeal, source)

head(appeal)
save(appeal, file = "./data/appeal.Rdata")
head(trans)



# cut out all data before 2000 

appeal <- filter(appeal, appdate >= "2000-01-01")

save(appeal, file = "./data/condensed/appeal.RData")

trans_train <- readRDS("./data/trans_train.RDS")
head(trans_train)
trans_train <- filter(trans_train, giftdate >= "2000-01-01")

saveRDS(trans_train, file = "./data/condensed/trans_train.RDS")
saveRDS(appeal, file = "./data/condensed/appeal.RDS")


trans_test <- readRDS("./data/trans_test.RDS")
head(trans_test)

trans_test <- left_join(trans_test, source)
#check for missing values after join
sum(is.na(trans_test$cost))


trans_test2 <- trans_test %>%
  mutate(profit = amt - cost) %>% 
  group_by(id) %>% 
  summarise(CLV = sum(profit))

trans_test2$id <- as.character(trans_test2$id)
head(trans_test2)

trans_train$id <- as.character(trans_train$id)
donor$id <- as.character(donor$id)

trans_test2 <- left_join(donor, trans_test2) %>% 
  select(id, CLV)

sum(is.na(trans_test2$CLV))
trans_test2$CLV[is.na(trans_test2$CLV)] <- 0

head(trans_test2)
customer_equity <- sum(trans_test2$CLV)


saveRDS(trans_test2, file = "./data/condensed/trans_test_ANSWER_KEY.RDS")

write_csv(trans_test2, path = "trans_test_ANSWER_KEY.csv")
write_csv(trans_train, path = "./data/condensed/trans_train.csv")

head(appeal)


