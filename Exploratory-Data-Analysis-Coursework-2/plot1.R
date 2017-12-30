## SET WD

## This first line will likely take a few seconds. Be patient!
## READ rds Data
NEI <- readRDS("summarySCC_PM25.rds")
## SCC <- readRDS("Source_Classification_Code.rds")

## Sum all sources of emissions by year
result <- aggregate(Emissions~year, NEI, sum)

## Making bar plot
png('plot1.png')
barplot(height=result$Emissions/10^3, names.arg=result$year, xlab="Years", 
        ylab=expression('PM'[2.5]*' Emission Value (\'000)'),
        main=expression('PM'[2.5]*' Emission Over The Years'))
dev.off()
