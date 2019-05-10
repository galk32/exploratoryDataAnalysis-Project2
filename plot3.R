#reading the files
nei <- readRDS("summarySCC_PM25.rds")

library(ggplot2)

nei$year <- as.factor(nei$year)
nei$type <- as.factor(nei$type)

#subseting Baltimore
balmer <- subset(nei, fips == "24510")

#making the plot in ggplot2 

png(filename = "plot3.png", width = 900, height = 480, units = "px")

g <- ggplot(balmer, aes(year, Emissions, colors = year))
g + geom_boxplot(outlier.shape = NA) + facet_grid(.~type) + ylim(0,65) +
  labs(title = "Emission pm2.5 per type/year in Baltimore") +theme_light()

dev.off()  


