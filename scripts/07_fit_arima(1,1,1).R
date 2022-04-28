#### Preamble ####
# Purpose: Download data, fit the transformaed data into ARIMA(1,1,1)
# Author: Siming Shan
# Data: 27 March 2022
# Contact: siming.shan@mail.utoronto.ca
# License: MIT

model111 <- sarima(box_cox_trans,1,1,1)