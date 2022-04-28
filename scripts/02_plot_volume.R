#### Preamble ####
# Purpose: Download data, produce a plot of the volume of Dogecoin
# Author: Siming Shan
# Data: 27 March 2022
# Contact: siming.shan@mail.utoronto.ca
# License: MIT

ggplot(doge_all, aes(x=date,y=doge_usd_volume)) + 
  geom_line(col="darksalmon") +
  labs(title="The volume of the Dogecoin from May 2021 to April 2022",
       x = "Date",
       y = "Volume") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold",family="serif"),
        axis.title.x = element_text(family="serif"),
        axis.title.y = element_text(family="serif"))