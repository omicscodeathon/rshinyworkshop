library(shiny)

# Define UI 
ui <- fluidPage(
  # Application title
  titlePanel("My first shiny application"),
  
)

# Define server 
server <- function(input, output) {
  
}

# Run the application 
shinyApp(ui = ui, server = server)
