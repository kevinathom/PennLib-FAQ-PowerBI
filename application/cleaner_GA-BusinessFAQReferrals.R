# Load data

setwd("~/GitHub/PennLib-FAQ-PowerBI/data")

dat_old <- read.csv("GA_BusinessFAQReferrals_clean.csv")
dat_new <- read.csv("C:/Users/kevinat/Downloads/download.csv") # get the referrer and grand total
date_new <- read.csv("C:/Users/kevinat/Downloads/download.csv",
                     skip = 3,
                     nrows = 1,
                     header = FALSE)[1, 1]

#dat_old <- read.csv(BusinessFAQReferrals_old)
#dat_new <- read.csv(BusinessFAQReferrals_new)


# Transpose axes

t(dat_new)


# Append date

date_new <- substr(date_new, 3, 8) # Is this format compatible with other data?
date_new$Date <- date_new


# Append or replace data

#if month exists, replace, else append


# Export data

write.csv(rbind(dat_old, dat_new),
          file = BusinessFAQReferrals_old,
          na = "",
          row.names = FALSE)