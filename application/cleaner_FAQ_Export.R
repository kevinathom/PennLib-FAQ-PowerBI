# Load data

#setwd("~/GitHub/PennLib-FAQ-PowerBI/data")

names_old <- read.csv(faq_export_old,
                    header = FALSE,
                    nrows = 1)
dat_new <- read.csv(faq_export_new) # Update this filename


# Remove new columns

dat_new <- dat_new[ , -6] # Short Answer


# Restore column names

names_old[1, 1] <- "Id"
names(dat_new) <- names_old


# Export new data

write.csv(dat_new,
          file = faq_export_out,
          na = "",
          row.names = FALSE)
