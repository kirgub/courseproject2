#Reading the File
NEI <- readRDS("summarySCC_PM25.rds")

#opening the PNG devise
png(filename="plot2.png",width = 480, height = 480, units = "px")

#subsetting the records
NEIsubset <- NEI[NEI$fips == "24510",]
#spliting by Year adn type
summarizeemission<-sapply(splityear,function(x) sum(x$Emissions))
#Ploting the graph
plot(names(summarizeemission),summarizeemission,type="l",xlab="Calendar Year",ylab="Total Emissions (in Tons)")
title(main = "Total emissions over years in Baltimore")
#Close Devise
dev.off()