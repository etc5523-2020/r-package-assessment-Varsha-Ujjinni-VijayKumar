#' INDIA covid19 dataset
#' 
#' This dataset contains the data for the number of cases, deaths and recovered in India. This dataset contains the counts until October 2020.
#' 
#' 
india <- read.csv(here::here("inst/extdata/india-covid.csv"))
india$Date <- as.Date(india$Date,"%d/%m/%Y")

usethis::use_data(india, overwrite = TRUE)
