library(shiny)

# Define UI 
ui <- fluidPage(
  # Application title
  titlePanel("My first shiny application"),
  # Layout
  sidebarLayout(
    #left side
    sidebarPanel(
        h1("left side")
    ),
    
    #right side
    mainPanel(
      h1("right side")
    )
    
  )
)

# Define server 
server <- function(input, output) {
  
}

# Run the application 
shinyApp(ui = ui, server = server)
