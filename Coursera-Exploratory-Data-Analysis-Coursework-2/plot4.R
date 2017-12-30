library(data.table)
library(ggplot2)
## SET WD

## This first line will likely take a few seconds. Be patient!
## READ rds Data
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

SCC <- as.data.table(SCC)

## Filtering data for Coal Combustion
SCC_subset <- SCC[tolower(SCC.Level.One) %like% "comb" & tolower(SCC.Level.Four) %like% "coal",]
result <- NEI[NEI$SCC %in% SCC_subset$SCC,]


## Making bar result
png('plot4.png')
g <- ggplot(result,aes(factor(year),Emissions/10^3)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="Year", y=expression('PM'[2.5]*' Emission Value (\'000)')) + 
  labs(title=expression('PM'[2.5]*'Coal Combustion Emission Over The Years')) 

print(g)
dev.off()
