#' USA covid19 dataset
#' 
#' This dataset contains the data for the number of cases, deaths and recovered in USA. This dataset contains the counts until October 2020.
#' 
#' 

# reading the dataset 
usa <- read.csv(here::here("inst/extdata/us-covid.csv"))

#wrangling the dataset

usa$date <- lubridate::as_date(usa$date)


usethis::use_data(usa, overwrite = TRUE)
