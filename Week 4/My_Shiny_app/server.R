
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)

shinyServer(function(input, output) {

  # Create the data frame of all locations
  seattle_loc <- data.frame(
    lat = c(47.60972,47.5994409,47.6816841,47.6611935,
            47.67538,47.6577795,47.6225807,47.6861061),
    lng = c(-122.344387,-122.3312286,-122.3786947,-122.3422866,
            -122.327614,-122.3197193,-122.2994758,-122.3403572),
    col = c("blue", "red", "red","purple",
            "green","green","purple","blue"),
    stringsAsFactors = FALSE,
    sites <- c(
    "<a href='http://pikeplacemarket.org/'>Pike Place Market</a>",
    "<a href='http://www.salumicuredmeats.com/'>Salumi</a>",
    "<a href='http://unbienseattle.com/'>Un Bien</a>",
    "<a href='http://tilthrestaurant.com/home/'>Tilth</a>",
    "<a href='http://www.butcherbakerseattle.com/'>The Butcher & The Baker</a>",
    "<a href='http://www.portagebaycafe.com/'>Portage Bay Cafe</a>",
    "<a href='http://www.harvestvine.com/'>The Harvest Vine</a>",
    "<a href='http://www.dukeschowderhouse.com/locations/green-lake/'>Duke's Chowder House</a>"
  ))
  

  
  location.selector <- reactive({
    #input$update # Update if the button is clicked
    # Create the color and labels data frame
    legend.info <- data.frame(labels =  c("Seafood",
                                          "Sandwiches",
                                          "Brunch",
                                          "Upscale"),
                              colors = c("blue",
                                         "red",
                                         "green",
                                         "purple"))
    
    button.logic <- c(input$seafood,
                      input$sandwiches,
                      input$brunch,
                      input$upscale)
    final.legend <- legend.info[button.logic,]
    final.locations <- subset(seattle_loc, col %in% final.legend$colors)
    return(list(final.legend,final.locations))
  })
  
  # Narrow down the data frames based on input
  output$map1 <- renderLeaflet({location.selector()[[2]] %>%
                     leaflet() %>%
                     addTiles() %>%
                     addCircleMarkers(popup = location.selector()[[2]]$sites,
                                      color=location.selector()[[2]]$col) %>%
                     addLegend(labels = location.selector()[[1]]$labels,
                               colors = location.selector()[[1]]$colors) %>%
                     mapOptions(zoomToLimits = "first")
  })
  
})
