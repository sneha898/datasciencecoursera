setwd("D:/Data Science/datasciencecoursera/EXPLORATORY PROJECT 2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds" )

NEISCC <- merge(NEI, SCC, by="SCC")
str(NEISCC)

library(ggplot2)

subsetNEI  <- NEI[(NEI$fips=="24510" | NEI$fips=="06037") & NEI$type=="ON-ROAD", ]

AggregatedTotalYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
AggregatedTotalYear$fips[AggregatedTotalYear$fips=="24510"] <- "Baltimore, MD"
AggregatedTotalYear$fips[AggregatedTotalYear$fips=="06037"] <- "Los Angeles, CA"

png("Project.Plot6.png", width = 1040, height = 480)

g <- ggplot(AggregatedTotalYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(.~ fips) + geom_bar(stat = "identity") + xlab("year") + 
  ylab(expression("Total PM"[2.5]*" Emissions")) + 
  ggtitle("Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = 24510) vs Los Angeles, CA (fips = 06037)  1999-2008")
print(g)

dev.off()
