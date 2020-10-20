
#install packages
if(!require(tidyverse)) install.packages("tidyverse", repos = "http://cran.us.r-project.org")
if(!require(shiny)) install.packages("shiny", repos = "http://cran.us.r-project.org")
if(!require(shinydashboard)) install.packages("shinydashboard", repos = "http://cran.us.r-project.org")
if(!require(plotly)) install.packages("plotly", repos = "http://cran.us.r-project.org")
if(!require(here)) install.packages("here", repos = "http://cran.us.r-project.org")
if(!require(shinythemes)) install.packages("shinythemes", repos = "http://cran.us.r-project.org")
if(!require(DT)) install.packages("DT", repos = "http://cran.us.r-project.org")
if(!require(leaflet)) install.packages("leaflet", repos = "http://cran.us.r-project.org")
if(!require(lubridate)) install.packages("lubridate", repos = "http://cran.us.r-project.org")
if(!require(COVID19)) install.packages("COVID19", repos = "http://cran.us.r-project.org")


#loading libraries

library(tidyverse)
library(shiny)
library(shinydashboard)
library(plotly)
library(here)
library(leaflet)
library(lubridate)
library(shinythemes)
library(DT)
library(COVID19)



# Wrangling data 

# india_loc <- read.csv(here("data","in.csv"))
# india_covid <- read.csv(here("data","covid_19_india.csv"))
# india_loc <- india_loc %>% select(admin,lat,lng) %>% rename("state" = "admin")
# india_covid <- india_covid %>% left_join(india_loc, by = c("State.UnionTerritory" = "state") ) %>%  rename("states" = "State.UnionTerritory") %>% select(-ï..Sno)
#write.csv(india_covid,file = here("data","india-covid.csv"))

#usloc <- read.csv(here("data","uscities.csv")) %>% select(state_id,state_name,lat,lng)
#us_covid <- read.csv(here("data","us_states_covid19_daily.csv")) %>% select(date,state,positive,negative,recovered,death,total) 
#us_covid <- us_covid %>%  select(state,positive,negative,recovered,death,total) %>% transform(us_covid$date, x = as.Date(as.character(us_covid$date), "%Y%m%d"))
#us_covid <- us_covid %>% select(x,state,positive,negative,recovered,death,total) %>% rename("date" = "x")
#write.csv(us_covid,file = here("data","us-covid.csv"))

# brazil_loc <- read.csv(here("data","brazil_cities_coordinates.csv"))
# brazil_covid <- read.csv(here("data","brazil_covid19_cities.csv"))
# brazil_abbr <- read.csv(here("data","Brazil-abbr.csv"))
# brazil_covid <- brazil_covid %>% left_join(brazil_loc,by = c("name" = "city_name"))
# brazil_covid<- brazil_covid %>% select(date,state,cases,deaths,lat,long) %>% filter(cases != 0) 
# brazil_covid <- brazil_covid %>% left_join(brazil_abbr,by = c("state" = "abbr")) %>% rename("state_name" = "state.y") %>% group_by(date,state_name,state)
# brazil_covid_sel <- brazil_covid %>% select(state,lat,long,state_name) %>% select(- date)
# brazil <- read.csv(here("data","brazil_covid19.csv"))
# brazil <- brazil %>% left_join(brazil_abbr, by = c("state" = "abbr")) %>% select(- region) %>% rename("state_name" = "state.y") 
# brazil <- as.Date(brazil$date,"%d/%m/%y")
# #brazil <- brazil %>% select(-state.y.y)
# write.csv(brazil, file = here("data","cleaned-brazil.csv"))

# russia_loc <- read.csv(here("data","isolation_daily.csv"))
# russia_covid <- read.csv(here("data","covid19-russia-cases-scrf.csv")) %>% select(Date,Region.City,Region.City.Eng,Confirmed,Recovered,Deaths)
# russia_covid <- russia_covid %>% left_join(russia_loc, by = c("Region.City" = "City")) 
# russia_covid <- russia_covid %>% select(Date.x,Region.City,Region.City.Eng,Confirmed,Deaths,Recovered,City_geo) 
# russia_covid <- russia_covid %>% separate(col = "City_geo",
#                                           into = c("lat","long"),
#                                           sep = ",") %>%
#   separate(col = "lat",
#            into = c("blank","lat"),
#            sep = "\\[") %>% 
#   separate(col = "long",
#            into = c("long","bla"),
#            sep = "\\]") 
# russia_covid <- russia_covid %>% select(-c(Region.City,blank,bla)) %>% rename(state = Region.City.Eng)
# write.csv(russia_covid,file = here("data","russia-covid19.csv"))

