setwd("D:/Data Science/datasciencecoursera/EXPLORATORY PROJECT 2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds" )

#merge the two data sets
NEISCC <- merge(NEI, SCC, by="SCC")
str(NEISCC)

library(ggplot2)

subsetNEI  <- NEI[NEI$fips=="24510"  & NEI$type=="ON-ROAD", ]

AggregatedTotalYear <- aggregate(Emissions ~ year, subsetNEI, sum)

png("Project.Plot5.png", width = 640, height = 640)

g <- ggplot(AggregatedTotalYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat = "identity") + xlab("year") + ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = 24510) from 1999 to 2008")
print(g)

dev.off()
