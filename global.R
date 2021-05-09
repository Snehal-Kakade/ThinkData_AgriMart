library(RPostgreSQL)
library(shiny)
library(plotly)
library(shinydashboard)
library(shinycssloaders)
library(dplyr)

#Set working directory
WD <- "ThinkData_AgriMart"
setwd(WD)

# Function to pull data from server 

pullData <- function(){
  drv <- dbDriver("PostgreSQL")
  con <- dbConnect(drv, host='think-data.c3yicave5fam.ap-south-1.rds.amazonaws.com',
                   dbname='agmarket',
                   user='rtestuser', 
                   password='psql_password')
  rk <- dbSendQuery(con,"select * from agmarknet_commodity_subset")
  rs<-fetch(rk,n= -1)
  return(rs)
  dbDisconnect(con)
}

# Function to load the RDataset in Shiny App
loadRData <- function(fileName){
  #loads an RData file, and returns it
  load(fileName)
  get(ls()[ls() != "fileName"])
}

Sys.time()
adata <- pullData()
Sys.time()

# save data as Rdataset
save(adata,file = "agrimarketData.rda")

#Make sure all the connections to the server are closed
lapply(dbListConnections(drv = dbDriver("PostgreSQL")), function(x) {dbDisconnect(conn = x)})