#reading data

india <- read.csv(here("inst/extdata/india-covid.csv"))
india$Date <- as.Date(india$Date,"%d/%m/%Y")
usa <- read.csv(here("inst/extdata/us-covid.csv"))
usa$date <- lubridate::as_date(usa$date)
brazil <- read.csv(here("inst/extdata/cleaned-brazil.csv"))
brazil$date <- as.Date(brazil$date,"%d/%m/%Y")
russia <- read.csv(here("inst/extdata/russia-covid19.csv"))
russia$Date.x <- as.Date(russia$Date.x,"%d/%m/%Y")
#covid19 <- coronavirus %>% filter(country == c("US","India","Russia","Brazil"))
corona <- COVID19::covid19() %>% filter(id == c("USA","IND","RUS","BRA"))

US_distinct <- usa %>% 
  select(state_name,lat,lng,positive) %>% 
  group_by(state_name,lat,lng) %>% 
  summarise(total = sum(positive)) %>% 
  distinct(state_name, .keep_all = TRUE)

IND_distinct <- india %>% 
  select(states,Confirmed,lat,long) %>% 
  group_by(states,lat,long) %>% 
  summarise(total = sum(Confirmed)) %>% 
  distinct(states, .keep_all = TRUE)

RUS_distinct <- russia %>% 
  select(state,Confirmed,lat,long) %>% 
  group_by(state,lat,long) %>% 
  summarise(total = sum(Confirmed)) %>% 
  distinct(state, .keep_all = TRUE)

BRAZ_distinct <- brazil %>% 
  select(state_name,lat,long,cases) %>% 
  group_by(state_name,lat,long) %>% 
  summarise(total = sum(cases)) %>% 
  distinct(state_name, .keep_all = TRUE)


