#### Preamble ####
# Purpose: Download data, produce the plot of the price of Dogecoin price
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

### Get the dataset ###
getSymbols('DOGE-USD',from="2018-01-01", to="2022-04-26")
doge_whole <- `DOGE-USD`
doge_whole <- doge_whole[,4]
doge_whole <- data.frame(close_price = doge_whole$`DOGE-USD.Close`, Date = time(doge_whole))
doge_whole <- doge_whole %>% clean_names()
ggplot(doge_whole,aes(x=date,y=doge_usd_close)) + 
  geom_line(col="seagreen3") +
  labs(title = "The close price of Dogecoin from January 2018 to April 2022",
       x = "Date",
       y = "Price(USD)") +
  theme(plot.title = element_text(face="bold", hjust = 0.5,  family="serif"),
        axis.title.x = element_text(family="serif"),
        axis.title.y = element_text(family="serif"))
