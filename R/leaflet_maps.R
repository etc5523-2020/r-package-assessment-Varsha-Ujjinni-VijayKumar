#' Leaflet maps for each country
#' 
#' 
#' @author Varsha Ujjinni Vijay Kumar
#' 
#' 
#' @param longitude A column passed from the dataframe which contains the longitude for the maps.
#' @param latitude A column passed from the dataframe which contains the latitude for the maps.
#' @param state A column passed from the dataframe which contains the state names for the popup on the leaflet maps.
#' @param total_cases A column passed from the dataframe which cintains the total number of cases for each state.
#' 
#' @return returns a leaflet map with longitudes and latitudes for the map with state names.
#' 
#' @examples 
#' \dontrun{
#' leaflet(longitude = df$lng,latitude = df$lat, state = df$state,total_cases = df$total_cases)
#' }
#' 
#' @description This function helps the user make a leaflet map using the latitude and longitudes for the states/region/country you are visualizing. There are many datasets within this package which can used as examples for checking the function like the BRA_distinct for Brazilian states, IND_distinct for Indian states, USA_distinct  for USA states and RUS_distinct for Russian states. 
#' 
#' @import leaflet
#' @importFrom  magrittr %>% 
#' 
#' @export

leaflet_maps <- function(longitude,latitude,state,total_cases){
  
  icons1 <- awesomeIcons(
    icon = 'bolt',
    iconColor = 'darkred',
    markerColor = 'black',
    library = 'fa'
  )
  
  return(leaflet::leaflet() %>% 
           addTiles() %>% 
           addAwesomeMarkers(icon = icons1, lng = longitude, lat = latitude,
                             popup = paste("State:", state,"<br>",
                                           "Total Cases:",total_cases,"<br>"),
                             layerId = state))
}