ui <- fluidPage(
  fluidRow(
  navbarPage(theme = shinytheme("flatly"), collapsible = TRUE,
                 "COVID-19 in top 4 countries", id="nav",
                 tabPanel("Introduction",
                          tabsetPanel(
                            tabPanel("What is COVID-19?",
                                     sidebarPanel(
                                              tags$img(src = 'inst/www/stop.gif', width = 500, height = 800),width = 4),
                                     mainPanel(
                                     fluidRow(
                                       column(12,
                                     tags$div(
                                       tags$h4(" 'CO' stands for corona, 'VI' for virus, and
'D' for disease. Formerly, this disease was referred to as '2019 novel coronavirus' or '2019-nCoV.'"),
                                       tags$p("Coronaviruses are a large family of viruses that cause respiratory infections like SARS in 2003 and MERS in 2012.
                                       The symtoms vary from the common cold to more serious diseases. COVID-19 affects different people in different ways. 
                                       Most infected people will develop mild to moderate illness and recover without hospitalization, 
                                               there have been recent findings that the infection is found in people who did not show any symptoms that were initially seen in many people.", tags$br(),tags$br(),
                                              "It was first reported in December 2019 in Wuhan City in China. And was later observed to have spread in many different countries affecting the world and was declared a global pandemic by the",tags$a(href = "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/interactive-timeline?gclid=Cj0KCQjw8fr7BRDSARIsAK0Qqr4wzsQhAYUDj8s5VtAVTY2MoBhbc4xgZG_vD-9HTusAOVV-xJKUaq8aAi1-EALw_wcB#event-115","WHO"),
                                              "on 11th March,2020."),tags$br(),tags$br(),
                                       tags$p("Some of the most common symptoms of COVID 19 are similar to that of a common flu which is very mis-leading, but it is always adviced by the governments' of different countries that if it persits then please have a test done as soon as possible.
                                             These include:",tags$ol(tags$li("Coughing"),tags$li("Sore Throat"),tags$li("Shortness of Breath")), 
                                              tags$strong("Other symptoms may include -runny nose,muscle/joint pain,loss of smell,and many more, have a look at the other symptoms"),
                                              tags$a(href= "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/question-and-answers-hub/q-a-detail/q-a-coronaviruses#:~:text=symptoms","here")),tags$br(),
                                       tags$p("People who have travelled recently overseas/ have been in close contact with people who have been diagnosed with COVID19/aged citizens and kids are highly susceptable to the virus."),tags$br(),
                                       tags$p("This dashboard covers the top four countires that have been affected by the virus greatly till date, According to the",tags$a(href="https://coronavirus.jhu.edu/map.html","John Hopkins"),"which provides really good live updates within the news and the dashboard."),
                                       tags$p("Stop the spread of the virus, here's what you can do:",tags$strong(tags$ol(
                                         tags$li("Maintain atleast a meatre distance between yourself and others"),
                                         tags$li("Make wearing a mask a neccessity, here are some guidelines on how to wear a mask:",tags$a(href ="https://www.youtube.com/watch?v=ciUniZGD4tY&feature=youtu.be","here"),"."),
                                         tags$li("Regularly and thoroughly clean your hands with either a hand sanitiser or with soap and water"),
                                         tags$li("Cover your mouth and nose with your elbow or tissue when you cough/sneeze")))
                                       )))
                                     
                                     ))))),
             tabPanel("States within the country", 
                      tabsetPanel(
                        
                        tabPanel("United States of America",
                                 sidebarPanel(
                                   selectInput("usstate","Choose a state name:",choices = usa$state_name,selected = "Alaska"),tags$h5("Please click on either the selectInput or the leaflet for getting the state of your choice"),width = 2),
                                 mainPanel(
                                   fluidRow(
                                     column(12,
                                 leafletOutput("Leaf"),
                                  fluidRow(
                                      column(6,
                                             tabsetPanel(
                                               tabPanel("Time Plot",
                                    plotlyOutput("lineus")),
                                    tabPanel("Summary",
                                             tags$div(
                                               tags$h5("The line graph shows the number of cases within each state of USA."),
                                                       tags$p("The line has total number of cases and has date on its y-axis which shows the variance of the number of people affected with time. 
                                                              The graph shows both the number of people with the confirmed cases and also the number of people deceased because of the virus. 
                                                              It can be infered from the graph that the number of confirmed cases are higher than that of the deaths and also the number of cases are increasing over time.",tags$br(),
                                                              tags$h5(tags$strong("Please click on either the selectInput or the leaflet for getting the state of your choice"))
                                             ))))),   
                                    column(6,
                                           tabsetPanel(
                                             tabPanel("Top 5 states",
                                    plotlyOutput("colus")),
                                    tabPanel("Summary",
                                             tags$div(
                                               tags$h5("A bar graph that depicts the top 10 states within USA with the most cases recorded."),
                                               tags$p("The plot has number of confirmed cases on it's x-axis and state names on it y-axis. 
                                                      It can be infered that the state witht the highest number of infections is"),
                                               tags$strong("New York"),"followed by",tags$strong("California"),"."),tags$br(),
                                             tags$h5(tags$strong("Please click on either the selectInput or the leaflet for getting the state of your choice"))))))),width = 10))),
                     tabPanel("India",
                              sidebarPanel(
                                selectInput("instate","Choose a state name:",choices = india$states),tags$h5("Please click on either the selectInput or the leaflet for getting the state of your choice"),width = 2),
                              mainPanel(
                                fluidRow(
                                  column(12,
                                         leafletOutput("Leafin"),
                                         fluidRow(
                                           column(6,
                                                  tabsetPanel(
                                                    tabPanel("Time Plot",
                                                             plotlyOutput("linein")),
                                                    tabPanel("Summary",
                                                             tags$div(
                                                               tags$h5("The line graph shows the number of cases within each state of India"),tags$br(),tags$br(),
                                                               
                                                               tags$p("This plot depicts a line graph with date on the x-axis and the total number of cases on the y-axis. It can be read from the graph that the number of cases have a",tags$i("step-wise"),"increase in cases almost all the states within the country.
                                                                      This could be due to the",tags$i("lockdowns"),"imposed at times during the duration of the infection, till date.The number of deaths are relatively smaller than the number of positive cases within the country."),
                                                                      tags$h4(tags$strong("Please click on either the selectInput or the leaflet for getting the state of your choice")))))),   
                                           column(6,
                                                  tabsetPanel(
                                                    tabPanel("Top 5 states",
                                                             plotlyOutput("colin")),
                                                    tabPanel("Summary",
                                                             tags$div(
                                                               tags$h5("A bar graph that depicts the top 10 states with the highest number of cases within the country"),tags$br(),
                                                               tags$br(),tags$p("The bar graph potrays the number of people infected with the virus within each of the 10 states. 
                                                                                This graph has the number of people of infected on its x-axis and the states name on its y-axis.
                                                                                Even though the number of cases in India is high, the relative number of people recovered from the infection is also high"),tags$br(),
                                                               tags$p("The state with the highest number of cases is"),tags$strong("Maharashtra"),"followed by",tags$strong("Tamil Nadu"),"."),tags$br(),
                                                             tags$h5(tags$strong("Please click on either the selectInput or the leaflet for getting the state of your choice")))))))),width = 10)),
                     tabPanel("Russia",
                              sidebarPanel(
                                selectInput("russtate","Choose a state name:",choices = russia$state),tags$h5("Please click on either the selectInput or the leaflet for getting the state of your choice"),width = 2),
                              mainPanel(
                                fluidRow(
                                  column(12,
                                         leafletOutput("Leafrus"),
                                         fluidRow(
                                           column(6,
                                                  tabsetPanel(
                                                    tabPanel("Time Plot",
                                                             plotlyOutput("linerus")),
                                                    tabPanel("Summary",
                                                             tags$div(
                                                               tags$h5("A line graph depicting the total cases within each state of Russia"),tags$br(),tags$br(),
                                                               tags$p("The line graph has dates from the first known case of COVID in russia till date on it's x-axis and the number of cases on it's y-axis. 
                                                                      There are three lines which are on the graph each potraying the cases confirmed, number of people deceased and the numer of people recovered. 
                                                                      It can be analysed from the graph that there is",tags$i("step-wise"),"increase in the number of cases but what is interesting is that the number of people recovering is also high.
                                                                      The number of deaths are relatively lower."),tags$br(),
                                                               tags$h4(tags$strong("Please click on either the selectInput or the leaflet for getting the state of your choice")))))),   
                                           column(6,
                                                  tabsetPanel(
                                                    tabPanel("Top 5 states",
                                                             plotlyOutput("colrus")),
                                                    tabPanel("Summary",
                                                             tags$div(
                                                               tags$h3("A bar graph showing the top 10 states with most number of cases within Russia"),tags$br(),tags$br(),
                                                               tags$p("This bar graph has the number of cases confirmed on it's x-axis and the state names on it's y-axis,
                                                                      it can be infered from the plot that the state with the highest numberof cases is",tags$strong("Moscow"),"followed by",tags$strong("St.Petersburg"),".",tags$br(),
                                                                      tags$p("It can also be noticed that as the number of cases in Moscow and St.Petersburg is so muh higher than any other state numbers are being over-shadowed.It was also analysed during visualisation that the number of cases in other states were negligible when compared to Moscow and St.Petersburg"),tags$br(),
                                                                      tags$h5(tags$strong("Please click on either the selectInput or the leaflet for getting the state of your choice"))
                                                               )))))))),width = 10)),
                     
                     tabPanel("Brazil",
                              sidebarPanel(
                                selectInput("brastate","Choose a state name:",choices = brazil$state_name),width = 2,tags$h5("Please click on either the selectInput or the leaflet for getting the state of your choice")),
                              mainPanel(
                                fluidRow(
                                  column(12,
                                         leafletOutput("Leafbra"),
                                         fluidRow(
                                           column(6,
                                                  tabsetPanel(
                                                    tabPanel("Time Plot",
                                                             plotlyOutput("linebra")),
                                                    tabPanel("Summary",
                                                             tags$div(
                                                               tags$h5("A line plot that depicts the number of cases within each state of Brazil"),tags$br(),tags$br(),
                                                               tags$p("The plot has the dates from the date the first case was recoreded till date,
                                                                      on it's x-axis and the number of cases on it's y-axis.There are 2 lines which are plotted each of them depict the number of confirmed cases and number of deaths over time.
                                                                      It can be inefered from the graph that there is a steady increase in the number of confirmed cases and the number of deaths are lower relatively as well, which is good."),
                                                              tags$h4(tags$strong("Please click on either the selectInput or the leaflet for getting the state of your choice"))
                                                               )))),   
                                           column(6,
                                                  tabsetPanel(
                                                    tabPanel("Top 5 states",
                                                             plotlyOutput("colbra")),
                                                    tabPanel("Summary",
                                                             tags$div(
                                                               tags$h5("A bar plot depicting the top 10 states with the highest number of cases within each state of Brazil"),tags$br(),
                                                               tags$p("This plot potrays the bar graph with the number of cases on it's x-axis and the state names on it's y-axis.
                                                                      The highest number of cases is seen in",tags$strong("Sao Paulo"),"followed by", tags$strong("Rio de Janerio"),"."),tags$br(),
                                                               tags$h5(tags$strong("Please click on either the selectInput or the leaflet for getting the state of your choice")
                                                               )))))))),width = 10)))),
             tabPanel("Data",
                      sidebarPanel(tags$h3("CLICK on the Bar to get table"),tags$br(),tags$br(),
                                           tags$p("The DT table provides the data tables for the country wise dataset. 
                                                  When the plotly event plot is clicked on, the DT table gets triggered and the table is produced. 
                                                  This table is user friendly, as it",
                                                  tags$ol(tags$li("allows the user for search options"),
                                                          tags$li("highlight the rows for having a better look"),
                                                          tags$li("and lastly it also provides the data in pages so the window is not too crowded"))),
                        width = 2),
                      mainPanel(column(12,
                        DT::dataTableOutput('table'),
                        column(6, 
                               tabsetPanel(
                          tabPanel("Plotly event plot",
                                   plotlyOutput("top")),
                          tabPanel("Summary",tags$div(
                            tags$h5("Plotly event data model for plotly events"),tags$br(),
                                   tags$p("This plotly event is made using a plotly() object, 
                                          with x-axis as the country names(administrative_area_level_1,in the plot) and the total number of cases recorded within each country"),tags$br(),
                                   tags$p("This is made in a user select input situation, this event is used for user input from the user by a click on the plot, 
                                          which would trigger another event to occur, in this case:",
                                          tags$strong("when a bar within the plot is clicked,a datatable is produced with the selected country and updates itself with every click on the plot")))))),
                               column(6,
                                      tabsetPanel(
                                        tabPanel("Line Graph for countries",
                                      plotlyOutput("country")),
                                      tabPanel("Summary",tags$div(
                                        tags$h5("Line graph for four different countires for number of cases"),tags$br(),
                                        tags$p("The line graph has three different input values in each of the facet wrapped plots, with the x-axis as date and the y-axis as the number of cases. The graph shows:",tags$ol(
                                          tags$li("The country with the highest number of cases"),
                                          tags$li("The number of individual categories of the affected population: Confirmed cases, Deaths and Recovered"))," 
                                          This graph is interactive with the plotly object, so to know the values of a point in graph, hover over to the point with a mouse, and this graph is does not change with user-input",
                                          tags$p("From the four plots, it can be concluded that:",tags$ol(
                                            tags$li("The country with the highest number of cases is",
                                                    tags$strong("USA"),"followed by",tags$strong("India")),
                                            tags$li("Although India is the second in place of highest number of confirmed cases in the world, 
                                                    the number of recovered people is higher and relatively compensating the number of confirmed cases than that of USA.")
                                          ))
                                        )
                                      ))))))),
             
                 tabPanel("About this site",
                          tags$div(
                            tags$h1("Shiny Assignment"),
                            tags$h2("Author"),
                            tags$h3("Name: Varsha Ujjinni Vijay Kumar",tags$br(),"ID: 31237754"),
                            tags$h2("Purpose of this Application"),
                            tags$h3(tags$strong("COVID19"),"is the new headlines everyday, keeping up to date with the current situation of the world is a must. 
                                    This application gives the overview of the situation in the top",tags$i("four"),"most affected countries in the world currently:",
                                    tags$br(),tags$br(),tags$ol(
                                      tags$li("United States of America"),
                                      tags$li("India"),
                                      tags$li("Brazil"),
                                      tags$li("Russia"), "according to the live website:",tags$a(href = "https://coronavirus.jhu.edu/map.html","John hopkins"),
                                      ". This application was inspired from the shiny dashboard", tags$a(href = "https://shiny.rstudio.com/gallery/covid19-tracker.html","COVID mapper"),
                                      ".",tags$br(),tags$br(),"
                                      I recently came across an article which stated:",tags$strong("How Covid19 dashboards are helping people make sense of the pandemic?"),
                                      tags$a(href = "https://economictimes.indiatimes.com/tech/internet/corona-crunchers-how-covid-19-dashboards-helping-people-make-sense-of-the-pandemic/articleshow/75509406.cms","(here)"),",and it just stuck with me.",
                                      tags$br(),tags$br(),"If making dashboards shows the severiety of the situation throughout the world and helps keep the pandemic in check, then be it. 
                                      Having not only a visually appealing but also an informative dashboard is very important. To reach out to the people and bring awareness on the unforeseen circumstances and bring them the latest news and precautions they can take to stay safe.",
                                      tags$br(),tags$br(),tags$i("Hope you enjoy the dashboard as much as I enjoyed making it.")
                                    ))
                          )
                 ),
             tabPanel("References", 
                      tags$div(
                        tags$h4("1. Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source Software, 4(43), 1686,
  https://doi.org/10.21105/joss.01686", tags$br(),tags$br(),
                                "2. Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny: Web Application
  Framework for R. R package version 1.5.0. https://CRAN.R-project.org/package=shiny",tags$br(),tags$br(),
                                "3. Winston Chang and Barbara Borges Ribeiro (2018). shinydashboard: Create Dashboards with 'Shiny'. R
  package version 0.7.1. https://CRAN.R-project.org/package=shinydashboard",tags$br(),tags$br(),
                                "4. C. Sievert. Interactive Web-Based Data Visualization with R, plotly, and shiny. Chapman and Hall/CRC
  Florida, 2020.",tags$br(),tags$br(),
                                "5. Kirill Müller (2017). here: A Simpler Way to Find Your Files. R package version 0.1.
  https://CRAN.R-project.org/package=here",tags$br(),tags$br(),
                                "6. Joe Cheng, Bhaskar Karambelkar and Yihui Xie (2019). leaflet: Create Interactive Web Maps with the
  JavaScript 'Leaflet' Library. R package version 2.0.3. https://CRAN.R-project.org/package=leaflet", tags$br(),tags$br(),
                                "7. Garrett Grolemund, Hadley Wickham (2011). Dates and Times Made Easy with lubridate. Journal of
  Statistical Software, 40(3), 1-25. URL http://www.jstatsoft.org/v40/i03/.",tags$br(),tags$br(),
                                "8.  Winston Chang (2018). shinythemes: Themes for Shiny. R package version 1.1.2.
  https://CRAN.R-project.org/package=shinythemes",tags$br(),tags$br(),
                                "9.Yihui Xie, Joe Cheng and Xianying Tan (2020). DT: A Wrapper of the JavaScript Library 'DataTables'. R
  package version 0.15. https://CRAN.R-project.org/package=DT",tags$br(),tags$br(),
                                "10.Guidotti, E., Ardia, D., (2020), COVID-19 Data Hub, Journal of Open Source Software 5(51):2376, doi:10.21105/joss.02376.",
                                tags$br(),tags$br(),
                                "11. Hadley Wickham and Dana Seidel (2020). scales: Scale Functions for Visualization. R package version
  1.1.1. https://CRAN.R-project.org/package=scales" ,tags$br(),tags$br(),
                                "12.Fox And Co Staysafe GIF by Fox & Co Design - Find & Share on GIPHY. (2020). Retrieved 9 October 2020, from https://media.giphy.com/media/f9vtArcZ6uqc1FhucD/giphy.gif 
                                Retrieved 8 October 2020, from https://media.giphy.com/media/UUsOy6IWmzw6mmeOpQ/giphy.gif",tags$br(),tags$br(),
                                "13. Wikipedia. (2020). Retrieved 8 October 2020, from https://www.wikipedia.org/",tags$br(),tags$br(),
                                "14.Shiny - Application layout guide. (2020). Retrieved 8 October 2020, from https://shiny.rstudio.com/articles/layout-guide.html",
                                tags$br(),tags$br(),
                                "15.COVID-19 in India. (2020). Retrieved 8 October 2020, from https://www.kaggle.com/sudalairajkumar/covid19-in-india",tags$br(),tags$br(),
                                "16.Coronavirus - Brazil. (2020). Retrieved 8 October 2020, from https://www.kaggle.com/unanimad/corona-virus-brazil",tags$br(),tags$br(),
                                "17.COVID-19 Russia regions cases. (2020). Retrieved 8 October 2020, from https://www.kaggle.com/kapral42/covid19-russia-regions-cases",tags$br(),tags$br(),
                                "18.COVID-19 in USA. (2020). Retrieved 8 October 2020, from https://www.kaggle.com/sudalairajkumar/covid19-in-usa",tags$br(),tags$br(),
                                "19.Shiny - Shiny HTML Tags Glossary. (2020). Retrieved 9 October 2020, from https://shiny.rstudio.com/articles/tag-glossary.html",tags$br(),tags$br(),
                                "20.Carson Sievert Software Engineer, 2. (2020). Linking plotly graphs in shiny. Retrieved 9 October 2020, from https://talks.cpsievert.me/20191115/#14"
                                  )
                      ))
  )
), align = 'justify'
)






server <- function(input,output,session){
  
  output$top <- renderPlotly({
    corona %>% 
      plot_ly(x = ~administrative_area_level_1,y = ~confirmed,source = "corona")
  })
  
  
  output$table <- DT::renderDataTable({
    d <- event_data("plotly_click",source = "corona")
    if(is.null(d)) return(NULL)
    
    corona %>% filter(administrative_area_level_1 == d$x) %>%  
      select(id,date,tests,confirmed,deaths,recovered,population,administrative_area_level_1,stringency_index)
  })
  
  output$country <- renderPlotly({ 
    plot1 <- corona %>% 
      group_by(administrative_area_level_1,date) %>% 
      summarise(cases = sum(confirmed),deaths = sum(deaths), recovered = sum(recovered)) %>% 
      ggplot(aes(
        x = date)) +
      geom_line(aes(y= cases,color = "Posititve")) +
      geom_line(aes(y= deaths,color = "Deaths"))+
      geom_line(aes(y= recovered,color = "Cured"))+
      facet_wrap(~ administrative_area_level_1, ncol = 2) +
      theme(legend.position = "right",axis.text.y  = element_blank(),legend.title = element_blank())
    ggplotly(plot1)
  })
  
        icons <- awesomeIcons(
          icon = 'bolt',
          iconColor = 'darkred',
          markerColor = 'black',
          library = 'fa'
        )
        
        output$Leaf <- renderLeaflet({
          leaflet(US_distinct) %>%
            addTiles() %>% 
            addAwesomeMarkers(icon = icons,lng = US_distinct$lng, lat = US_distinct$lat,
                             popup = paste("State:",US_distinct$state_name,"<br>",
                                           "Total Cases:",US_distinct$total,"<br>"),
                             layerId = US_distinct$state_name)
        })
        
        observeEvent(input$Leaf_marker_click, { 
          p <- input$Leaf_marker_click
          updateSelectInput(session, "usstate", selected = c(input$usstate,p$id))
        })
        
        
        
        output$lineus <- renderPlotly({
          
          if (nchar(input$usstate) == 0) { 
            state <- "Alaska" 
          } 
          else { 
            state <- input$usstate 
          }
          
          p2 <-usa %>%
            select(date,state_name,positive,negative,death) %>%
            filter(state_name == state) %>% 
            mutate(month = month(date)) %>% 
            ggplot(aes(x = month)) +
            geom_line(aes(y = positive, color = "positive cases")) +
            geom_line(aes(y = death,color = "Deaths")) +
            ggtitle(paste("State:",input$usstate)) +
            theme(axis.text.x=element_blank(),legend.position = "right",legend.title = element_blank()) +
            scale_y_continuous(n.breaks = NULL)
          ggplotly(p2)
          
        })
        
        
        output$colus <- renderPlotly({
          p3 <- usa %>% select(state_name,positive,negative,recovered,death) %>% 
            group_by(state_name) %>% 
            summarise(total_cases = sum(positive),total_negative = sum(negative),total_deaths = sum(death),total_recovered = sum(recovered)) %>%
            arrange(desc(total_cases)) %>% head(10) %>% 
            ggplot(aes(
              x = reorder(state_name, total_cases),
              y = total_cases
            )) +
            geom_col(fill = "#990000") +
            theme(axis.text.x=element_blank(),legend.position = "none") +
            ylab("Positive cases") +
            xlab("States") +
            coord_flip()
          ggplotly(p3)
        })
        
        output$Leafin <- renderLeaflet({
          leaflet(IND_distinct) %>%
            addTiles() %>% 
            addAwesomeMarkers(icon = icons,lng = IND_distinct$long, lat = IND_distinct$lat,
                              popup = paste("State:",IND_distinct$states,"<br>",
                                            "Total Cases:",IND_distinct$total,"<br>"),
                              layerId = IND_distinct$states)
        })
        
        observeEvent(input$Leafin_marker_click, { 
          p <- input$Leafin_marker_click
          updateSelectInput(session, "instate", selected = c(input$instate,p$id))
        })
        
        output$linein <- renderPlotly({
          if (nchar(input$instate) == 0) { 
            state <- "Karnataka" 
          } 
          else { 
            state <- input$instate 
          }
          p4 <- india %>%
            select(Date,states,Confirmed,Cured,Deaths) %>%
            filter(states == state) %>% 
            group_by(states,Date) %>% 
            summarise(total_cases = sum(Confirmed),total_deaths = sum(Deaths),total_cured = sum(Cured)) %>%
            mutate(month = month(Date)) 
          
          graph <- ggplot(p4,aes(x = month)) +
            geom_line(aes(y = total_cases,color = "positive cases")) +
            geom_line(aes(y = total_deaths,color = "Deaths")) +
            geom_line(aes(y = total_cured,color = "Recovered"))+
            ggtitle(paste("State:",input$instate)) +
            theme(axis.text.x=element_blank(),legend.position = "right",legend.title = element_blank()) +
            scale_y_continuous(n.breaks = NULL)
          ggplotly(graph)
        })
        
        output$colin <- renderPlotly({
          p5 <- india %>% select(states,Confirmed) %>% 
            group_by(states) %>% 
            summarise(total_cases = sum(Confirmed)) %>%
            arrange(desc(total_cases)) %>% head(10) %>% 
            ggplot(aes(
              x = reorder(states, total_cases),
              y = total_cases
            )) +
            geom_col(fill = "#990000") +
            theme(axis.text.x=element_blank(),legend.position = "none") +
            ylab("Positive cases") +
            xlab("States") +
            coord_flip()
          ggplotly(p5)
        })
        
        output$Leafrus <- renderLeaflet({
          leaflet(RUS_distinct) %>%
            addTiles() %>% 
            addAwesomeMarkers(icon = icons,lng = RUS_distinct$long, lat = RUS_distinct$lat,
                              popup = paste("State:",RUS_distinct$state,"<br>",
                                            "Total Cases:",RUS_distinct$total,"<br>"),
                              layerId = RUS_distinct$state)
        })
        
        observeEvent(input$Leafrus_marker_click, { 
          p <- input$Leafrus_marker_click
          updateSelectInput(session, "russtate", selected = c(input$russtate,p$id))
        })
        
        output$linerus <- renderPlotly({
          if (nchar(input$russtate) == 0) { 
            states <- "Moscow" 
          } 
          else { 
            states <- input$russtate 
          }
        p6 <- russia %>%
            select(Date.x,state,Confirmed,Recovered,Deaths) %>%
            filter(state == states) %>% 
          group_by(state,Date.x) %>% 
          summarise(total_cases = sum(Confirmed),total_deaths = sum(Deaths),total_cured = sum(Recovered)) %>%
            mutate(month = month(Date.x)) %>%  
            ggplot(aes(x = month)) +
            geom_line(aes(y = total_cases,color = "Confirmed")) +
            geom_line(aes(y = total_deaths,color = "Deaths")) +
            geom_line(aes(y = total_cured,color = "Recovered"))+
            ggtitle(paste("State:",input$russtate)) +
            theme(axis.text.x=element_blank(),legend.position = "right",legend.title = element_blank()) +
            scale_y_continuous(n.breaks = NULL)
          ggplotly(p6)
        })
        
        output$colrus <- renderPlotly({
          p7 <- russia %>% select(state,Confirmed) %>% 
            group_by(state) %>% 
            summarise(total_cases = sum(Confirmed)) %>%
            arrange(desc(total_cases)) %>% head(15) %>% 
            ggplot(aes(
              x = reorder(state, total_cases),
              y = total_cases)) +
            geom_col(fill = "#990000") +
            theme(axis.text.x=element_blank(),legend.position = "none") +
            ylab("Positive cases") +
            xlab("States") +
            coord_flip()
          ggplotly(p7)
        })
        
        output$Leafbra <- renderLeaflet({
          leaflet(BRAZ_distinct) %>%
            addTiles() %>% 
            addAwesomeMarkers(icon = icons,lng = BRAZ_distinct$long, lat = BRAZ_distinct$lat,
                              popup = paste("State:",BRAZ_distinct$state_name,"<br>",
                                            "Total Cases:",BRAZ_distinct$total,"<br>"),
                              layerId = BRAZ_distinct$state_name)
        })
        
        observeEvent(input$Leafbra_marker_click, { 
          p <- input$Leafbra_marker_click
          updateSelectInput(session, "brastate", selected = c(input$brastate,p$id))
        })
        
        output$linebra <- renderPlotly({
          if (nchar(input$brastate) == 0) { 
            state <- "Sao Paulo" 
          } 
          else { 
            state <- input$brastate 
          }
          p8 <- brazil %>%
            select(date,state_name,cases,deaths) %>%
            filter(state_name == state) %>% 
            group_by(state_name,date) %>% 
            summarise(total_cases = sum(cases),total_deaths = sum(deaths)) %>%
            mutate(month = month(date)) %>%  
            ggplot(aes(x = month)) +
            geom_line(aes(y = total_cases,color = "Confirmed")) +
            geom_line(aes(y = total_deaths,color = "Deaths")) +
            ggtitle(paste("State:",input$brastate)) +
            theme(axis.text.x=element_blank(),legend.position = "right") +
            scale_y_continuous(n.breaks = NULL)
          ggplotly(p8)
        })
        
        output$colbra <- renderPlotly({
          p9 <- brazil %>% select(state_name,cases) %>% 
            group_by(state_name) %>% 
            summarise(total_cases = sum(cases)) %>%
            arrange(desc(total_cases)) %>% head(10) %>% 
            ggplot(aes(
              x = reorder(state_name, total_cases),
              y = total_cases)) +
            geom_col(fill = "#990000") +
            theme(axis.text.x=element_blank(),legend.position = "none") +
            ylab("Positive cases") +
            xlab("States") +
            coord_flip()
          ggplotly(p9)
        })
        
}

shinyApp(ui = ui, server = server)