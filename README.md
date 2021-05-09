ThinkData_AgriMart repository will contain three R scripts.

1)global.R
This script installs the required packages and defines all the required functions. It pulls the data from server and saves it as Rdata file in the working directory.

Below two scripts jointly form Shiny Dashboard
1)ui.R
It contains all the code related to User Interface of the Dashboard

2)server.R
It does the processing of data depending upon the user inputs and send the output to UI.


Execute below mentioned steps to run the Shiny Dashboard

1)	Install latest version of R and R Studio Desktop on your machine.
2)	Create a working directory (folder) on your machine.
    E.g. - E:\ThinkData\Shiny\ThinkData_AgriMart
    Folder “ThinkData_AgriMart” is your working directory.
3)	Download the GitHub repository "https://github.com/Snehal-Kakade/ThinkData_AgriMart" to your desktop.
4)	Unzip the downloaded file. Extracted folder will contain all the R scripts required for the execution. (Note: I have also kept the agrimarketData.rda dataset if you want to       run the shiny app without pulling the data from server. Rdata file is the compressed verion of data from the server)
5)	Copy all the files to your working directory i.e. "E:\ThinkData\Shiny\ThinkData_AgriMart".
6)	Open the global.R file and set the WD variable with your working directory.
	  E.g. WD <- "E:/ThinkData/Shiny/ThinkData_AgriMart" (Note here the '\' will change to '/')
7)  Execute the global.R script. It will pull the data from server and save it Rdata in the working directory which will be used by Dashbaord.
8)  Run the Shiny App 
9)  Now you can run and explore the Shiny Dashboard.

