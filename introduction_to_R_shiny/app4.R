library(shiny)
library(readr)
library(dplyr)
library(ggplot2)



# Define UI 
ui <- fluidPage(
  # Application title
  titlePanel("My first shiny application"),
  # Layout
  sidebarLayout(
    #left side
    sidebarPanel(
      h1("Inputs"),
      fileInput('data_file', 'Choose file to upload'),
    ),
    
    #right side
    mainPanel(
      h1("Outputs")
    )
    
  )
)

# Define server 
server <- function(input, output) {
  
}

# Run the application 
shinyApp(ui = ui, server = server)
