#' Distinct Brazilian states dataset for COVID19  
#'
#' Wrangling for the leaflets which contains the distinct state wise values in the dataframe. 

brazil <- read.csv(here("inst/extdata/cleaned-brazil.csv"))
brazil$date <- as.Date(brazil$date,"%d/%m/%Y")

BRA_distinct <- brazil %>% 
  select(state_name,lat,long,cases) %>% 
  group_by(state_name,lat,long) %>% 
  summarise(total = sum(cases)) %>% 
  distinct(state_name, .keep_all = TRUE)

usethis::use_data(BRA_distinct, overwrite = TRUE)
