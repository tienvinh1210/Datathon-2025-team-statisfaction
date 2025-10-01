library(shiny)
library(tidyverse)
library(plotly)

data = read_csv("dynamic_supply_chain_logistics_dataset.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),
    
    selectInput("variable",
                "Variable",
                choices = colnames(data)),
    sliderInput("bins",
                "Number of bins:",
                min = 1,
                max = 50,
                value = 30),
    plotlyOutput("hist"),
    plotlyOutput("boxplot",
                 height = "700px")

    # Sidebar with a slider input for number of bins 
    # sidebarLayout(
    #     sidebarPanel(
    #         
    #     ),
    # 
    #     # Show a plot of the generated distribution
    #     mainPanel(
    #        
    #     )
    # )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$hist <- renderPlotly({
      p <- ggplot(data, aes(x = .data[[input$variable]])) +
        geom_histogram(bins = input$bins)
      ggplotly(p)
    })
    
    output$boxplot <- renderPlotly({
      p <- ggplot(data, aes(y = .data[[input$variable]])) +
        geom_boxplot() +
        scale_x_discrete()
      ggplotly(p)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
