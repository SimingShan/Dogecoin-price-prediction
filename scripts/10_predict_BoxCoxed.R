#### Preamble ####
# Purpose: Download data, predict the price of the Dogecoin after Box-Cox transformation
# Author: Siming Shan
# Data: 27 March 2022
# Contact: siming.shan@mail.utoronto.ca
# License: MIT

prediction <- sarima.for(box_cox_trans,10,1,1,1)
prediction_df_box <- data.frame(prediction = prediction$pred)
prediction_df_box <- prediction_df_box %>% 
  mutate(date = c("2022-04-27","2022-04-28","2022-04-29","2022-04-30","2022-05-01","2022-05-02","2022-05-03","2022-05-04","2022-05-05","2022-05-06")) %>%
  as_tibble()

prediction_df_box$date <- as.Date(prediction_df_box$date)


ggplot(boxcox_df,aes(x=date,y=doge_usd_close)) +
  geom_line(col="seagreen3") +
  geom_line(prediction_df_box,mapping=aes(x=date,y=prediction),col="red3") +
  labs(title = "Prediction of Dogecoin price for the next ten days",
       x = "Date",
       y = "Box-Cox transformed Price(USD)") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold",family="serif"),
        axis.title.x = element_text(family="serif"),
        axis.title.y = element_text(family="serif"))