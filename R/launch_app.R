#' Launch the shiny app 
#' 
#' This function helps the user of the package to get easily the shiny application dashboard for COVID19 cases which depicts the countries with the highest number of cases within the top 4 countries until October 2020. It launches the application for user interactivity and a number of visualizations.
#'
#'
#'   @export
launch_app <- function() {
  appDir <- system.file("app", "app.R", package = "COVID19top4")
  if (appDir == "") {
    stop("Could not load/find the requested directory. Try re-installing `COVID19top4` package.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}

"launch_app"