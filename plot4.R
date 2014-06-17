#loading plyr
library(plyr)
#Reading the Files of both NEI and SCC
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Identifying the Coal cumbustion related sources (SCC.Level.One for "Combustion" and EI.Sector for "Coal" )
CoalSCC <- SCC[grepl("coal",SCC$EI.Sector,ignore.case=T) | grepl("combustion",SCC$SCC.Level.One,ignore.case=T),]
Mergeddata <- join(NEI,CoalSCC,by="SCC",type="inner")

#opening the PNG devise
png(filename="plot4.png",width = 480, height = 480, units = "px")

#spliting by Year
splityear <- split(Mergeddata,Mergeddata$year)
#summarizing the emission by year
summarizeemission<-sapply(splityear,function(x) sum(x$Emissions))
#Ploting the graph
plot(names(summarizeemission),summarizeemission,type="l",xlab="Calendar Year",ylab="Total Emissions (in Tons)")
title(main = "US Total emissions from coal cumbustion related sources over years")
#Close Devise
dev.off()