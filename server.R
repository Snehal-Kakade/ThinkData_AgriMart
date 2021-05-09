
library(shiny)
library(plotly)


shinyServer(function(input, output,session) {
    
    #options(shiny.sanitize.errors = FALSE)

    # Load Dataset
    # loadRData <- function(fileName){
    #     #loads an RData file, and returns it
    #     load(fileName)
    #     get(ls()[ls() != "fileName"])
    # }
    
    agrimarketData  <- loadRData("agrimarketData.rda")
    
    updateSelectizeInput(session, 'state', choices = agrimarketData$`State Name`,selected="Select",server= TRUE)
    
    # Filter available commodities
    dfcommodity <- reactive({
        available_commodity <- agrimarketData[agrimarketData$`State Name` == input$state, "Commodity"]
    })
    
    # Filter available dates and populate the Date Range Picker
    dfdate <- reactive({
        available_date <- agrimarketData[agrimarketData$`State Name` == input$state, "Reported Date"]
    })
    
    output$dateRange <- renderUI({
        
        ddf <- dfdate()
        dateRangeInput("expdate", "Select the date range:",
                       start = as.character(min(ddf)), # Start 
                       end = as.character(max(ddf)),
                       min = as.character(min(ddf)),
                       max = as.character(max(ddf)),
                       separator = " - ",
                       language = 'cz',
                       format = "yyyy-mm-dd")
        
    })
    
    
    output$commodity_selector <- renderUI({
        cdf <- dfcommodity()
        selectizeInput('commodity', 'Select Commodity:', 
                       choices = cdf,
                       options = list(create = NULL, 
                                      multiple = FALSE,
                                      placeholder = 'Select'))
        
    })
    
    # Filter available markets and populate the Market filter
    dfmarket <- reactive({
        
        available_market <- agrimarketData[agrimarketData$`State Name` == input$state &  agrimarketData$`Commodity` == input$commodity, "Market Name"]
    })
    
    output$market_selector <- renderUI({
        
        mdf <- dfmarket()
        selectizeInput('market', 'Select Market:', 
                       choices = mdf,
                       options = list(create = NULL, 
                                      multiple = FALSE,
                                      placeholder = 'Select'))
        
                                     })
    
    # Filter data for trends and summary
    
    dftrend_chart <- reactive({
        
        
        trend_data <- agrimarketData %>%
            filter(agrimarketData$`State Name` == input$state &  
                       agrimarketData$`Commodity` == input$commodity & 
                       agrimarketData$`Market Name` == input$market &
                       (agrimarketData$`Reported Date` >= as.POSIXct(input$expdate[1]) &
                       agrimarketData$`Reported Date` <= as.POSIXct(input$expdate[2]))	  
            )
        
    })
    
    #Plot the trend charts as per conditions
    
    output$trend_chart <- renderPlotly({
        
        validate(
            need(input$state, "Please select a state")
            
                )
        
        trenddf <- dftrend_chart()
        trenddf <- trenddf[order(trenddf$`Reported Date`),]
        if (input$typeselector == 'Price'){
            
        plot_ly(trenddf, x = ~as.character(trenddf$`Reported Date`), y = ~trenddf$`Modal Price Rs_per_Quintal`, 
                type = 'scatter', mode = 'lines+markers',
                text = ~paste("Date: ", as.character(trenddf$`Reported Date`),'<br>Price:', "Rs",trenddf$`Modal Price Rs_per_Quintal`)) %>%
            layout(             xaxis = list(
                                tickangle =45,
                                title = "Date"),
                   yaxis = list(title = "Price")
            ) 
        }
        else if (input$typeselector == 'Arrival'){
            plot_ly(trenddf, x = ~as.character(trenddf$`Reported Date`), y = ~trenddf$`Arrivals Tonnes`, 
                    type = 'scatter', mode = 'lines+markers',
                    text = ~paste("Date: ", as.character(trenddf$`Reported Date`),'<br>Arrival:', trenddf$`Arrivals Tonnes`,"tonnes")) %>%
                layout(             xaxis = list(
                    tickangle =45,
                    title = "Date"),
                    yaxis = list(title = "Arrival")
                )
        }
        else{
            
            ay <- list(
                tickfont = list(color = "red"),
                overlaying = "y",
                side = "right",
                title = "Arrival"
            )
            fig <- plot_ly(trenddf, x = ~as.character(trenddf$`Reported Date`), y = ~trenddf$`Modal Price Rs_per_Quintal`, mode = 'lines+markers',name = "Price",text = ~paste("Date: ", as.character(trenddf$`Reported Date`),'<br>Price:',"Rs", trenddf$`Modal Price Rs_per_Quintal`), type = 'scatter', mode = 'lines+markers') 
            fig <- fig %>% add_trace(y = ~trenddf$`Arrivals Tonnes`, name = 'Arrival', mode = 'lines+markers',yaxis = "y2",text = ~paste("Date: ", as.character(trenddf$`Reported Date`),'<br>Arrival:', trenddf$`Arrivals Tonnes`,"tonnes")) 
            fig <- fig %>% layout(
                #title = "Double Y Axis", 
                yaxis2 = ay,
                xaxis = list(title="Date",tickangle =45),
                yaxis = list(title="Price")
            )
            
            fig
        }
    })          

    # Print the summary as per conditions
    
    output$summary <- renderUI({
        
        validate(
            need(input$state, "Please select a state")
            
        )
        trenddf <- dftrend_chart()
        
        str1 <- paste("State:",trenddf$`State Name`[1]) 
        str2 <- paste("Commodity:",trenddf$`Commodity`[1])
        str3 <- paste("Market:",trenddf$`Market Name`[1])
        str4 <- paste("Type:",input$typeselector)
        HTML(paste(str1, str2, str3, str4,sep = '<br/>'))
    })

})
