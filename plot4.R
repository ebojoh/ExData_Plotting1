## Load the library for handling table dataframe
library("dplyr")

## Get file path information and load file data
fileDirectory <- getwd()
fileName <- "household_power_consumption.txt"
completeFileName <- paste0(fileDirectory,"/",fileName)

## Get dataset of interest from the loaded file
measurementData <- read.table(completeFileName, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
measurementData <- tbl_df(measurementData)
dataSubset <- filter(measurementData,Date %in% c("1/2/2007","2/2/2007"))

## Get datetime information by concatenating the Date and Time columns
datetime <- strptime(paste0(dataSubset$Date,dataSubset$Time),"%d/%m/%Y %H:%M:%S")

## Get the Global Active Power variable data and convert the data to numeric
globalActivePower <- select(dataSubset,Global_active_power)
globalActivePower <- as.numeric(unlist(globalActivePower))

## Get the Global Reactive Power variable data and convert the data to numeric
globalReactivePower <- select(dataSubset,Global_reactive_power)
globalReactivePower <- as.numeric(unlist(globalReactivePower))

## Get the Voltage variable data and convert the data to numeric
voltage <- select(dataSubset,Voltage)
voltage <- as.numeric(unlist(voltage))

## Get the Sub Metering variables (1, 2 and 3) data and convert the data to numeric
subMetering1 <- select(dataSubset,Sub_metering_1)
subMetering1 <- as.numeric(unlist(subMetering1))
subMetering2 <- select(dataSubset,Sub_metering_2)
subMetering2 <- as.numeric(unlist(subMetering2))
subMetering3 <- select(dataSubset,Sub_metering_3)
subMetering3 <- as.numeric(unlist(subMetering3))

## Plot the graphs for the data collected
png("plot4.png", width=480, height=480) ## This line opens/activates the png device
par(mfrow = c(2, 2)) 
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()    ## This line closes the png device