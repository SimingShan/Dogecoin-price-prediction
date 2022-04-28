#### Preamble ####
# Purpose: Download data, produce a plot the close price of the dogecoin
# Author: Siming Shan
# Data: 27 March 2022
# Contact: siming.shan@mail.utoronto.ca
# License: MIT

### workplace setup ###
library(quantmod)
library(forecast)
library(astsa)
library(aTSA)
library(fpp2)
library(tidyverse)

getSymbols('DOGE-USD', from="2021-05-01", to="2022-04-26")

close_price <- `DOGE-USD`[,4]

close_price_df <- data.frame(pirce = close_price$`DOGE-USD.Close`, Date = time(close_price))

close_price_df <- close_price_df %>% clean_names()

ggplot(close_price_df, aes(x=date,y=doge_usd_close)) + 
  geom_line(col = "seagreen3") +  
  labs(title="The price of the Dogecoin from May 2021 to April 2022",
       x = "Date",
       y = "Price(USD)") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold",family="serif"),
        axis.title.x = element_text(family="serif"),
        axis.title.y = element_text(family="serif"))