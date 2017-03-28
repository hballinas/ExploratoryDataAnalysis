## This first line took over a minute in a Surface 3.  
if(!exists("NEI")){
    NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# QUESTION 1 IS:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

# I googled this r function because it has not been showed during course
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)

#Open graphics device

png('plot1.png')

#Use base system to plot

barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))

dev.copy(png, file = "plot1.png")
#Close graphics device
dev.off()