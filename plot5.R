#reading the files and libraries 
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(stringr)

nei <- as_tibble(nei)
scc <- as_tibble(scc)

#making the vehicle data frame from the scc using dplyr 

nei$SCC <- as.factor(nei$SCC)
nei$year <- as.factor(nei$year)

scc2 <- scc %>% select(SCC, EI.Sector) %>% filter(str_detect(EI.Sector, "Vehicles"))
merged1 <- inner_join(nei,scc2, by ="SCC")

#Baltimore data
merged1_bal <- merged1 %>% filter(fips == "24510") %>% group_by(year) 
merged1_bal_total <- merged1_bal %>% summarize(Emissions = sum(Emissions))

#Los Angeles data
merged1_cal <- merged1 %>% filter(fips == "06037") %>% group_by(year) %>%
  summarize(Emissions = sum(Emissions))

#making the plots
png(filename = "plot5.png", width = 500, height = 900, units = "px")
rng=range(merged1_bal_total$Emissions,merged1_cal$Emissions)
par(mfcol= c(2,1), mar=c(4,4,1,1))
with(merged1_bal_total, barplot(height = Emissions, names.arg = year, ylim = c(0,5000),
  col=c("blue","green","yellow","red"), xlab = "year", ylab ="Emission pm[2.5] per ton", 
  main = "Emissions pm25 per year in Baltimore from Motor Vehicle sources"))

with(merged1_cal, barplot(height = Emissions, names.arg = year, ylim = c(0,5000),
    col=c("blue","green","yellow","red"), xlab = "year", ylab ="Emission pm[2.5] per ton", 
    main = "Emissions pm25 per year in California from Motor Vehicle sources"))

dev.off()
     