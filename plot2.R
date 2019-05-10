#reading the files
nei <- readRDS("summarySCC_PM25.rds")

nei$year <- as.factor(nei$year)

#create the subset  for the sample

balmer <- subset(nei, fips == "24510")
str(balmer)
summary(balmer)

#make the plot
png(filename = "plot2.png", width = 480, height = 480, units = "px" )
with(balmer,boxplot(Emissions~year, outline = FALSE, col=c("blue","green","yellow","red"),
                 ylab= "Emission - Meryland", xlab="year", main="Total Emissions per year in Meryland"))
dev.off()


