## Exploratory Data Analysis
## Program  : Plot2.r
## Objetive : Plot household energy use over 2 day period.
## Data : UCI Data - Machine Learning Repository
## URL  : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## Create Data Folder if doen't exist.
if(!file.exists("data")) { dir.create("data")}
## Download a file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" ## "https://github.com/rdpeng/ExData_Plotting1"
download.file(fileURL, destfile = "./data/exdata-data-household.zip", mode='wb')
unzip("./data/exdata-data-household.zip", exdir = "./data")

## Load the Data
PowerConsumption <- read.csv("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?",
                             check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
PowerConsumption$Date <- as.Date(PowerConsumption$Date, format="%d/%m/%Y")

## Subset the data for 01/02/2007 to 02/02/2007
PowerConsumptionSubset <- subset(PowerConsumption, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
## Delete the Original data to free memory
rm(PowerConsumption)

## Converting to DateTime
PowerConsumptionSubset$Datetime <- as.POSIXct(paste(as.Date(PowerConsumptionSubset$Date), PowerConsumptionSubset$Time))

## Generate the plot2
plot(PowerConsumptionSubset$Global_active_power~PowerConsumptionSubset$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
## Save the plot to png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()