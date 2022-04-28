#### Preamble ####
# Purpose: Download data, produce a plot of the volume of Dogecoin
# Author: Siming Shan
# Data: 27 March 2022
# Contact: siming.shan@mail.utoronto.ca
# License: MIT

### workplace setup ###
library(quantmod)
library(dplyr)
library(janitor)
library(ggplot2)
library(ggthemes)

### get the dataset###
getSymbols('DOGE-USD', from="2021-05-01", to="2022-04-26")
doge_all <- `DOGE-USD`
doge_all <- data.frame(doge_close = doge_all$`DOGE-USD.Close`,
                       doge_open = doge_all$`DOGE-USD.Open`,
                       doge_high = doge_all$`DOGE-USD.High`,
                       doge_low = doge_all$`DOGE-USD.Low`,
                       doge_adjusted = doge_all$`DOGE-USD.Adjusted`,
                       doge_volume = doge_all$`DOGE-USD.Volume`,
                       date = time(`DOGE-USD`))
doge_all <- doge_all %>% clean_names()

ggplot(doge_all, aes(x=date,y=doge_usd_volume)) + 
  geom_line(col="darksalmon") +
  labs(title="The volume of the Dogecoin from May 2021 to April 2022",
       x = "Date",
       y = "Volume") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold",family="serif"),
        axis.title.x = element_text(family="serif"),
        axis.title.y = element_text(family="serif"))