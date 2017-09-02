# Open SAS and txt data files and save as RData files

library(haven)

appeal <- read_sas("./data/appeal.sas7bdat")
donor <- read_sas("./data/donor.sas7bdat")
trans <- read_sas("./data/trans.sas7bdat")
source <- read_sas("./data/source.sas7bdat")

save(appeal, file = "./data/appeal.Rdata")
save(donor, file = "./data/donor.Rdata")
save(trans, file = "./trans.Rdata")
save(source, file = "./source.Rdata")
