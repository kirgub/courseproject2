#Reading the File
NEI <- readRDS("summarySCC_PM25.rds")

#opening the PNG devise
png(filename="plot1.png",width = 480, height = 480, units = "px")

#spliting by Year
splityear <- split(NEI,NEI$year)
#summarizing the emission by year
summarizeemission<-sapply(splityear,function(x) sum(x$Emissions))
#Ploting the graph
plot(names(summarizeemission),summarizeemission,type="l",xlab="Calendar Year",ylab="Total Emissions (in Tons)")
title(main = "Total emissions over years in US")
#Close Devise
dev.off()