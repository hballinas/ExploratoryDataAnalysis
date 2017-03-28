## This first line took over a minute in a Surface 3.

if(!exists("NEI")){
    NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# QUESTION 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# 24510 is Baltimore, see plot2.R

#Load ggplot2 library
library(ggplot2)

#Subset NEI using fips as factor
subsetNEI  <- NEI[NEI$fips=="24510", ]

#use aggregate R function
aggregatedTotalByYearAndType <- aggregate(Emissions ~ year + type, subsetNEI, sum)


#plot

png("plot3.png", width=640, height=480)

g <- ggplot(aggregatedTotalByYearAndType, aes(year, Emissions, color = type))

#add geom
g <- g + geom_line() +
    xlab("year") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')

#print plot
print(g)

dev.copy(png, file = "plot3.png")
#close graphics device
dev.off()
