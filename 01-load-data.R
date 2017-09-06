# Open SAS and txt data files and save as RData files

library(haven)
library(tidyr)


appeal <- read_sas("./data/appeal.sas7bdat")
save(appeal, file = "./data/appeal.Rdata")

donor <- read_sas("./data/donor.sas7bdat")
save(donor, file = "./data/donor.Rdata")

trans <- read_sas("./data/trans.sas7bdat")
save(trans, file = "./data/trans.Rdata")

source <- read_sas("./data/source.sas7bdat")
save(source, file = "./data/source.Rdata")

infocode <- read.table("./data/InfoCode.txt")
infocode <- infocode %>% separate(V1, into=c("id", "code"), sep = 9)
save(infocode, file = "./data/infocode.Rdata")

promo <- read.table("./data/Promo Final.txt")
promo <- promo %>% 
  separate(V1, into=c("id", "datesource"), sep = 9) %>% 
  separate(datesource, into=c("appdate", "source"), sep = 8)
save(promo, file = "./data/promo.Rdata")



