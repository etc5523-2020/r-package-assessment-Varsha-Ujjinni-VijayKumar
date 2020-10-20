#' Distinct Brazilian states dataset for COVID19  
#'
#' Wrangling for the leaflets which contains the distinct state wise values in the dataframe. 

russia <- read.csv(here("inst/extdata/russia-covid19.csv"))
russia$Date.x <- as.Date(russia$Date.x,"%d/%m/%Y")

RUS_distinct <- russia %>% 
  select(state,Confirmed,lat,long) %>% 
  group_by(state,lat,long) %>% 
  summarise(total = sum(Confirmed)) %>% 
  distinct(state, .keep_all = TRUE)


usethis::use_data(RUS_distinct, overwrite = TRUE)
