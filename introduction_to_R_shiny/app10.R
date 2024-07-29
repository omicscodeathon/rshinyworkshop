
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
      numericInput("pval", label = h3("Define the p-value"), value = 0.05),
      # Slider input
      sliderInput("logFC", label = h3("Define the LogFC value"), min = 0, max = 5, value = 2),
      # Submit button
      actionButton("submit", label = "Submit"),
    ),
    
    #right side
    mainPanel(
      h1("Outputs"),
      #display table
      DTOutput('expression'),
      # display plot
      plotOutput("volcano_plot")
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
  #wait for submit button
  observeEvent( input$submit, {
    
    # Create reactive value to store processed data
    expression_data <- reactiveVal()
    
    # gene expression analysis 
    output$expression <- renderDT({
      expression <- data()
      expression$diffexpressed <- "Not Significant"
      expression$diffexpressed[expression$log2FoldChange  > input$logFC  & expression$pvalue < input$pval ] <- "Upregulated genes"
      expression$diffexpressed[expression$log2FoldChange  < -input$logFC & expression$pvalue < input$pval] <- "Downregulated genes"
      # Store processed data
      expression_data( expression)
      # display
      expression
    })
    
    # volcano plot
    output$volcano_plot <- renderPlot({
      #call stored data
      req(expression_data())
      # Visualize the results as a volcano plot
      ggplot(data=expression_data(), aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed)) +
        geom_point() + theme_minimal()
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
