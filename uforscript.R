library(tidyverse)
library(janitor)
library(here)

#Cleaning load and clean data set
area <- read_csv(here("rawdata", "land-area-km.csv")) |> clean_names()
area <- area|>filter(year == 2020)
area <- area |> rename(country = entity)

#Clean ufo dataset 
ufo <- read_csv(here("rawdata", "ufo-sightings-transformed.csv")) |> clean_names()
ufo<-count(ufo, country, sort = TRUE) |> na.omit(ufo)

#Clean gdp per capita dataset
development <- read_csv(here("rawdata", "gdp-per-capita-worldbank.csv")) |> clean_names()
development<- development |> filter(year == "2021") |> rename(country = entity)


#Merge to make linear model
ufogdp<- merge(x = ufo, y = development, by = "country", all.y = TRUE) |>
  rename(sightings = n, gdpcapita = gdp_per_capita_ppp_constant_2017_international)
ufogdp[is.na(ufogdp)] <- 0

#Linear model on sightings by GDP
sightingsModel<- lm(sightings ~ gdpcapita, data = ufogdp)
summary(sightingsModel)
ufoplot<- ggplot(ufogdp, aes(gdpcapita, sightings)) +geom_point() +geom_smooth(method = 'lm')

#This is messy, US is a huge outlier so I will remove that data point
ufonoUS<- ufogdp |> filter(country != "United States")
sightingsModelNoUS<- lm(sightings ~ gdpcapita, data = ufonoUS)
summary(sightingsModelNoUS)
noUSPlot<- ggplot(ufonoUS, aes(gdpcapita, sightings)) +geom_point() +geom_smooth(method = 'lm')

#Look at both models at the same time:
require(gridExtra)
grid.arrange(noUSPlot, ufoplot)

#Linear model on sightings by area and GDP (not our topic but we can look at it)

areagdp <- merge(x = area, y = ufogdp, by = "country", all.y = TRUE)
areagdp[is.na(areagdp)] <- 0
areamodel <- lm(sightings ~ gdpcapita + land_area_sq_km, data = areagdp)
summary(areamodel)
#areaplot <- ggplot(areagdp, aes(gdpcapita,sightings)) +geom_point()

