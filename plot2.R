#reading the files
nei <- readRDS("summarySCC_PM25.rds")
nei$year <- as.factor(nei$year)

total.emmision <- tapply(nei$Emissions, nei$year, sum)

#create the subset  for the sample

balmer <- subset(nei, fips == "24510")
total.emmission.Bal <- tapply(balmer$Emissions,balmer$year,sum)

#creating dataframe of Baltimore
te.df.b <- data.frame(year = names(total.emmission.Bal), Emissions =total.emmission.Bal, row.names = NULL)

#make the plot
png(filename = "plot2.png", width = 480, height = 480, units = "px" )
barplot(height = te.df.b$Emissions, names.arg = te.df.b$year,col=c("blue","green","yellow","red"),
        ylab= "Emission pm[2.5] per ton", xlab="year", main="Total Emissions per year in Baltimore", ylim=c(0,4000))

dev.off()


