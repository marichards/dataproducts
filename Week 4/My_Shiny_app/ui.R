library(shiny)
library(leaflet)

shinyUI(fluidPage(

  # Application title
  titlePanel("Good Food Around Seattle, WA"),

  # Sidebar with a Check box input 
  sidebarLayout(
    sidebarPanel(
      h2("Choose Your Filters"),
      p("(Please check at least 1 box)"),
      checkboxInput("brunch","Show Brunch", value = TRUE),
      checkboxInput("upscale","Show Upscale", value = TRUE),
      checkboxInput("seafood","Show Seafood", value = TRUE),
      checkboxInput("sandwiches","Show Sandwiches", value = TRUE),
      checkboxInput("thai", "Show Thai", value = TRUE),
      checkboxInput("bakery", "Show Bakeries", value = TRUE),
      submitButton("Update Map")
    ),
    mainPanel(
      leafletOutput("map1"),
      h2("Instructions for Use"),
      tags$ol(
        tags$li("Select your restaurant filters using the checkboxes"),
        tags$li("Click 'Update Map' to apply the filters and update the map"),
        tags$li("Use the map to zoom in and out"),
        tags$li("Click on a colored marker to display the restaurant name, which links to its website")
      )
      )
    )
  )
)
