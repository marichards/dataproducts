library(shiny)
library(leaflet)

shinyUI(fluidPage(

  # Application title
  titlePanel("Excellent Food Around Seattle, WA"),

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
      h2("How Far Away is My Restaurant?"),
      selectInput("place.id",label = "My Restaurant:",
                  list('Seafood'= c("Anthony's Pier 66",
                                    "Duke's Chowder House",
                                    "Pike Place Market"),
                       'Sandwiches' = c("Rain Shadow Meats",
                                        "Salumi",
                                        "Tat's Deli",
                                        "Un Bien"),
                       'Brunch' = c("The Butcher & The Baker",
                                    "Portage Bay Cafe",
                                    "Roxy's Diner"),
                       'Upscale' = c("The Harvest Vine",
                                     "Tilth",
                                     "The Whale Wins"),
                       'Thai' = c("Jai Thai",
                                  "Thai Kitchen",
                                  "Wedgewood II Vegetarian Thai"),
                       'Bakeries' = c("Bakery Nouveau",
                                      "Cafe Besalu",
                                      "Crumble and Flake",
                                      "Sea Wolf Bakers")
                  )
                  ),
      numericInput("new.lg","Enter Your Longitude", min = -122.4, , max = -122.2, step = 0.0001, value = -122.3),
      numericInput("new.lt","Enter Your Latitude",min = 47.5, max = 47.7, step = 0.0001, value=47.6),
      actionButton("action2","Calculate Distance (in Miles)"),
      textOutput("text1")
    ),
    mainPanel(
      leafletOutput("map1"),
      h2("Instructions for Use"),
      h3("Map and Filtering Instructions"),
      tags$ol(
        tags$li("Select your restaurant filters using the checkboxes"),
        tags$li("Use the map to zoom in and out"),
        tags$li("Click on a colored marker to display the restaurant name, which links to its website")
      ),
      h3("Distance Calculation Instructions"),
      tags$ol(
        tags$li("Select your restaurant from the drop-down menu"),
        tags$li("Find your starting coordinates (e.g. using Google Maps"),
        tags$li("Enter your longitude and latitude either by typing or by clicking the arrow in the numeric input boxes"),
        tags$li("Click 'Calculate Distance' to see the distance from your starting location to your chosen restaurant")
      )
      )
    )
  )
)
