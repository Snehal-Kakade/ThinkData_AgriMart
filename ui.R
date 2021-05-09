
library(shiny)
library(shinydashboard)
library(shinycssloaders)




shinyUI(fluidPage(

    # Application title
    titlePanel(h1("Agrmarket Dashboard",align = "center")),

    # Sidebar with a inputs
    sidebarLayout(
        sidebarPanel(
            
            selectizeInput('state', 'Select State:', 
                           choices = NULL,
                           options = list(create = NULL, 
                           multiple = FALSE,
                           placeholder = 'Select')),

            htmlOutput("commodity_selector"),

            radioButtons("typeselector",
                         label="Type:",
                         choices=list("Price","Arrival","Both"),
                         selected="Price"),

        ),

        mainPanel(

            tabItem(tabName = "filters",
                    fluidRow(
                        box(title = "Market",width = 3,height = "100px",
                            htmlOutput("market_selector")
                        ),
                        box(title = "Date Range",width = 9,height = "100px",
                            uiOutput("dateRange")
                        )
                    )
                    
            ),
            tabItem(tabName = "dashboard",
                        fluidRow(
                            box(title = "Summary",width = 3,
                                htmlOutput("summary")
                            ),
                            box(title = "Price Trend",width = 9,
                                plotlyOutput("trend_chart")
                            )
                        )
                        
              )

        )

)))
