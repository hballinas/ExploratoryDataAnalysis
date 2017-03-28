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


# QUESTION 4
# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999-2008?


library(ggplot2)


# Filter all NEIxSCC records with Short.Name (SCC) Coal

coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)


#Plot
png("plot4.png", width=640, height=480)g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emis
sions))
g <- g + geom_bar(stat="identity") +
    xlab("year") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()