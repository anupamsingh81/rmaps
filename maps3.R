require("rgdal")  # needed to load shapefiles

# obtain India administrative shapefiles and unzip
download.file("http://biogeo.ucdavis.edu/data/diva/adm/IND_adm.zip", 
              destfile = "IND_adm.zip")
unzip("IND_adm.zip", overwrite = TRUE)

# load shapefiles

india<-readOGR("IND_adm1.shp") # important

# check they've loaded correctly with a plot
plot(india) #important

num.states<-length(india$NAME_1)
num.states
mydata<-data.frame(NAME_1=india$NAME_1, id=india$ID_1, prevalence=rnorm(num.states, 55, 20))
head(mydata)

pubhealth <- fortify(india, region = "ID_1")
class(pubhealth)
head(pubhealth)

pubhealth <- merge(pubhealth, mydata, by= "id", all.x=TRUE)
head(pubhealth)

ggplot() +
  geom_polygon(data = pubhealth, aes(x = long, y = lat, group = group,
                                  fill = prevalence)) +
  coord_equal()

#nicer plot

library(scales)
library(RColorBrewer)
library(ggmap)

ggplot() +
  geom_polygon(data = pubhealth, 
               aes(x = long, y = lat, group = group, fill = prevalence), 
               color = "black", size = 0.25) + 
  coord_equal()+
  scale_fill_distiller(name="Percent", palette = "YlGn", breaks = pretty_breaks(n = 5))+
  theme_nothing(legend = TRUE)+
  labs(title="Prevalence of X in India")
