## This first line took over a minute in a Surface 3.

if(!exists("NEI")){
    NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# merge the two data sets.  Decided to check first before running as it took
# almost 5 minutes to merge in a Surface
if(!exists("NEISCC")){
    NEISCC <- merge(NEI, SCC, by="SCC")
}


# QUESTION 5
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# 24510 is Baltimore, as noted since plot 2.
# Searching for ON-ROAD type in NEI.  There's no motor type


library(ggplot2)

#Subset using type=ON-ROAD
subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)


#Plot
png("plot5.png", width=840, height=480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
    xlab("year") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()