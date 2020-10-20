#' Leaflet maps for each country
#' 
#' @author Varsha Ujjinni Vijay Kumar
#' 
#' @param data_frame: A dataframe which is passed for the leaflet to be produced from
#' @param longitude: A column passed from the dataframe which contains the longitude for the maps.
#' @param latitude: A column passed from the dataframe which contains the latitude for the maps.
#' @param state: A column passed from the dataframe which contains the state names for the popup on the leaflet maps.
#' @param total_cases: A column passed from the dataframe which cintains the total number of cases for each state.
#' @param BRA_distinct: A dataset wrangled from the individual state datasets for leaflet maps, can be used as datasets for the leaflet maps from the data folder.
#' @param IND_distinct: A dataset wrangled from the individual state datasets for leaflet maps, can be used as datasets for the leaflet maps from the data folder.
#' @param USA_distinct: A dataset wrangled from the individual state datasets for leaflet maps, can be used as datasets for the leaflet maps from the data folder.
#' @param RUS_distinct: A dataset wrangled from the individual state datasets for leaflet maps, can be used as datasets for the leaflet maps from the data folder.
#' 
#' @return returns a leaflet map with longitudes and latitudes for the map with state names.
#' 
#' @examples 
#' \dontrun{
#' leaflet(data_frame = df, longitude = df$lng,latitude = df$lat, state = df$state,total = df$total_cases)
#' }
#' 
#' 
#' @export

leaflet_maps <- function(data_frame,longitude,latitude,state,total_cases){
  
  icons1 <- awesomeIcons(
    icon = 'bolt',
    iconColor = 'darkred',
    markerColor = 'black',
    library = 'fa'
  )
  
  return(leaflet::leaflet(data_frame) %>% 
           addTiles() %>% 
           addAwesomeMarkers(icon = icons1, lng = longitude, lat = latitude,
                             popup = paste("State:", state,"<br>",
                                           "Total Cases:",total_cases,"<br>"),
                             layerId = state))
}