#' State Select Input
#' 
#' @description This function helps us get the select Input function from the shiny package using the two arguments id and x, using just the two arguments.The purpose of this function is to provide a quick select input for different values in the column.  
#' 
#' 
#' @author Varsha Ujjinni Vijay Kumar
#' 
#' @param id The input ID of the select Input that is passed to the app by the user.
#' @param x The column in the dataframe that contains the country names.
#' 
#' @examples 
#' \dontrun{
#' stateInput(id = "state", x = usa$state)
#' }
#' 
#' @export


stateInput <- function(id,x){
  
  shiny::selectInput(inputId = id,
                     label = "Choose a state name:",
                     choices = x,
                     selected = "")
  
}