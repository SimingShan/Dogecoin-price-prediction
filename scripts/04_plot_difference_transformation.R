#### Preamble ####
# Purpose: Download data, produce a plot of the dogecoin price after difference transformation
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

getSymbols('DOGE-USD', from="2021-05-01", to="2022-04-26")

close_price <- `DOGE-USD`[,4]

close_price_diff <- diff(close_price)

close_price_df_diff <- data.frame(pirce = close_price_diff$`DOGE-USD.Close`, Date = time(close_price))

close_price_df_diff <- close_price_df_diff %>% clean_names()

close_price_df_diff <- close_price_df_diff[-c(1),]


ggplot(close_price_df_diff, aes(x=date,y=doge_usd_close)) + 
  geom_line(col="seagreen3")  +  
  labs(title="The price of the Dogecoin from May 2021 to April 2022 after difference transformation",
       x = "Date",
       y = "Price(USD)") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold",family="serif"),
        axis.title.x = element_text(family="serif"),
        axis.title.y = element_text(family="serif"))

