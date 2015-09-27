
require(shiny)
require(RCurl)
require(xlsx)

#require(gdata)
url <- "http://www.happyplanetindex.org/assets/hpi-data.xlsx"
if(!file.exists('hpi-data.xlsx')) {download.file(url, "hpi-data.xlsx", mode="wb") }
HPI <- read.xlsx("hpi-data.xlsx", sheetName ="Complete HPI Dataset", startRow = 6)

shinyUI(navbarPage(
  title="Happy Planet Index: mapped in Google Geovis",
  tabPanel("Explore index", sidebarPanel(
    selectInput("region", "Choose a Region:", 
                choices = c("Africa" = "002", "America" = "US", "Central Asia" = "143", "Europe" ="150", "Oceania" ="009")),
    selectInput("variable", "Choose an indicator:", 
                choices = c("Happy planet index rank"="HPI.Rank", "Life expectancy" = "Life..Expectancy", 
                            "Well being" = "Well.being..0.10.", "Happy life years"="Happy.Life.Years", 
                            "GHG footprint / capita" = "Footprint..gha.capita.", 
                            "Happy planet index" ="Happy.Planet.Index", "Population" = "Population", 
                            "GDP / capita PPP" = "GDP.capita...PPP.", "Governance ranking" = "Governance.Rank..1...highest.gov..")),
    
    submitButton("Submit")
    
    
    
  ),
  
  mainPanel(
    htmlOutput("gvis")
  )
),
tabPanel("Index calculation", 
         sidebarPanel( sliderInput("lifeExpec", "Life expectancy", min = 
                                     round(min(HPI$Life..Expectancy, na.rm=T),0), 
                                   max = round(max(HPI$Life..Expectancy, na.rm=T),0), 
                                   value = round(mean(HPI$Life..Expectancy, na.rm=T),0),
                                   step = 1),
                       sliderInput("ladderLife", "Ladder of life (wellbeing)", round(min(HPI$Well.being..0.10., na.rm=T),0), 
                                   max = round(max(HPI$Well.being..0.10., na.rm=T),0), 
                                   value = round(mean(HPI$Well.being..0.10., na.rm=T),0),
                                   step = 0.3),
                       sliderInput("ecoFoot", "Ecological footprint (CO2 / capita)", min = 
                                     round(min(HPI$Footprint..gha.capita., na.rm=T),0), 
                                   max = round(max(HPI$Footprint..gha.capita., na.rm=T),0), 
                                   value = round(mean(HPI$Footprint..gha.capita., na.rm=T),0),
                                   step = 0.3),
                       submitButton("Submit")
),
mainPanel(
  verbatimTextOutput("indexCalc")
)
),
tabPanel("Documentation", p("This Shiny application will help you explore the Happy Planet Index, an alternative means of measuring national well-being.
         To get started, you will require an internet connection even if running locally. To run locally, place the ui.R and server.R files in a folder, 
         and in R studio, with the shiny library loaded and packages listed in server.R installed, execute the command runApp()."),
         p("Once running, navigate to the two core components of the application using the tabs at the top of the page. 'Explore index' 
         allows you to map various components of the HPI. Select a region of interest to zoom in, and select an indicator of interest
         to map the indicator, with values represented in a colour range. Press 'submit' when you have selected your options. You can mouse over the map for further detail."),
         
         p("The 'index calculation' tab allows you to experiment with the three indicators used in the index. Use the respective sliders to adjust values and press submit to calculate the HPI."),
         
         p("For further information on the HPI, refer to their report at: "), a("http://www.happyplanetindex.org/"),
         
         p("Known bug: there seems to be a bug in the region selection of 'gvisGeoChart'. For this reason, the USA was selected as an option rather than North America. This bug changed to different regions during testing. If the map does not show, select another region.")
    )
)
)
