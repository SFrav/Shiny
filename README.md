         This Shiny application will help you explore the Happy Planet Index, an alternative means of measuring national well-being.
         To get started, you will require an internet connection even if running locally. To run locally, place the ui.R and server.R files in a folder, 
         and in R studio, with the shiny library loaded and packages listed in server.R installed, execute the command runApp()."),
         
         Once running, navigate to the two core components of the application using the tabs at the top of the page. 'Explore index' 
         allows you to map various components of the HPI. Select a region of interest to zoom in, and select an indicator of interest
         to map the indicator, with values represented in a colour range. Press 'submit' when you have selected your options. You can mouse over the map for further detail.
         
         The 'index calculation' tab allows you to experiment with the three indicators used in the index. Use the respective sliders to adjust values and press submit to calculate the HPI.
         
         For further information on the HPI, refer to their report at: "http://www.happyplanetindex.org/"
         
         Known bug: there seems to be a bug in the region selection of 'gvisGeoChart'. For this reason, the USA was selected as an option rather than North America. This bug changed to different regions during testing. If the map does not show, select another region.
