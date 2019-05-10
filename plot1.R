#reading the files

nei <- readRDS("summarySCC_PM25.rds")
nei$year <- as.factor(nei$year)

#making the plot

png(filename = "plot1.png", width = 480, height = 480, units = "px")
with(nei,boxplot(Emissions~year, outline = FALSE, col=c("blue","green","yellow","red"),
                 ylab= "Emissions", xlab="year", main="Total Emissions per year"))

dev.off()
