#### Preamble ####
# Purpose: Download data, create the inverse function, then predict the actually price
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

trans <- diff(BoxCox(close_price,lambda = BoxCox.lambda(close_price)))

box_cox_trans <- BoxCox(close_price,lambda = BoxCox.lambda(close_price))

prediction <- sarima.for(box_cox_trans,10,1,1,1)
prediction_df_box <- data.frame(prediction = prediction$pred)
prediction_df_box <- prediction_df_box %>% 
  mutate(date = c("2022-04-27","2022-04-28","2022-04-29","2022-04-30","2022-05-01","2022-05-02","2022-05-03","2022-05-04","2022-05-05","2022-05-06")) %>%
  as_tibble()

prediction_df_box$date <- as.Date(prediction_df_box$date)

inverse = function(data, lambda){
  original = (data * lambda + 1) ** (1/lambda)
  return(original)
}

the_forecast = inverse(prediction_df_box$prediction, lambda = BoxCox.lambda(close_price))

the_forecast_df <- data.frame(prediction = the_forecast)

the_forecast_df = the_forecast_df %>%
  mutate(date = c("2022-04-27","2022-04-28","2022-04-29","2022-04-30","2022-05-01","2022-05-02","2022-05-03","2022-05-04","2022-05-05","2022-05-06")) %>%
  as_tibble()

the_forecast_df$date <- as.Date(the_forecast_df$date)

ggplot(close_price_df,aes(x=date,y=doge_usd_close)) +
  geom_line(col="seagreen3") +
  geom_line(the_forecast_df,mapping=aes(x=date,y=prediction),col="red3") +
  labs(title = "Prediction of Dogecoin price for the next ten days",
       x = "Date",
       y = "Price(USD)") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold",family="serif"),
        axis.title.x = element_text(family="serif"),
        axis.title.y = element_text(family="serif"))
