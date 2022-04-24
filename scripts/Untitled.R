install.packages("quantmod")
install.packages("aTSA")
install.packages("fpp2")
library(quantmod)
library(forecast)
library(astsa)
library(aTSA)
library(fpp2)
getSymbols('DOGE-USD', from="2021-5-1", to="2022-04-23")

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

sarima.for(trans,10,2,1,0)

the_forecast = invers_BoxCox(forecast_df, lambda = BoxCox.lambda(close_price))

invers_BoxCox = function(ts_data, lambda){
  original_ts = (ts_data * lambda + 1) ** (1/lambda)
  return(original_ts)
}


the_forecast

predictions[2]

forecast_df = cbind(data.frame(predictions[4]), 
                    data.frame(predictions[5]), 
                    data.frame(predictions[6]))


