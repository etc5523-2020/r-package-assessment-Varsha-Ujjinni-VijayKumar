library(testthat)
library(leaflet)

icons1 <- awesomeIcons(
  icon = 'bolt',
  iconColor = 'darkred',
  markerColor = 'black',
  library = 'fa')

test_that("leaflet works", {
  expect_equal(leaflet_maps(USA_distinct$lng,USA_distinct$lat,USA_distinct$state_name,USA_distinct$total),

  leaflet::leaflet() %>% 
           addTiles() %>% 
           addAwesomeMarkers(icon = icons1, lng = USA_distinct$lng, lat = USA_distinct$lat,
                             popup = paste("State:", USA_distinct$state_name,"<br>",
                                           "Total Cases:",USA_distinct$total,"<br>"),
                             layerId = USA_distinct$state_name))
})
