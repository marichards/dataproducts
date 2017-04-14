library(shiny)
library(leaflet)

shinyServer(function(input, output) {

  # Load the data frame of all locations
  seattle_loc <- readRDS("./seattle_loc.RDS")
    
  # Create the color and labels data frame
  legend.info <- data.frame(labels =  c("Seafood",
                                        "Sandwiches",
                                        "Brunch",
                                        "Upscale",
                                        "Thai",
                                        "Bakeries",
                                        "Happy Hour",
                                        "Desserts"),
                            colors = c("blue",
                                       "red",
                                       "green",
                                       "purple",
                                       "orange",
                                       "black",
                                       "yellow",
                                       "brown"))  

  # Make a reactive expression that filters locations
  location.selector <- reactive({
    button.logic <- c(input$seafood,
                      input$sandwiches,
                      input$brunch,
                      input$upscale,
                      input$thai,
                      input$bakery,
                      input$happyhour,
                      input$desserts)
    final.legend <- legend.info[button.logic,]
    final.locations <- subset(seattle_loc, col %in% final.legend$colors)
    return(list(final.legend,final.locations))
  })
  
  # Make an observeEvent that calculates distance
  location.adder <- eventReactive(input$action2,{
    
    #Parse the google maps link
    gmap <- input$new.gmap
    
    gmap <- sub(".*@([-]?\\d+\\.\\d+,[-]?\\d+\\.\\d+).*","\\1", gmap)
    new.coords <- strsplit(gmap,",")[[1]]
   
    # Take in the new values longitude and latitude
    options(digits=10)
    new.lg <- as.numeric(new.coords[2])
    new.lt <- as.numeric(new.coords[1])
    
    #Grab the new type and make it a color
    new.type <- input$new.type
    new.col <- legend.info$colors[which(legend.info$labels==new.type)]
    
    new.link <- input$new.link
    new.name <- input$new.name
    
    #Fix the link
    new.link <- sprintf("<a href='%s'>%s</a>", new.link, new.name)
    
    # Add the new row to the DF, save it, and print out text
    new.row <- list(new.lt, new.lg, new.col, new.link, new.name)
    seattle_loc <- rbind(seattle_loc, new.row)
    saveRDS(seattle_loc, file="./seattle_loc.RDS")
    return(sprintf("Location %s saved", new.name))
  })
  
  # Output the distance specified
  output$text1 <- renderText(location.adder())

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
