## This first line took over a minute in a Surface 3.
if(!exists("NEI")){
    NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# QUESTION 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Create a subset of the data using fips 24510 as factor
subsetNEI  <- NEI[NEI$fips=="24510", ]

# Use R function 'aggregate'
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

# Plot
png('plot2.png')

barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))

dev.off()

