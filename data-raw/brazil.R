#' BRAZIL covid19 dataset
#' 
#' This dataset contains the data for the number of cases, deaths and recovered in Brazil. This dataset contains the counts until October 2020.
#' 
#' 

#reading the csv file 

brazil <- read.csv("inst/extdata/cleaned-brazil.csv")

#wrangling dataset

brazil$date <- as.Date(brazil$date,"%d/%m/%Y")

usethis::use_data(brazil, overwrite = TRUE)
