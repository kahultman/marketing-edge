# Checking whether promo and appeal data sets are identical

library(dplyr)
library(lubridate)

load("./data/appeal.Rdata")
load("./data/promo.Rdata")

promo$appdate <- promo$date
promo$date <- NULL
str(promo)
str(appeal)
typeof(appeal$id)
promo$id <- as.double(promo$id)
colnames(appeal)
colnames(promo)

head(promo$appdate)
promo$appdate <- mdy(promo$appdate)
appeal$source <- as.character(appeal$source)
attributes(appeal)[1] <- NULL
attributes(appeal)
attributes(promo)

appeal <- as.data.frame(appeal)

test <- anti_join(appeal, promo)

# Results in only 9 rows of data that are in appeal, but not promo. 
# These data sets are either identical or too similar to treat as different. 

all.equal(promo, appeal)

all.equal(test, promo)

head(appeal)
head(promo)

