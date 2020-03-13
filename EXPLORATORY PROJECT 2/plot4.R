
setwd("D:/Data Science/datasciencecoursera/EXPLORATORY PROJECT 2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds" )

NEISCC <- merge(NEI, SCC, by="SCC")
str(NEISCC)

library(ggplot2)

coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

AggregatedTotalYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)

png("Project.Plot4.png", width = 640, height = 640)

g <- ggplot(AggregatedTotalYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat = "identity") + xlab("year") + ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions from cola sources from 1999 to 2008")
print(g)

dev.off()

