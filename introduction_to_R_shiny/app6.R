
#for UI
library(DT) # package for table management
library(shiny) # package for shiny application creation
#for server
library(readr) # package to read files
library(dplyr) # package for dataframes management
library(ggplot2) # package for plot creation


# Define UI 
ui <- fluidPage(
  # Application title
  titlePanel("My first shiny application"),
  # Layout
  sidebarLayout(
    #left side
    sidebarPanel(
      h1("Inputs"),
      # request data file path
      fileInput('data_file', 'Choose file to upload'),
      # Numeric input
      #numericInput("num", label = h3("Numeric input"), value = 1),
      numericInput("pval", label = h3("Define the p-value"), value = 0.05),
      # Slider input
      #sliderInput("slider1", label = h3("Slider"), min = 0, max = 100, value = 50)
      sliderInput("logFC", label = h3("Define the LogFC value"), min = 0, max = 5, value = 2)
    ),
    
    #right side
    mainPanel(
      h1("Outputs"),
      #display table
      DTOutput('data_table')
    )
    
  )
)

# Define server 
server <- function(input, output) {
  #import file
  data<- reactive({
    inFile <- input$data_file
    df <- read.csv(inFile$datapath, header = TRUE)
    return(df)
  })
  # show data
  output$data_table <- renderDT({
    data()
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
