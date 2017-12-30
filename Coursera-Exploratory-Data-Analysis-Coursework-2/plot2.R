library(data.table)
## SET WD

## This first line will likely take a few seconds. Be patient!
## READ rds Data
NEI <- readRDS("summarySCC_PM25.rds")
## SCC <- readRDS("Source_Classification_Code.rds")

NEI <- as.data.table(NEI)
NEI_baltimore_city <- NEI[which(fips =="24510"),]


## Sum all sources of emissions by year
result <- aggregate(Emissions~year, NEI_baltimore_city, sum)

## Making bar plot
png('plot2.png')
barplot(height=result$Emissions, names.arg=result$year, xlab="Years", 
        ylab=expression('PM'[2.5]*' Emission Value'),
        main=expression('Baltimore City - PM'[2.5]*' Emission Over The Years'))

dev.off()