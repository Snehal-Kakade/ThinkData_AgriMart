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

To Install R

i)	Open an internet browser and go to www.r-project.org.
ii)	Click the "download R" link in the middle of the page under "Getting Started."
iii)	Select a CRAN location (a mirror site) and click the corresponding link.
iv)	Click on the "Download R for ----" link as per your operating system.
v)	Click on the file containing the latest version of R under "Files."
vi)	Save the .pkg file, double-click it to open, and follow the installation instructions.
vii)	Now that R is installed, you need to download and install RStudio.

To Install RStudio

i)	Go to www.rstudio.com and click on the "Download RStudio" button.
ii)	Click on "Download RStudio Desktop."
iii)	Click on the version recommended for your system, or the latest Windows version, and save the executable file.  Run the .exe file and follow the installation instructions.     

2)	Create a working directory (folder) on your machine.
E.g. - E:\ThinkData\Shiny\ThinkData_AgriMart
Folder “ThinkData_AgriMart” is the working directory.
3)	Download the GitHub repository to your desktop.
4)	Unzip the downloaded file. Extracted folder will contain one folder named “FutureStayDashboard” and one R script named “FutureStay.R”.
5)	Place the folder “FutureStayDashboard” and R script “FutureStay.R” in the working directory created in step 2.
6)	Place “futurestay_csv” database folder in the working directory created in step 2.
7)	Open all the three R scripts in R studio.
8)	Change the working directory path in FutureStay.R to your working directory.
E.g. setwd("C:/Users /Desktop/DataScience/Upwork/Project_Futurestay")
Note: R uses forward slash ‘/’ in directory structure.
9)	Execute the FutureStay.R script to preprocess the data. 
Script can be executed in two ways:
a)	Select entire code using “Ctrl+A” and hit Run button
b)	Set the working directory using command on console
setwd("C:/Users /Desktop/DataScience/Upwork/Project_Futurestay") and then run below command on console
source("FutureStay.R", echo = TRUE)
10)	Step 9 will create all the necessary datasets for Dashboard execution. Now you can run the Shiny Dashboard.
It can executed in two ways:
a)	Open the server.R and ui.R and hit “Run App” button
b)	   Execute below command on console:
runApp("FutureStayDashboard")
11)	After executing above step you can explore the Shiny Dashboard.

