#### Preamble ####
# Purpose: Download data, produce a plot of all four different prices
# Author: Siming Shan
# Data: 27 March 2022
# Contact: siming.shan@mail.utoronto.ca
# License: MIT

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

ggplot() + 
  geom_line(doge_all,mapping=aes(x=date, y=doge_usd_close, color="Opening price")) +
  geom_line(doge_all,mapping=aes(x=date, y=doge_usd_open, color="Closing price")) +
  geom_line(doge_all,mapping=aes(x=date, y=doge_usd_high, color="High price")) +
  geom_line(doge_all,mapping=aes(x=date, y=doge_usd_low, color="Low price")) +
  geom_line(doge_all,mapping=aes(x=date, y=doge_usd_adjusted, color="Adjusted price")) +
  labs(title = "Five different prices from January 2021 to present",
       x = "Date",
       y = "Price(USD)") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold",family="serif"),
        legend.title = element_blank(),
        legend.position = "bottom",
        axis.title.x = element_text(family="serif"),
        axis.title.y = element_text(family="serif"))