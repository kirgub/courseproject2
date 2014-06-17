#loading plyr
library(plyr)
#Reading the Files of both NEI and SCC
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subsetting the records
BNEIsubset <- NEI[NEI$fips == "24510",]
LANEIsubset <- NEI[NEI$fips == "06037",]
# Identifying the Mobile related sources (EI.Sector is "Mobile" )
MobileSCC <- SCC[grepl("mobile",SCC$EI.Sector,ignore.case=T),]
BMergeddata <- join(BNEIsubset,MobileSCC,by="SCC",type="inner")
LAMergeddata <- join(LANEIsubset,MobileSCC,by="SCC",type="inner")


#opening the PNG devise
png(filename="plot6.png",width = 480, height = 480, units = "px")


#summarizing the emission by year
Bsummarizedata=ddply(BMergeddata,.(year),summarize,temission=sum(Emissions))
LAsummarizedata=ddply(LAMergeddata,.(year),summarize,temission=sum(Emissions))
colnames(LAsummarizedata) <- c("LAyear","LAtemission")
summarizedata<-cbind(Bsummarizedata,LAsummarizedata)

# Setting the pallete
par(mfrow = c(1, 2))
#Ploting the graph

with(summarizedata,plot(year,temission,type="l",xlab="Calendar Year",ylab="Total Emissions (in Tons)",col="black",main="Baltimore"))
with(summarizedata,plot(year,LAtemission,type="l",col="red",xlab="Calendar Year",ylab="",main="LA"))
#Close Devise
dev.off()