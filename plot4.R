## Exploratory Data Analysis
## Program  : Plot4.r
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

## Generate the plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(PowerConsumptionSubset, 
{
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
}
)
## Save the plot to png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()