
#' RUSSIA covid19 dataset
#' 
#' This dataset contains the data for the number of cases, deaths and recovered in Russia. This dataset contains the counts until October 2020.
#' 
#' 

# reading the csv file 
russia <- read.csv(here("data","russia-covid19.csv"))

# wrangling the dataset
russia$Date.x <- as.Date(russia$Date.x,"%d/%m/%Y")

usethis::use_data(russia, overwrite = TRUE)
