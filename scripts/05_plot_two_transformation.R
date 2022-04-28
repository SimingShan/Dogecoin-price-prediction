#### Preamble ####
# Purpose: Download data, produce a plot of Dogecoin price after Box_Cox transformation and difference transformation
# Author: Siming Shan
# Data: 27 March 2022
# Contact: siming.shan@mail.utoronto.ca
# License: MIT

close_price_diff <- diff(close_price)

trans <- diff(BoxCox(close_price,lambda = BoxCox.lambda(close_price)))

box_cox_trans <- BoxCox(close_price,lambda = BoxCox.lambda(close_price))

lambda <- BoxCox.lambda(close_price)

trans_df <- data.frame(pirce = trans$`DOGE-USD.Close`, Date = time(close_price))

boxcox_df <- data.frame(pirce = box_cox_trans$`DOGE-USD.Close`, Date = time(close_price))

trans_df <- trans_df %>% clean_names()

boxcox_df <- boxcox_df %>% clean_names()

trans_df <- trans_df[-c(1),]

ggplot(trans_df, aes(x=date,y=doge_usd_close)) + 
  geom_line(col = "seagreen") +  
  labs(title="The price of the Dogecoin from May 2021 to April 2022 after two transformations",
       x = "Date",
       y = "Price(USD)") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold",family="serif"),
        axis.title.x = element_text(family="serif"),
        axis.title.y = element_text(family="serif"))