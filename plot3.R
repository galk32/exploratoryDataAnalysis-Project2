#reading the files
nei <- readRDS("summarySCC_PM25.rds")

library(dplyr)

nei <- as_tibble(nei)
head(nei)

nei$year <- as.factor(nei$year)
nei$type <- as.factor(nei$type)

#making the sample with dplyr
nei1 <-nei %>%  select(fips,Emissions,type,year) %>%  filter(fips == "24510")

#ploting 
png(filename = "plot3.png", width = 900, height = 480, units = "px")

ggplot(nei1, aes(x=year, y=Emissions, fill=year)) +
  facet_grid(.~type) + geom_col() +
  theme_light()+
  labs(title = "Emission pm2.5 per type/year in Baltimore")

dev.off()       