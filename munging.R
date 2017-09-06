# Create test and train sets
load("./data/trans.Rdata")
trans_train <- filter(trans, giftdate < "2005-11-10")
trans_test <- filter(trans, giftdate >= "2005-11-10")
saveRDS(trans_train, file = "./data/trans_train.RDS")
saveRDS(trans_test, file = "./data/trans_test.RDS")
