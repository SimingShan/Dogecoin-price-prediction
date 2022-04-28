#### Preamble ####
# Purpose: Download data, plot ACF and PACF of the transformed data
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
library(forecast)
library(astsa)

getSymbols('DOGE-USD', from="2021-05-01", to="2022-04-26")

close_price <- `DOGE-USD`[,4]

close_price_diff <- diff(close_price)

trans <- diff(BoxCox(close_price,lambda = BoxCox.lambda(close_price)))

acf2(trans,100,main="ACF and PACF of the transfromed data")
