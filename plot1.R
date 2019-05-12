#reading the files

nei <- readRDS("summarySCC_PM25.rds")
nei$year <- as.factor(nei$year)

total.emmision <- tapply(nei$Emissions, nei$year, sum)
te.df <- data.frame(year = names(total.emmision), Emissions=total.emmision,row.names = NULL)

#making the plot
png(filename = "plot1.png", width = 480, height = 480, units = "px")
barplot(height = te.df$Emissions/1000, names.arg = te.df$year,col=c("blue","green","yellow","red"),
        ylab= "Emission pm[2.5] per ton", xlab="year", main="Total Emissions per year", ylim = c(0,8000))


dev.off()