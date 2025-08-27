# Check for and install required packages

if( !("tidyr" %in% installed.packages()) ){
  install.packages("tidyr")
}


# Load data

#setwd("~/GitHub/PennLib-FAQ-PowerBI/data")

dat_new <- read.csv(allfaqviews_new, # Update this filename
                    skip = 3)


# Lengthen data

dat_new <- tidyr::pivot_longer(dat_new,
                               cols = -1:-2,
                               names_to = "Month.Year",
                               names_prefix = "X",
                               values_to = "Public Views")
dat_new <- dat_new[dat_new[ , ncol(dat_new)] != 0, ]
dat_new <- tidyr::separate(dat_new,#[ , "Month.Year"],
                           col = "Month.Year",
                           into = c("Month", "Year"),
                           sep = "\\.")


# Rearrange columns to match Power BI expected order

dat_new <- data.frame(dat_new[ , 1:2],
                      dat_new[ , 4], # Year
                      dat_new[ , 3], # Month
                      dat_new[ , 5])


# Restore historical column names
names(dat_new) <- c("FAQID", "Question", "Year", "Month", "Public Views")


# Export new data

write.csv(dat_new,
          file = allfaqviews_out,
          na = "",
          row.names = FALSE)
