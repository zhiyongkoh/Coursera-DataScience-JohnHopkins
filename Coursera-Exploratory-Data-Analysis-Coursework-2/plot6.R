library(data.table)
library(ggplot2)
## SET WD

## This first line will likely take a few seconds. Be patient!
## READ rds Data
NEI <- readRDS('summarySCC_PM25.rds')
##SCC <- readRDS('Source_Classification_Code.rds')

NEI <- as.data.table(NEI)

NEI_baltimore_city <-NEI[(NEI$fips=='24510') & (NEI$type=='ON-ROAD'),]
NEI_losagelos_country <-NEI[(NEI$fips=='06037') & (NEI$type=='ON-ROAD'),]

NEI_baltimore_city <- as.data.table(aggregate(Emissions~year, NEI_baltimore_city, sum))
NEI_losagelos_country <- as.data.table(aggregate(Emissions~year, NEI_losagelos_country, sum))

NEI_baltimore_city[,location:='Baltimore City']
NEI_losagelos_country[,location:='Los Angeles County']

result <- rbind(NEI_baltimore_city, NEI_losagelos_country)

png('plot6.png')
g <- ggplot(result, aes(x=factor(year), y=Emissions, fill=location)) +
  geom_bar(aes(fill=year),stat='identity') +
  facet_grid(scales='free', space='free', .~location) +
  guides(fill=FALSE) + theme_bw() +
  labs(x='year', y=expression('PM'[2.5]*' Emission Value')) + 
  labs(title=expression('PM'[2.5]*' Motor Vehicle Source Emissions in Baltimore & Los Angelos'))

print(g)

dev.off()
