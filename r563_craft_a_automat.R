# r563_craft_a_automat.R

# Load required libraries
library(ggplot2)
library(shiny)
library(dygraphs)

# Define a function to generate a dynamic plot
create_plot <- function(data, x, y, plot_type) {
  if (plot_type == "line") {
    ggplot(data, aes_string(x, y)) + 
      geom_line() + 
      theme_minimal()
  } else if (plot_type == "bar") {
    ggplot(data, aes_string(x, y)) + 
      geom_bar(stat = "identity") + 
      theme_minimal()
  } else if (plot_type == "interactive") {
    dygraph(data, main = "Interactive Time Series")
  }
}

# Create a Shiny UI
ui <- fluidPage(
  # Input widgets
  sidebarLayout(
    sidebarPanel(
      selectInput("x", "X-axis", choices = names(mtcars)),
      selectInput("y", "Y-axis", choices = names(mtcars)),
      radioButtons("plot_type", "Plot Type", choices = c("line", "bar", "interactive"))
    ),
    mainPanel(
      # Output plot
      plotOutput("plot")
    )
  )
)

# Create a Shiny server
server <- function(input, output) {
  # Generate the plot
  output$plot <- renderPlot({
    create_plot(mtcars, input$x, input$y, input$plot_type)
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)