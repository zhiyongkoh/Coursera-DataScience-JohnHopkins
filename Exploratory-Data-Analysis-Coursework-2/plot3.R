library(data.table)
library(ggplot2)
## SET WD

## This first line will likely take a few seconds. Be patient!
## READ rds Data
NEI <- readRDS('summarySCC_PM25.rds')
## SCC <- readRDS('Source_Classification_Code.rds')

NEI <- as.data.table(NEI)
NEI_baltimore_city <- NEI[which(fips =='24510'),]


## Sum all sources of emissions by year
result <- aggregate(Emissions~year+type, NEI_baltimore_city, sum)

## Making bar result
png('plot3.png')
g <- ggplot(result,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat='identity') +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = 'free',space='free') + 
  labs(x='Year', y=expression('PM'[2.5]*' Emission Value')) + 
  labs(title=expression('PM'[2.5]*' Emissions - Baltimore City Over The Years By Sources'))
  ggtitle(expression('Baltimore City - PM'[2.5]*' Emission Over The Years By Sources'))
  
print(g)
dev.off()
