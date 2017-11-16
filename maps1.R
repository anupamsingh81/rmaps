
require("rgdal")  # needed to load shapefiles

# obtain India administrative shapefiles and unzip
download.file("http://biogeo.ucdavis.edu/data/diva/adm/IND_adm.zip", 
              destfile = "IND_adm.zip")
unzip("IND_adm.zip", overwrite = TRUE)

# load shapefiles

india<-readOGR("IND_adm1.shp")

# check they've loaded correctly with a plot
plot(india)

# all fine. Let's plot an example variable using ggplot2
require("ggplot2")
require("rgeos")  # for fortify() with SpatialPolygonsDataFrame types

india@data$test <- sample(65000:200000000, size = nrow(india@data),
                          replace = TRUE)

# breaks the shapefile down to points for compatibility with ggplot2
indiaF <- fortify(india, region = "ID_1") # command to download maptools
indiaF <- merge(indiaF, india, by.x = "id", by.y = "ID_1")


# plot overall(with states)
ggplot() +  geom_polygon(data=indiaF, aes(x=long, y=lat, group=group))

# plots the polygon and fills them with the value of 'test'

ggplot() +
  geom_polygon(data = indiaF, aes(x = long, y = lat, group = group,
                                  fill = test)) +
  coord_equal()


summary(as.factor(indiaF$NAME_1))

library(tidyverse)

dilli = indiaF %>% filter(NAME_1=="Delhi")

#dilli

p = ggplot() +  geom_polygon(data=dilli, aes(x=long, y=lat),fill= "steel blue") # fill outside not inside

ggplot() +  geom_polygon(data=dilli, aes(x=long, y=lat,group=group,fill= test)) # fill outside not inside


# https://gis.stackexchange.com/questions/234942/keep-customized-colors-with-geom-polygon
# https://stackoverflow.com/questions/5996513/change-colour-scheme-for-ggplot-geom-polygon-in-r

k = data.frame(
la = c(28.6,28.6,28.75,28.75),
lo = c(77.3,77.25,77.2,77.15),

poll = c(76,100,108,300),

name= c("av","bv","cv","dv")
)
  
ggplot() +  geom_polygon(data=dilli, aes(x=long, y=lat,group=group),fill= "steel blue")+ # fill outside not inside
geom_point(data=k,aes(x=lo,y=la,size=poll,color=name))

la = c(28.6,28.6,28.75,28.75)
lo = c(77.3,77.25,77.2,77.15)

poll = c(76,100,108,300)

name= c("av","bv","cv","dv")

lax= rep(la,100)
lox = rep(lo,100)
pollx= rnorm(400,160,40)
namex= rep(name,100)

year = c(rep(1996,100),rep(1997,100),rep(1998,100),rep(1999,100))

m = data.frame(lax,lox,pollx,namex,year)
m = m %>% slice(1:400) # first 400

library(gganimate)


  
  library(ggrepel)
m1= m %>% filter(year=="1999")
m1$lax= rnorm(100,28.7,0.2)
m1$lox = rnorm(100,77.1,0.2)
 p+ geom_point(data=m1,aes(x=lox,y=lax,size=pollx,color=namex)) + geom_text(data=m1,aes(label=round(pollx,1),x=lox,y=lax))
}
k$date = c(rep(""))
library(tidyverse)

xk(d="1996")
xk(d="1610")
ak = 
m$time = c(rep(ak,4))

f1 =  function(x)(rep(x,4))
g= c(1:100)
h = map(g,f1)
m$time=unlist(map(g,f1))
k2= k %>% select(la,lo,name)
k3= m %>% select(namex,pollx,time) %>% rename(name=namex)
library(tidyr)
k4=left_join(k2,k3,by="name")

xk = function(d){
  
  m1= k4%>% filter(time==d)
  p+ geom_point(data=m1,aes(x=lo,y=la,size=pollx,color=name)) +labs(title=d) 
}
xk(d=40)

k4 %>% filter(time==40)
 

map_df(g,f1)

