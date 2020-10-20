#' COVID19 dataset from COVID19 package
#' 
#' Coronavirus global pandemic real-time dataset for the world from the COVID19 R package available in CRAN. 

corona <- COVID19::covid19() %>% filter(id == c("USA","IND","RUS","BRA"))


usethis::use_data(corona, overwrite = TRUE)
