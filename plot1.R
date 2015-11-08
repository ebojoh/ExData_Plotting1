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

## Get the Global Active Power variable data and convert the data to numeric
globalActivePower <- select(dataSubset,Global_active_power)
globalActivePower <- as.numeric(unlist(globalActivePower))

## Plot the graphs for the data collected
png("plot1.png", width=480, height=480)  ## This line opens/activates the png device
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()    ## This line closes the png device