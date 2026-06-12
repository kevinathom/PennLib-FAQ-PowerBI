# Load data

dat_old <- read.csv(BusinessFAQReferrals_old)
dat_new <- read.csv("C:/Users/kevinat/Downloads/download.csv",
                    skip = 6,
                    nrows = 3,
                    row.names = NULL,
                    header = FALSE)[c(1,3), -1] # get the referrer and total referrals
date_string <- read.csv("C:/Users/kevinat/Downloads/download.csv",
                        skip = 3,
                        nrows = 1,
                        header = FALSE)[1, 1]

#dat_new <- read.csv(BusinessFAQReferrals_new)


# Restructure table

dat_new <- dat_new[ , 1:(ncol(dat_new) - 2)]
dat_new <- t(dat_new)
dat_new <- as.data.frame(dat_new)
colnames(dat_new) <- c("Referrer", "Entrances")
dat_new$Entrances <- as.integer(dat_new$Entrances)


# Append year and month

dat_new$Year <- substr(date_string, 3, 6)
month_lookup <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
month <- month_lookup[as.integer(substr(date_string, 7, 8))]
dat_new$Month <- rep(month, nrow(dat_new))


# Export data if new

if(! paste0(dat_new$Year[1], dat_new$Month[1]) %in% paste0(dat_old$Year, dat_old$Month)){
  write.csv(rbind(dat_old, dat_new),
            file = BusinessFAQReferrals_old,
            na = "",
            row.names = FALSE)
}
