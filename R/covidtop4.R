#' COVID19 dataset real-time
#' 
#' A real time dataset which contains the coronavirus cases, deaths and recovered within each country throughout the world each day.
#' 
#' @format A dataframe with 271 rows and 35 variables:
#' * **id**: The 3 character country ID for every country in the world.
#' * **date**: The date for each day the cases were recorded
#' * **test**: The number of tests conducted in that day in that country.
#' * **confirmed**:The number of cases that were tested to be positive.
#' * **recovered**: The number of cases that were recovered that day in the country.
#' * **deaths**: The number of deaths that day in the country.
#' * **population**: The number of people within that country(census).
#' * **school closing**: The number of schools closed during the pandemic each day.
#' @references  [COVID19 package](https://cran.r-project.org/package=COVID19)
#' @docType data
#' @name corona
#' @usage corona
"corona"

#' COVID19 dataset for India 
#' 
#' A dataset for the number of coronavirus cases within the country India, cases, deaths and recovered.Data available till October 2020.
#' 
#' @format  A dataframe of 6806 rows and 11 variables
#' * **Date**: The date at which the count of confirmed  cases is recorded.
#' * **Time**: The time at which the cases was recorded.
#' * **states**: Name of the states within the country for which the covid pandemic was affected.
#' * **ConfrmedIndiaNational**: The number of Indian nationals who are recorded to have been affected.
#' * **ConfirmedForeignNational**: The number of foreign nationals who are recorded to have been affected with the pandemic.
#' * **Cured**: The number of people who have been recovered on that day in that state.
#' * **Deaths**: The number of people who have been recorded for deaths by the virus.
#' * **Confirmed**: Number of cases recorded within the state.
#' * **lat**: The latitude of the state.
#' * **long**: The longitude of the state.
#' @references [India](https://www.kaggle.com/sudalairajkumar/covid19-in-india)
#' @docType data
#' @name india
#' @usage india
"india"


#' COVID19 dataset for United States of America 
#' 
#' A dataset for the number of coronavirus cases within the country USA, cases, deaths and recovered.Data available till October 2020.
#' 
#' @format  A dataframe of 11634 rows and 11 variables
#' * **Date**: The date at which the count of confirmed  cases is recorded.
#' * **state**: Abbreviation of the states within the country for which the covid pandemic was affected.
#' * **recovered**: The number of people who have been recovered on that day in that state.
#' * **death**: The number of people who have been recorded for deaths by the virus.
#' * **positive**: Number of cases recorded within the state.
#' * **total**: Total number of cases within each state.
#' * **state_name**: Names of the states in USA .
#' * **lat**: The latitude of the state.
#' * **long**: The longitude of the state.
#' @references [USA](https://www.kaggle.com/sudalairajkumar/covid19-in-usa)
#' @docType data
#' @name usa
#' @usage usa
"usa"

#' COVID19 dataset for Brazil 
#' 
#' A dataset for the number of coronavirus cases within the country Brazil, cases, deaths and recovered.Data available till October 2020.
#' 
#' @format  A dataframe of 5944 rows and 8 variables
#' * **Date**: The date at which the count of confirmed  cases is recorded.
#' * **state**: Abbreviation of the states within the country for which the covid pandemic was affected.
#' * **deaths**: The number of people who have been recorded for deaths by the virus.
#' * **cases**: Number of cases recorded within the state.
#' * **state_name**: Names of the states in USA .
#' * **lat**: The latitude of the state.
#' * **long**: The longitude of the state.
#' @references [Brazil](https://www.kaggle.com/unanimad/corona-virus-brazil)
#' @docType data
#' @name brazil
#' @usage brazil
"brazil"

#' COVID19 dataset for Russia 
#' 
#' A dataset for the number of coronavirus cases within the country Russia, cases, deaths and recovered.Data available till October 2020.
#' 
#' @format  A dataframe of 61209 rows and 8 variables
#' * **Date.x**: The date at which the count of confirmed  cases is recorded.
#' * **Deaths**: The number of people who have been recorded for deaths by the virus.
#' * **Confirmed**: Number of cases recorded within the state.
#' * **Recovered**: Number of people who have are recovered that day.
#' * **state**: Names of the states in USA .
#' * **lat**: The latitude of the state.
#' * **long**: The longitude of the state.
#' @references [Russia](https://www.kaggle.com/kapral42/covid19-russia-regions-cases)
#' @docType data
#' @name russia
#' @usage russia
"russia"


#'COVID19 dataset for Brazilian individual states
#'
#'A dataset for the number of coronavirus cases within the brazilian states and territories.
#'
#'@format A dataframe of 27 rows and  4 columns
#' * **state_name**: The name of the states and territories
#' * **lat**: The latitude of the state
#' * **long**: The longitude of the state
#' * **total**: The total number of cases within each state
#' 
#' @references taken from the above websites and some data acquiring from wikipedia from my end 
#' @docType data
#' @name BRA_distinct
#' @usage BRA_distinct
"BRA_distinct"

#'COVID19 dataset for USA individual states
#'
#'A dataset for the number of coronavirus cases within the USA states and territories.
#'
#'@format A dataframe of 54 rows and  4 columns
#' * **state_name**: The name of the states and territories
#' * **lat**: The latitude of the state
#' * **lng**: The longitude of the state
#' * **total**: The total number of cases within each state
#' 
#' @references taken from the above kaggle websites and some data acquiring from wikipedia from my end 
#' @docType data
#' @name USA_distinct
#' @usage USA_distinct
"USA_distinct"

#'COVID19 dataset for Indian individual states
#'
#'A dataset for the number of coronavirus cases within the Indian states and territories.
#'
#'@format A dataframe of 37 rows and  4 columns
#' * **states**: The name of the states and territories
#' * **lat**: The latitude of the state
#' * **long**: The longitude of the state
#' * **total**: The total number of cases within each state
#' 
#' @references taken from the above websites and some data acquiring from wikipedia from my end 
#' @docType data
#' @name IND_distinct
#' @usage IND_distinct
"IND_distinct"

#'COVID19 dataset for Russian individual states
#'
#'A dataset for the number of coronavirus cases within the Russian states and territories.
#'
#'@format A dataframe of 84 rows and  4 columns
#' * **state**: The name of the states and territories
#' * **lat**: The latitude of the state
#' * **long**: The longitude of the state
#' * **total**: The total number of cases within each state
#' 
#' @references taken from the above websites and some data acquiring from wikipedia from my end 
#' @docType data
#' @name RUS_distinct
#' @usage RUS_distinct
"RUS_distinct"
