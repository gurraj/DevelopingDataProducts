# Coursera - Course 9 -Developing Data Products

# server.R file for the shiny app

library(shiny)
library(datasets)
library(dplyr)

shinyServer(function(input, output) {
  
  # Show the cars that correspond to the choices made by enduser
  output$table <- renderDataTable({
    disp_seq <- seq(from = input$disp[1], to = input$disp[2], by = 0.1)
    hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
    data <- transmute(mtcars, Car = rownames(mtcars), MilesPerGallon = mpg, 
                                            Cylinders = cyl, Displacement = disp, Horsepower = hp, 
                      Transmission = am)
    data <- filter(data,  Cylinders %in% input$cyl, 
                   Displacement %in% disp_seq, Horsepower %in% hp_seq, Transmission %in% input$am)
    data <- mutate(data, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
    data <- arrange(data, Car)
    data
  }, options = list(lengthMenu = c(5, 15, 30), pageLength = 30))
})