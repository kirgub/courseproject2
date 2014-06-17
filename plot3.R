#loading plyr
library(plyr)
library(ggplot2)
#Reading the File
NEI <- readRDS("summarySCC_PM25.rds")

#opening the PNG devise
png(filename="plot3.png",width = 480, height = 480, units = "px")

#subsetting the records
NEIsubset <- NEI[NEI$fips == "24510",]
#spliting by Year adn type
summarizedata=ddply(NEIsubset,.(year,type),summarize,temission=sum(Emissions))
#Ploting the graph
qplot(year,temission,data=summarizedata,facets=.~type,geom=c("point","line"))
#Close Devise
dev.off()