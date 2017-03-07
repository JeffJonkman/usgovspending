
library(shiny)
library(plyr)
library(dplyr)
library(ggplot2)
library(grid)
library(scales)
customColors <- c("#a6cee3", "#1f78b4", "#b2df84", "#33a02c", "#fb9a99", 
                  "#e31a1c", "#fdbf6f", "#ff7f00","#cab2d6", "#6a3d9a", "#ffff99")
filterdata <- read.csv("datapolitics.csv")
filterdata <- mutate(filterdata, PercentInc = amount/total)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    #Filter Data based on the input
    filterdata <- filterdata[filterdata$year >= input$range[1] & 
    filterdata$year <= input$range[2], ]
    filterdata <- filter(filterdata, type %in% input$spendingcat)
 
  #Generate Plot using data
    if (input$plottype == "PercentInc"){
      qplot(year, PercentInc , data=filterdata, fill=type, 
            geom="area") + ylab("Percent") +
        scale_fill_manual(values=customColors) + 
        scale_y_continuous(labels=percent) + 
        theme(legend.title=element_blank(), legend.key.size = unit(1, "cm"), 
              legend.position="bottom", legend.text=element_text(size=10))    
      
    } else if (input$plottype == "amount"){
      qplot(year, amount , data=filterdata, fill=type, 
            geom="area") + ylab("Dollar") +
        scale_fill_manual(values=customColors) + 
        theme(legend.title=element_blank(), legend.key.size = unit(1, "cm"), 
              legend.position="bottom", legend.text=element_text(size=10)) 
    } else if (input$plottype == "Growth") {
      qplot(year, Growth, data=filterdata, fill=type, geom="area") + 
        scale_fill_manual(values=customColors) + ylab("Growing Rate(%") +
        facet_wrap(~type, ncol=3) +
        theme(legend.title=element_blank(), legend.key.size = unit(1, "cm"), 
              legend.position="bottom", strip.text=element_text(size=10), 
              legend.text=element_text(size=10), axis.text=element_text(size=7),
              axis.text.x = element_text(angle = 90))   
    }

  })
  
})
