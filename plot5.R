#loading plyr
library(plyr)
#Reading the Files of both NEI and SCC
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subsetting the records
NEIsubset <- NEI[NEI$fips == "24510",]

# Identifying the Mobile related sources (EI.Sector is "Mobile" )
MobileSCC <- SCC[grepl("mobile",SCC$EI.Sector,ignore.case=T),]
Mergeddata <- join(NEIsubset,MobileSCC,by="SCC",type="inner")

#opening the PNG devise
png(filename="plot5.png",width = 480, height = 480, units = "px")

#spliting by Year
splityear <- split(Mergeddata,Mergeddata$year)
#summarizing the emission by year
summarizeemission<-sapply(splityear,function(x) sum(x$Emissions))
#Ploting the graph
plot(names(summarizeemission),summarizeemission,type="l",xlab="Calendar Year",ylab="Total Emissions (in Tons)")
title(main = "Baltimore Total emissions from Mobile related sources over years")
#Close Devise
dev.off()