# Check for and install required packages

if( !("dplyr" %in% installed.packages()) ){
  install.packages("dplyr")
}
if( !("tidyr" %in% installed.packages()) ){
  install.packages("tidyr")
}


# Load data

dat_old <- read.csv(BusinessFAQReferrals_old)
dat_new <- read.csv(BusinessFAQReferrals_new,
                    skip = 6,
                    row.names = NULL,
                    header = FALSE)[-c(2:3), ]
date_string <- read.csv(BusinessFAQReferrals_new,
                        skip = 3,
                        nrows = 1,
                        header = FALSE)[1, 1]


# Restructure table

## Extract referrer names and remove unnecessary content
dat_new <- dat_new[ , 1:(ncol(dat_new) - 2)]
refer_lookup <- data.frame(t(dat_new[1, -1]),
                           colnames(dat_new)[-1])
dat_new <- dat_new[-1, ]

## Summarize by FAQ group
dat_new <- dat_new |>
  dplyr::mutate(dplyr::across(-1, as.integer))
dat_new$GroupId <- ""
dat_new$GroupId[grep("/business", dat_new[ , 1])] <- "1237"
dat_new <- dat_new[ , -1] |>
  dplyr::group_by(GroupId) |>
  dplyr::summarise(dplyr::across(dplyr::everything(), sum, na.rm = TRUE))

## Format for reporting
dat_new <- tidyr::pivot_longer(dat_new,
                               cols = 2:ncol(dat_new),
                               names_to = "Referrer",
                               values_to = "Entrances")
dat_new <- dat_new[dat_new$Entrances != 0, ]
dat_new$Referrer <- refer_lookup[match(dat_new$Referrer, refer_lookup[ , 2]), 1]


# Append year and month

dat_new$Year <- as.integer(substr(date_string, 3, 6))
dat_new$Month <- as.integer(substr(date_string, 7, 8))


# Export data if new

if(! paste0(dat_new$Year[1], dat_new$Month[1]) %in% paste0(dat_old$Year, dat_old$Month)){
  write.csv(rbind(dat_old, dat_new),
            file = BusinessFAQReferrals_old,
            na = "",
            row.names = FALSE)
}
