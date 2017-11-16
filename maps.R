

# load level 1 india data (india with states)
# If we want to get and map district level data then we need to use the level 2 data as follows :
# To move to the district, sub-division ( or taluk) level we need to use the level three data file

library(sp)
library(RColorBrewer)

# http://visual.yantrajaal.com/2015/05/using-r-for-maps-of-india-state.html

ind2= readRDS("IND_adm2.rds")

ind2 = gadm

#and then plot the various districts as

# plotting districts of a State, in this case West Bengal
wb2 = (ind2[ind2$NAME_1=="West Bengal",])
spplot(wb2,"NAME_1", main = "West Bengal Districts", colorkey =F)


delhi = (ind2[ind2$NAME_1=="NCT of Delhi",])

del= spplot(delhi,"NAME_1", main = "Delhi Districts", colorkey =F)

ind2$NAME_1