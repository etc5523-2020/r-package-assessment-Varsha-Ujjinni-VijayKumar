#' USA distinct state dataset
#' 
#' Wrangling for the leaflets which contains the distinct state wise values in the dataframe.
#' 

usa <- read.csv(here("inst/extdata/us-covid.csv"))
usa$date <- lubridate::as_date(usa$date)

USA_distinct <- usa %>% 
  select(state_name,lat,lng,positive) %>% 
  group_by(state_name,lat,lng) %>% 
  summarise(total = sum(positive)) %>% 
  distinct(state_name, .keep_all = TRUE)


usethis::use_data(USA_distinct, overwrite = TRUE)
