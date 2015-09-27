
require(RCurl)
require(xlsx)
require(googleVis)
library(shiny)
#require(gdata)
url <- "http://www.happyplanetindex.org/assets/hpi-data.xlsx"
if(!file.exists('hpi-data.xlsx')) {download.file(url, "hpi-data.xlsx", mode="wb") }
HPI <- read.xlsx("hpi-data.xlsx", sheetName ="Complete HPI Dataset", startRow = 6)


shinyServer(function(input, output) {
  output$gvis <- renderGvis({
    gvisGeoChart(HPI, locationvar="Country", 
                     colorvar=input$variable,
                     options=list(region=input$region))

  })
  HPIcalc <- reactive({round(0.6*(((input$ladderLife * 2.93) * input$lifeExpec) -73.35)/(input$ecoFoot + 4.38),2)
  })
  output$indexCalc <- renderText({
    paste("The calculated Happy Planet Index is:", HPIcalc())
  })
})

