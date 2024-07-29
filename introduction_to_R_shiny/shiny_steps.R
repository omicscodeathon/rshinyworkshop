#1 : create app
library(shiny)

# Define UI 
ui <- fluidPage(

)

# Define server 
server <- function(input, output) {
}

# Run the application 
shinyApp(ui = ui, server = server)

#2 : add title
titlePanel("title")

#3: define infput/output sides
sidebarPanel(
  h1("Inputs"),
),
mainPanel(
  h1("Outputs")
)

#4: add import file
library(readr)
fileInput('ID', 'text')

#5: read data
library(DT) # package for table management
library(dplyr) # package for dataframes management

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
DTOutput('data_table'),
#6: display table
DTOutput('data_table')

#7 :  Inputs
#Numeric input
numericInput("ID", label = h3("text"), value = default_value),
# Slider input
sliderInput("ID", label = h3("text"), min = , max = , value = default_value)

#8:gene expression analysis 
output$expression <- renderDT({
  expression <- data()
  expression$diffexpressed <- "Not Significant"
  expression$diffexpressed[expression$log2FoldChange  > input$logFC  & expression$pvalue < input$pval ] <- "Upregulated genes"
  expression$diffexpressed[expression$log2FoldChange  < -input$logFC & expression$pvalue < input$pval] <- "Downregulated genes"
  expression
})
DTOutput('expression')
#9: Submit button
actionButton("submit", label = "Submit"),
observeEvent( input$submit, {})

#10: create a plot
library(ggplot2) # package for plot creation
# volcano plot
output$volcano_plot <- renderPlot({
  expression <- data()
  expression$diffexpressed <- "Not Significant"
  expression$diffexpressed[expression$log2FoldChange  > input$logFC  & expression$pvalue < input$pval ] <- "Upregulated genes"
  expression$diffexpressed[expression$log2FoldChange  < -input$logFC & expression$pvalue < input$pval] <- "Downregulated genes"
  expression
  # Visualize the results as a volcano plot
  ggplot(data=expression, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed)) +
    geom_point() + theme_minimal()
})
# display plot
plotOutput("volcano_plot")

#11: store data
# Create reactive value to store processed data
expression_data <- reactiveVal()
# Store processed data
expression_data( expression)
#call stored data
req(expression_data())

#12: add tabs
library(shinydashboard) # custom UI
tabBox(
  tabPanel("table",DTOutput('expression'),),
  tabPanel("plot",plotOutput("volcano_plot")),
),

#13: design
h1(text)
h2(text)
h3(text)
h4(text)
h5(text)

width = 4, height =6, 
style = "color: black; background-color: #007bff; border-color: #007bff;"

theme = bs_theme(bootswatch = "minty"),
theme = bs_theme(bootswatch = "cyborg"),
theme = bs_theme( bootswatch = "journal"),