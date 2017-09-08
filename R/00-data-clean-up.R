# This script reads in the original sas datafiles, cleans up the data,
# and creates training and test data sets for the Chicago R User Group
#
# Place all SAS files from the zip archive into the 'data' folder.
#
# Open SAS and txt data files and save as RData files

library(haven)
library(tidyverse)

setwd("../data/")

#### Donor

donor <- read_sas("donor.sas7bdat")
donor$id <- as.character(donor$id)
attr(donor, "label") <- NULL


example_submission <- select(donor, id) %>% mutate(CLV = 0)
write_csv(example_submission, path = "submission_template.csv")
saveRDS(donor, file = "donor.RDS")

#### Source

source <- read_sas("source.sas7bdat")
attr(source, "label") <- NULL

saveRDS(source, file = "source.RDS")
write_csv(source, path = "source.csv")

#### Trans

trans <- read_sas("trans.sas7bdat")
trans$id <- as.character(trans$id)

# remove redundant attributes
attr(trans$amt, "label") <- NULL
attr(trans$source, "label") <- NULL
attr(trans, "label") <- NULL

# Split into training and test sets, with test set being the final year of data
trans_train <- filter(trans, giftdate < "2005-11-10")
trans_test <- filter(trans, giftdate >= "2005-11-10")


# total values for each donor in final year to create test set
# Bring in cost from source file to calculate profit per transaction
trans_test <- left_join(trans_test, source) %>%
  mutate(profit = amt - cost) %>% 
  group_by(id) %>% 
  summarise(CLV = sum(profit)) 

trans_test <- left_join(donor, trans_test) %>% 
  select(id, CLV)

trans_test$CLV[is.na(trans_test$CLV)] <- 0

saveRDS(trans_test, file = "trans_test_ANSWER_KEY.RDS")
saveRDS(trans_train, file = "trans_train.RDS")

rm(list=ls())

#### Appeal

appeal <- read_sas("appeal.sas7bdat")
appeal$id <- as.character(appeal$id)
attr(appeal$source, "label") <- NULL
attr(appeal, "label") <- NULL
# remove appeals coinciding with test set (after 2005-11-10) 
appeal <- filter(appeal, appdate < "2005-11-10")

write_csv(appeal, path = "appeal.csv")
saveRDS(appeal, file = "appeal.RDS")

#### Infocode

infocode <- read.table("InfoCode.txt")
infocode <- infocode %>% separate(V1, into=c("id", "code"), sep = 9)

infocode <- tbl_df(infocode)

# id is double numeric in most tables, but should be character. infocode has id as character, but also has leading zeros.
# convert to double and back to remove leading zeros
infocode$id <- as.double(infocode$id)
infocode$id <- as.character(infocode$id)
write_csv(infocode, path = "infocode.csv")
saveRDS(infocode, file = "infocode.RDS")

rm(list = ls())
