library(data.table)

### SETWD
setwd("C:/Users/zhikoh/Documents/GitHub/Exploratory-Data-Analysis-Coursera-Week-1")

### Import file
rawdata <- read.table("./data/household_power_consumption.txt"
                      , header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

### Subset data from the dates 2007-02-01 and 2007-02-02
data <- rawdata[rawdata$Date %in% c("1/2/2007","2/2/2007") ,]

### Cleaning data
datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
data$Global_active_power <- as.numeric(data$Global_active_power)

### Making Plots
png("./figure/plot2.png", width=480, height=480)
plot(datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()