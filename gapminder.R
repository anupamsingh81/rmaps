library(gapminder)
library(ggplot2)
theme_set(theme_bw())

p <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, color = continent, frame = year)) +
  geom_point() +
  scale_x_log10()

library(gganimate)

gganimate(p)


g <- gganimate(p, interval = .1, title_frame = FALSE, "filename.gif")


g <- gganimate(p, interval = .1, title_frame = TRUE, "gap.gif")
data(gapminder)
head(gapminder)