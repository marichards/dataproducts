
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)

shinyUI(fluidPage(

  # Application title
  titlePanel("Good Food Around Seattle, WA"),

  # Sidebar with a Check box input 
  sidebarLayout(
    sidebarPanel(
      checkboxInput("brunch","Show Brunch", value = TRUE),
      checkboxInput("upscale","Show Upscale", value = TRUE),
      checkboxInput("seafood","Show Seafood", value = TRUE),
      checkboxInput("sandwiches","Show Sandwiches", value = TRUE),
      submitButton("Update Map")
    ),
    mainPanel(
      leafletOutput("map1")
      )
    
                  
    )

    
  )
)
