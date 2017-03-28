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


# Subset coal combustion related NEI data by looking combustion and coal
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

#Plot
png("plot4.png", width=840, height=480)

g <- ggplot(combustionNEI,aes(factor(year),Emissions/10^5)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() + guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(g)
# Copying plot
dev.copy(png, file = "plot4.png")
dev.off()