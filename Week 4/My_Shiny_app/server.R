library(shiny)
library(leaflet)

shinyServer(function(input, output) {

  # Create the data frame of all locations
  seattle_loc <- data.frame(
    lat = c(47.60972,47.5994409,47.6816841,47.6611935,
            47.67538,47.6577795,47.6225807,47.6861061,
            47.6503061,47.651112,47.6719757,47.639056,
            47.598996,47.6107739,47.6495925,47.601597,
            47.652196,47.6195659,47.6329571,47.6178717),
    lng = c(-122.344387,-122.3312286,-122.3786947,-122.3422866,
            -122.327614,-122.3197193,-122.2994758,-122.3403572,
            -122.3523452,-122.3454357,-122.390061,-122.3588257,
            -122.3348717,-122.3503437,-122.3445494,-122.3344979,
            -122.3549098,-122.3150591,-122.3196533,-122.3285566),
    col = c("blue", "red", "red","purple",
            "green","green","purple","blue",
            "orange","black","black","orange",
            "red","blue","purple","red",
            "green","black","orange","black"),
    stringsAsFactors = FALSE,
    sites <- c(
    "<a href='http://pikeplacemarket.org/'>Pike Place Market</a>",
    "<a href='http://www.salumicuredmeats.com/'>Salumi</a>",
    "<a href='http://unbienseattle.com/'>Un Bien</a>",
    "<a href='http://tilthrestaurant.com/home/'>Tilth</a>",
    "<a href='http://www.butcherbakerseattle.com/'>The Butcher & The Baker</a>",
    "<a href='http://www.portagebaycafe.com/'>Portage Bay Cafe</a>",
    "<a href='http://www.harvestvine.com/'>The Harvest Vine</a>",
    "<a href='http://www.dukeschowderhouse.com/locations/green-lake/'>Duke's Chowder House</a>",
    "<a href='https://www.zomato.com/seattle/jai-thai-fremont'>Jai Thai</a>",
    "<a href='http://www.seawolfbakers.com/'>Sea Wolf Bakers</a>",
    "<a href='http://cafebesalu.com/'>Cafe Besalu</a>",
    "<a href='https://www.zomato.com/seattle/ying-thai-kitchen-queen-anne-upper'>Thai Kitchen</a>",
    "<a href='http://rainshadowmeats.com/'>Rain Shadow Meats</a>",
    "<a href='https://www.anthonys.com/restaurants/detail/anthonys-pier-66'>Anthony's Pier 66</a>",
    "<a href='http://www.thewhalewins.com/'>The Whale Wins</a>",
    "<a href='http://www.tatsdeli.com/'>Tat's Deli</a>",
    "<a href='https://www.pastramisandwich.com/'>Roxy's Diner</a>",
    "<a href='http://www.bakerynouveau.com/'>Bakery Nouveau</a>",
    "<a href='http://wedgwoodtwovegetarianthai.com/'>Wedgewood II Vegetarian Thai</a>",
    "<a href='https://www.crumbleandflake.com/'>Crumble and Flake</a>"
    ),
    names <- c("Pike Place Market", "Salumi", "Un Bien", "Tilth", "The Butcher & The Baker",
             "Portage Bay Cafe", "The Harvest Vine", "Duke's Chowder House", "Jai Thai",
             "Sea Wolf Bakers", "Cafe Besalu", "Thai Kitchen", "Rain Shadow Meats", 
             "Anthony's Pier 66", "The Whale Wins", "Tat's Deli", "Roxy's Diner", 
             "Bakery Novuveau", "Wedgewood II Vegetarian Thai", "Crumble and Flake")
  )
  # Create the color and labels data frame
  legend.info <- data.frame(labels =  c("Seafood",
                                        "Sandwiches",
                                        "Brunch",
                                        "Upscale",
                                        "Thai",
                                        "Bakeries"),
                            colors = c("blue",
                                       "red",
                                       "green",
                                       "purple",
                                       "orange",
                                       "black"))  

  # Make a reactive expression that filters locations
  location.selector <- reactive({
    button.logic <- c(input$seafood,
                      input$sandwiches,
                      input$brunch,
                      input$upscale,
                      input$thai,
                      input$bakery)
    final.legend <- legend.info[button.logic,]
    final.locations <- subset(seattle_loc, col %in% final.legend$colors)
    return(list(final.legend,final.locations))
  })
  
  # Make an observeEvent that calculates distance
  distance.calculator <- eventReactive(input$action2,{
    # Take in the longitude and latitude
    new.lg <- input$new.lg
    new.lt <- input$new.lt
    
    # Grab the coordinates of the specified restaurant
    idx <- which(seattle_loc$names == input$place.id)
    rest.lg <- seattle_loc$lng[idx]
    rest.lt <- seattle_loc$lat[idx]
    
    # Calculate distance in longitude/latitude and convert to miles
    # Length of 1 degree latitude: cos(47.6 degrees)*69.172 = 46.622
    # Length of 1 degree longitude: 69.172 miles (negligible difference)
    lg.diff <- abs(new.lg - rest.lg) * 69.172
    lt.diff <- abs(new.lt - rest.lt) * 46.622
    distance <- signif((sqrt(lg.diff^2 + lt.diff^2)),3)
    return(paste(distance,"miles"))
  })
  
  # Output the distance specified
  output$text1 <- renderText(distance.calculator())

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
