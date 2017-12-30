library(data.table)
library(ggplot2)
## SET WD

## This first line will likely take a few seconds. Be patient!
## READ rds Data
NEI <- readRDS('summarySCC_PM25.rds')
##SCC <- readRDS('Source_Classification_Code.rds')

NEI <- as.data.table(NEI)

result <-NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
result = aggregate(Emissions~year, result, sum)

## Making bar result
png('plot5.png')
g <- ggplot(result,aes(factor(year),Emissions/10^3)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x='Year', y=expression('PM'[2.5]*' Emission Value')) + 
  labs(title=expression('Baltimore City - PM'[2.5]*' Motor Vehicle Emission Over The Years'))

print(g)
dev.off()