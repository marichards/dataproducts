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
      checkboxInput("happyhour", "Show Happy Hour", value = TRUE),
      checkboxInput("desserts", "Show Desserts", value = TRUE),
      h2("Add a New Restaurant?"),
      textInput("new.gmap","Enter a Google Maps link:"),
      selectInput("new.type", "Category:", 
                  c("Seafood",
                    "Sandwiches",
                    "Brunch",
                    "Upscale",
                    "Thai",
                    "Bakeries",
                    "Happy Hour",
                    "Desserts")),
      textInput("new.link","Enter New Hyperlink:"),
      textInput("new.name", "Enter new name:"),
      actionButton("action2","Add to Map"),
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
      h3("Adding a Restaurant"),
      tags$ol(
        tags$li("Enter your restaurant's Google Maps"),
        tags$li("Select a category for the restaurant"),
        tags$li("Enter a hyperlink to the restaurant's website"),
        tags$li("Enter the name of the restaurant"),
        tags$li("Click the 'Add to Map' button"),
        tags$li("Refresh the app")
                )
      )
    )
  )
)
