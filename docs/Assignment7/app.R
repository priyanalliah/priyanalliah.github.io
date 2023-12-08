# Load required libraries
library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Wine Quality Scatter Plot"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("xvar", "X-Axis Variable:", choices = NULL),
      selectInput("yvar", "Y-Axis Variable:", choices = NULL)
    ),
    mainPanel(
      plotOutput("scatterplot")
    )
  )
)

server <- function(input, output, session) {
  data <- reactive({
    df <- read.csv("winequality-red.csv", header = TRUE, sep = ";")
    updateSelectInput(session, "xvar", choices = names(df))
    updateSelectInput(session, "yvar", choices = names(df))
    return(df)
  })
  
  output$scatterplot <- renderPlot({
    df <- data()
    x <- input$xvar
    y <- input$yvar
    
    ggplot(df, aes_string(x = x, y = y)) +
      geom_point() +
      labs(x = x, y = y) +
      ggtitle("Scatter Plot Example")
  })
}

shinyApp(ui = ui, server = server)