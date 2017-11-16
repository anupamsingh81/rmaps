
# https://stackoverflow.com/questions/22855197/how-do-you-get-geom-map-to-show-all-parts-of-a-map

library(ggplot2)
library(maps)
library(plyr)
library(gridExtra)

ARCTP53_SOExample <- read.csv("dat.csv")

# reduce all the distinct exon/introns to just exon or intron

ARCTP53_SOExample$EorI <- factor(ifelse(grepl("exon", 
                                              ARCTP53_SOExample$ExonIntron, 
                                              ignore.case = TRUE), 
                                        "exon", "intron"))

# extract summary data for the two variables we care about for the map

arc.combined <- count(ARCTP53_SOExample, .(Country, EorI))
colnames(arc.combined) <- c("region", "EorI", "ei.ct")

# get total for country (region) and add to the summary info

arc.combined <- merge(arc.combined, count(arc.combined, .(region), wt_var=.(ei.ct)))
colnames(arc.combined) <- c("region", "EorI", "ei.ct", "region.total")

# it wasn't specified if the "EorI" is going to be used on the map so 
# we won't use it below (but we could, now)

# get map and intercourse Antarctica

world_map <- map_data("world")
world_map <- subset(world_map, region!="Antarctica")

# this will show the counts by country with all of the "chart junk" removed
# and the "counts" scaled as a gradient, and with the legend at the top

gg <- ggplot(arc.combined)
gg <- gg + geom_map(dat=world_map, map = world_map, aes(map_id=region), 
                    fill="white", color="#7f7f7f", size=0.25)
gg <- gg + geom_map(map = world_map, aes(map_id = region, fill = region.total), size=0.25)
gg <- gg + scale_fill_gradient(low="#fff7bc", high="#cc4c02", name="Tumor counts")
gg <- gg + expand_limits(x = world_map$long, y = world_map$lat)
gg <- gg + labs(x="", y="", title="Tumor contribution by country")
gg <- gg + theme(panel.grid=element_blank(), panel.border=element_blank())
gg <- gg + theme(axis.ticks=element_blank(), axis.text=element_blank())
gg <- gg + theme(legend.position="top")
gg