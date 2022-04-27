install.packages("quantmod")
install.packages("aTSA")
install.packages("fpp2")
library(quantmod)
library(forecast)
library(astsa)
library(aTSA)
library(fpp2)
library(tidyverse)
getSymbols('DOGE-USD', from="2021-05-01", to="2022-04-23")

write.csv(as.data.frame(`DOGE-USD`),"inputs/data/DOGE-USD.csv")

close_price <- `DOGE-USD`[,4]

ts.plot(close_price)

ts.plot(log(close_price))

ts.plot(diff(close_price))

ts.plot(BoxCox(close_price,lambda = BoxCox.lambda(close_price)))

ts.plot(diff(BoxCox(close_price,lambda = BoxCox.lambda(close_price))))

trans <- BoxCox(close_price,lambda = BoxCox.lambda(close_price))

model <- auto.arima(trans)

model

sarima(trans,2,1,1)
df <- forecast::forecast(model,10)

autoplot(df)

predictions <- forecast::forecast(model,10)

predictions

sarima.for(trans,10,2,1,0)

invers_BoxCox = function(ts_data, lambda){
  original_ts = (ts_data * lambda + 1) ** (1/lambda)
  return(original_ts)
}

forecast_df = cbind(data.frame(predictions[4]), 
                    data.frame(predictions[5]), 
                    data.frame(predictions[6]))

the_forecast = invers_BoxCox(forecast_df, lambda = BoxCox.lambda(close_price))

the_forecast

the_forecast = the_forecast %>%
  mutate(Date = c("2022-04-24","2022-04-25","2022-04-26","2022-04-27","2022-04-28",
                  "2022-04-29","2022-04-30","2022-05-01","2022-05-02","2022-05-03")) %>%
  as_tibble()

the_forecast$Date <- as.Date(the_forecast$Date)

close_price_df <- data.frame(pirce = close_price$`DOGE-USD.Close`, Date = time(close_price))

the_forecast %>% ggplot(aes(x=Date, y=mean)) + geom_line(col="red") +
  geom_line(close_price_df, mapping = aes(x=Date, y=DOGE.USD.Close)) +
  scale_y_continuous()
  
