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
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

### Making Plots
png("./figure/plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, data$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, data$Sub_metering_2, type="l", col="red")
lines(datetime, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()