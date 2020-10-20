#' Distinct Indian states dataset for COVID19  
#'
#' Wrangling for the leaflets which contains the distinct state wise values in the dataframe. 

india <- read.csv(here::here("inst/extdata/india-covid.csv"))
india$Date <- as.Date(india$Date,"%d/%m/%Y")


IND_distinct <- india %>% 
  select(states,Confirmed,lat,long) %>% 
  group_by(states,lat,long) %>% 
  summarise(total = sum(Confirmed)) %>% 
  distinct(states, .keep_all = TRUE)


usethis::use_data(IND_distinct, overwrite = TRUE)
