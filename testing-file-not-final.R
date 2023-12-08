#Not working effectively right now

#Population Experimentation


#Cleaning population dataset
##popula = read_csv(here("rawdata","international-db-pop-2021-uscensus.csv")) 
##names(popula) = popula[1,]
##popula = popula[-1,]

#Make table with sightings with populations from 2021
##colnames(popula)[1]="country"
##colnames(popula)[5]="population"
##all(ufogdp$country %in% popula$country)
##pop21sight = inner_join(popula, ufogdp,
##by = c("country"))
##pop21sight = subset(pop21sight, select = c(country, population, year, sightings, gdpcapita))



#Linear model on sightings by population
##popsightmodel <- lm(sightings ~ population, data = pop21sight)
##summary(popsightmodel)
##sightpopplot<- ggplot(pop21sight, aes(population, sightings)) +geom_point() +geom_smooth(method = 'lm')

##grid.arrange(sightpopplot)

#figure out how to make population go from 0 to max value

#remove values with sightings greater than 500
##pop21sight=pop21sight[pop21sight$sightings<500,]

#Linear model on sightings by population sightings less than 500
##popsightmodel <- lm(sightings ~ population, data = pop21sight)
##summary(popsightmodel)
##sightpopplot<- ggplot(pop21sight, aes(population, sightings)) +geom_point() +geom_smooth(method = 'lm')

##grid.arrange(sightpopplot)

#Bar Chart check
##ggplot(pop21sight, aes(population, sightings))+geom_col()

#Histogram check
##hist(pop21sight$sightings)
#frequency is number of countries

#barplot check
##barplot(pop21sight$sightings)
