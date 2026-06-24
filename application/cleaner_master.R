# Set data file location and names

setwd("~/GitHub/PennLib-FAQ-PowerBI/data")

allfaqviews_old <- "allfaqviews_clean.csv"
allfaqviews_new <- "allfaqviews_2025_8_27.csv" # Update this filename
allfaqviews_out <- allfaqviews_old

faq_export_old <- "la_faq_export_clean.csv"
faq_export_new <- "la_faq_export2025-08-27_11_19_08.csv" # Update this filename
faq_export_out <- faq_export_old

queryanalyzer_old <- "la_queryanalyzer_store.csv"
queryanalyzer_new <- "queryanalyzer_707_2025-08-27_11_19_29.csv" # Update this filename
queryanalyzer_out <- "la_queryanalyzer_clean.csv"

FAQReferrals_old <- "GA_FAQReferrals_clean.csv"
FAQReferrals_dir <- "./GA_FAQReferrals_new"
FAQReferrals_out <- FAQReferrals_old


# Run scripts

source("~/GitHub/PennLib-FAQ-PowerBI/application/cleaner_allfaqviews.R")
source("~/GitHub/PennLib-FAQ-PowerBI/application/cleaner_faq_export.R")
source("~/GitHub/PennLib-FAQ-PowerBI/application/cleaner_queryanalyzer.R")
for(filename in list.files(FAQReferrals_dir,
                           full.names = TRUE
                           )){
  FAQReferrals_new <- filename
  source("~/GitHub/PennLib-FAQ-PowerBI/application/cleaner_GA-FAQREferrals.R")
}
