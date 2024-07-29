#'
#' This function is a shiny app to visualize gene expression data.
#' @param expression_datapath Path to the gene expression file
#' @export
#'
shinyfunction <- function( expression_datapath) {
  library(readr)
  library(dplyr)
  library(ggplot2)
  library(readxl)
  library(shiny)
  library(shinyFiles)

  data <- read.csv(expression_datapath)

  expression <- data %>%
    distinct(gene, .keep_all = TRUE) %>%
    na.omit() %>%
    as_tibble() %>%
    as.data.frame() %>%
    select(-1)

  ui <- fluidPage(

    # Application title
    titlePanel("Codeathon Shiny"),

    sidebarLayout(
      sidebarPanel( width=6,
                    numericInput("pval", label = h3("Define p-value"), value = 0.05),
                    numericInput("logval", label = h3("Define LogFC value"), value = 2),
                    textInput("title", label = h3("add volcano plot's title"), value = " "),
                    actionButton("submit", label = "Submit"),

      ),

      mainPanel(width=6,
                fluidRow(h2("Differentially expressed genes")),
                fluidRow(
                  plotOutput("volcanoplot", height =400)
                ),
                fluidRow(
                  textOutput("volcanoplot_title")
                )
      )
    )
  )

  server <- function(input, output) {
    observeEvent(input$submit, {

      output$volcanoplot <- renderPlot({
        expression$diffexpressed <- "Not Significant"
        expression$diffexpressed[expression$log2FoldChange  > input$logval  & expression$pvalue < input$pval ] <- "Upregulated genes"
        expression$diffexpressed[expression$log2FoldChange  < -(input$logval)  & expression$pvalue < input$pval ] <- "Downregulated genes"

        ggplot(data=expression, aes(x=log2FoldChange, y=-log10(pvalue), col=diffexpressed)) +
          geom_point() + theme_minimal() + theme(text = element_text(size = 15))


      })

      output$volcanoplot_title <- renderText({

        req(input$title)

      })
    })
  }

  # Run the application
  shinyApp(ui = ui, server = server)

}
