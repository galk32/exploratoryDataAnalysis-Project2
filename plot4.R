#reading the files and libraries 
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(stringr)

nei <- as_tibble(nei)
scc <- as_tibble(scc)

#making the coal data frame from the scc using dplyr 

nei$SCC <- as.factor(nei$SCC)
nei$year <- as.factor(nei$year)

scc1 <- scc %>% select(SCC, EI.Sector) %>% filter(str_detect(EI.Sector, "Coal"))

#merging the two objects
merged <- inner_join(nei, scc1, by="SCC")
merged1 <- merged %>% group_by(year) %>%  summarise(sumemmision = sum(Emissions))

#making the plot
png(filename = "plot4.png", width = 900, height = 480, units = "px")
ggplot(merged, aes(x= year, y=Emissions/1000, fill=year)) + 
  geom_col()+
  labs(y = "Emissions PM25 per ton - Coal", title = "Emissions from Coal Combustion related sources")

dev.off()
