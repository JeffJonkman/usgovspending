
library(shiny)

# Define UI for application that draws graph
shinyUI(fluidPage(
  
  # title
  titlePanel("United States Government Spending"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "plottype", label = "Plot Type",choices = plottype),
      
      checkboxGroupInput("spendingcat", 
                         label = "Spending Category", 
                         choices = SpendingCategory,
                         selected = "defense"),
       sliderInput(inputId = "range", label = "Year", 1970, 2015, 
                   value = c(2000, 2013), sep="")
       ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
