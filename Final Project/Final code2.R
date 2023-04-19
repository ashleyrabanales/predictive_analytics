
##### Ashley ####
library(quantmod)
library(smooth)
library(fBasics)
library(ggplot2)
library(forecast)
library(tseries)
library(gridExtra)
library(zoo)


# Load six time series datas

# Chase Bank
getSymbols("JPM", from = '2012-01-01', to = '2022-12-31', src = "yahoo")

# Google
getSymbols("GOOG", from = '2012-01-01', to = '2022-12-31', src = "yahoo")

# Tesla
getSymbols("TSLA", from = '2012-01-01', to = '2022-12-31', src = "yahoo")

#####EDA 

# ARIMA model
#cleaning data
summary(GOOG) #check for NAs
summary(TSLA)
summary(JPM)

##data clean
GOOG[is.na(GOOG)] <- 0
TSLA[is.na(TSLA)] <- 0 
JPM[is.na(JPM)] <- 0

#GOOG$Date <- as.Date(GOOG$Date, format = "%Y-%m-%d")
#summary(GOOG)
library(xts)
library(gridExtra)

#plotting this as histograms
#GOOG
options(repr.plot.width=12, repr.plot.height=12) 

p1 = ggplot(fortify.zoo(GOOG), aes(GOOG.Adjusted)) + geom_histogram(bins = 50, aes(y = ..density..), col = "red", fill = "red", alpha = 0.3) + geom_density() + xlim(c(0, 500))

grid.arrange(p1, nrow=2,ncol=2)

#TSLA
options(repr.plot.width=12, repr.plot.height=12) 

p1 = ggplot(fortify.zoo(TSLA), aes(TSLA.Adjusted)) + geom_histogram(bins = 50, aes(y = ..density..), col = "red", fill = "red", alpha = 0.3) + geom_density() + xlim(c(0, 500))

grid.arrange(p1, nrow=2,ncol=2)

#JPM
options(repr.plot.width=12, repr.plot.height=12) 

p1 = ggplot(fortify.zoo(JPM), aes(JPM.Adjusted)) + geom_histogram(bins = 50, aes(y = ..density..), col = "red", fill = "red", alpha = 0.3) + geom_density() + xlim(c(0, 500))

grid.arrange(p1, nrow=2,ncol=2)

# TO PLOT THE HISTOGRAM, THE DATA SHOULD BE A DATAFRAME.
# USING fortify.zoo() FUNCTION, WE CAN CONVERT XST TO DATAFRAME.

#ACF for column Adj in GOOG
acf(GOOG$GOOG.Adjusted, lag.max=40) 

## Detrend by difference
df_goog <- diff(GOOG$GOOG.Adjusted)
df_goog[is.na(df_goog)] <- 0
plot(df_goog)
acf(df_goog)

acf(df_goog, lag.max=70, plot=FALSE) # get the autocorrelation values

#ACF for column Adj in TSLA
acf(TSLA$TSLA.Adjusted, lag.max=40) 

## Detrend by difference
df_T <- diff(TSLA$TSLA.Adjusted)
df_T[is.na(df_T)] <- 0
plot(df_T)
acf(df_T, lim=c(-0.2, 1))

acf(df_T, lag.max=70, plot=FALSE) # get the autocorrelation values

#ACF for column Adj in JPM
acf(JPM$JPM.Adjusted, lag.max=40) 

## Detrend by difference
df_j <- diff(JPM$JPM.Adjusted)
df_j[is.na(df_j)] <- 0
plot(df_j)
acf(df_j)

acf(df_j, lag.max=70, plot=FALSE) # get the autocorrelation values

###Decomposing
#install.packages("dplyr")
library(dplyr)

#GOOG
ts_data <- ts(GOOG$GOOG.Adjusted, frequency = 365) # Assuming daily data
decomposed_data <- decompose(ts_data)
#TSLA
tsla_data <- ts(TSLA$TSLA.Adjusted, frequency = 365) # Assuming daily data
decomposed_data <- decompose(tsla_data)
#JPM
jpm_data <- ts(JPM$JPM.Adjusted, frequency = 365) # Assuming daily data
decomposed_data <- decompose(jpm_data)

# Plot the original time series GOOG
plot(ts_data, main = "GOOG Original Time Series")
plot(tsla_data, main = "TSLA Original Time Series")
plot(jpm_data, main = "JPM Original Time Series")


########### GOOG ###########
# Split into train and test set
set.seed(1)
library(caret)
train_ind <- createDataPartition(GOOG$GOOG.Adjusted, p = 0.7, list = FALSE) 
data.train <- GOOG$GOOG.Adjusted[train_ind, ]
data.test <- GOOG$GOOG.Adjusted[-train_ind, ]

#createDataPartitio - function to train and test data 

# Fit the ARIMA model
library(forecast)
tsarima <- auto.arima(data.train, max.p = 3, max.q = 3, max.d = 3)
print(tsarima)

summary(tsarima)
# auto.arima estimate the optimal arima

# print the estimated ARIMA parameters
tsarima$coef

# Prediction with test set 
l <- length(data.test)
tsforecasts <- forecast(tsarima, h = l) # forecast the next 828 time series

# print the accuracy
accuracy(tsforecasts, data.test, l)

# plot the ARIMA model
plot(tsforecasts, main = "ARIMA Model for Google Stock Prices")

########### TSLA ###########

# Split into train and test set
set.seed(1)
library(caret)
train_ind <- createDataPartition(TSLA$TSLA.Adjusted, p = 0.7, list = FALSE) 
data.train <- TSLA$TSLA.Adjusted[train_ind, ]
data.test <-TSLA$TSLA.Adjusted[-train_ind, ]

#createDataPartitio - function to train and test data 

# Fit the ARIMA model
library(forecast)
tsarima <- auto.arima(data.train, max.p = 3, max.q = 3, max.d = 3)
print(tsarima)

summary(tsarima)
# auto.arima estimate the optimal arima

# print the estimated ARIMA parameters
tsarima$coef

# Prediction with test set 
l <- length(data.test)
tsforecasts <- forecast(tsarima, h = l) # forecast the next 828 time series

# print the accuracy
accuracy(tsforecasts, data.test, l)

# plot the ARIMA model
plot(tsforecasts, main = "ARIMA Model for Telsa Stock Prices")



########### JPM ##########

# Split into train and test set
set.seed(1)
library(caret)
train_ind <- createDataPartition(JPM$JPM.Adjusted, p = 0.7, list = FALSE) 
data.train <- JPM$JPM.Adjusted[train_ind, ]
data.test <-JPM$JPM.Adjusted[-train_ind, ]

#createDataPartitio - function to train and test data 

# Fit the ARIMA model
library(forecast)
tsarima <- auto.arima(data.train, max.p = 3, max.q = 3, max.d = 3)
print(tsarima)

summary(tsarima)
# auto.arima estimate the optimal arima

# print the estimated ARIMA parameters
tsarima$coef

# Prediction with test set 
l <- length(data.test)
tsforecasts <- forecast(tsarima, h = l) # forecast the next 828 time series

# print the accuracy
accuracy(tsforecasts, data.test, l)

# plot the ARIMA model
plot(tsforecasts, main = "ARIMA Model for JP. Morgan Stock Prices")








#####Jongtaek#####
##### ARIMA #####

## JPM ##
data <- getSymbols("JPM", from = '2012-01-01', to = '2022-12-31', src = "yahoo")
data <- JPM$JPM.Adjusted

library(tidyverse)
library(forecast)

# split the data into training and testing sets
train_data <- subset(data, end = as.Date("2019-12-31"))
test_data <- subset(data, start = as.Date("2020-01-01"))

# check if the time series is stationary
adf_test <- adf.test(train_data)
if(adf_test$p.value > 0.05) {
  print("The time series is non-stationary. Differencing is needed.")
  # perform differencing to make the time series stationary
  diff_data <- diff(train_data, differences = 1)
} else {
  print("The time series is stationary.")
  diff_data <- train_data
}

# determine the order of the ARIMA model
auto.arima(train_data, max.p = 3, max.q = 3, max.d = 3)

p <- 0
d <- 1
q <- 2

# fit the ARIMA model to the training data
model <- Arima(train_data, order = c(p, d, q))
results <- forecast(model)

# make predictions on the testing data
predictions <- forecast(model, h = nrow(test_data))$fitted

# evaluate the performance of the ARIMA model
mae <- mean(abs(test_data - predictions))
mse <- mean((test_data - predictions)^2)
rmse <- sqrt(mse)
cat("MAE: ", mae, "\n")
cat("MSE: ", mse, "\n")
cat("RMSE: ", rmse, "\n")

# Plot the result
library(ggplot2)

# combine the actual and predicted values into a data frame
plot_data <- data.frame(date = index(test_data), actual = test_data, predicted = predictions)

# plot the actual and predicted values
ggplot(plot_data, aes(x = date, y = test_data)) +
  geom_line(aes(color = "Actual"), size = 1) +
  geom_line(aes(y = predicted, color = "Predicted"), size = 0.5) +
  labs(title = "JPM Actual vs Predicted Values", y = "Price", color = "Legend") +
  scale_color_manual(values = c("Actual" = "blue", "Predicted" = "yellow")) +
  theme_bw() +
  theme(legend.position = "left") +
  geom_vline(xintercept = as.numeric(as.Date("2020-01-01")), 
             linetype="dashed", color="black", size=1)
  




## GOOG ##
data <- getSymbols("GOOG", from = '2012-01-01', to = '2022-12-31', src = "yahoo")
data <- GOOG$GOOG.Adjusted

library(tidyverse)
library(forecast)

# split the data into training and testing sets
train_data <- subset(data, end = as.Date("2019-12-31"))
test_data <- subset(data, start = as.Date("2020-01-01"))

# check if the time series is stationary
adf_test <- adf.test(train_data)
if(adf_test$p.value > 0.05) {
  print("The time series is non-stationary. Differencing is needed.")
  # perform differencing to make the time series stationary
  diff_data <- diff(train_data, differences = 1)
} else {
  print("The time series is stationary.")
  diff_data <- train_data
}

# determine the order of the ARIMA model
auto.arima(train_data, max.p = 3, max.q = 3, max.d = 3)

p <- 1
d <- 1
q <- 1

# fit the ARIMA model to the training data
model <- Arima(train_data, order = c(p, d, q))
results <- forecast(model)

# make predictions on the testing data
predictions <- forecast(model, h = nrow(test_data))$fitted

# evaluate the performance of the ARIMA model
mae <- mean(abs(test_data - predictions))
mse <- mean((test_data - predictions)^2)
rmse <- sqrt(mse)
cat("MAE: ", mae, "\n")
cat("MSE: ", mse, "\n")
cat("RMSE: ", rmse, "\n")

# Plot the result
library(ggplot2)

# combine the actual and predicted values into a data frame
plot_data <- data.frame(date = index(test_data), actual = test_data, predicted = predictions)

# plot the actual and predicted values
ggplot(plot_data, aes(x = date, y = test_data)) +
  geom_line(aes(color = "Actual"), size = 1) +
  geom_line(aes(y = predicted, color = "Predicted"), size = 0.5) +
  labs(title = "GOOGLE Actual vs Predicted Values", y = "Price", color = "Legend") +
  scale_color_manual(values = c("Actual" = "blue", "Predicted" = "yellow")) +
  theme_bw() +
  theme(legend.position = "left") +
  geom_vline(xintercept = as.numeric(as.Date("2020-01-01")), 
             linetype="dashed", color="black", size=1)







## TSLA ##
data <- getSymbols("TSLA", from = '2012-01-01', to = '2022-12-31', src = "yahoo")
data <- TSLA$TSLA.Adjusted

library(tidyverse)
library(forecast)

# split the data into training and testing sets
train_data <- subset(data, end = as.Date("2019-12-31"))
test_data <- subset(data, start = as.Date("2020-01-01"))

# check if the time series is stationary
adf_test <- adf.test(train_data)
if(adf_test$p.value > 0.05) {
  print("The time series is non-stationary. Differencing is needed.")
  # perform differencing to make the time series stationary
  diff_data <- diff(train_data, differences = 1)
} else {
  print("The time series is stationary.")
  diff_data <- train_data
}

# determine the order of differencing needed
auto.arima(train_data, max.p = 3, max.q = 3, max.d = 3)

# determine the order of the ARIMA model
p <- 0
d <- 1
q <- 1

# fit the ARIMA model to the training data
model <- Arima(train_data, order = c(p, d, q))
results <- forecast(model)

# make predictions on the testing data
predictions <- forecast(model, h = nrow(test_data))$fitted

# evaluate the performance of the ARIMA model
mae <- mean(abs(test_data - predictions))
mse <- mean((test_data - predictions)^2)
rmse <- sqrt(mse)
cat("MAE: ", mae, "\n")
cat("MSE: ", mse, "\n")
cat("RMSE: ", rmse, "\n")

# Plot the result
library(ggplot2)

# combine the actual and predicted values into a data frame
plot_data <- data.frame(date = index(test_data), actual = test_data, predicted = predictions)

# plot the actual and predicted values
ggplot(plot_data, aes(x = date, y = test_data)) +
  geom_line(aes(color = "Actual"), size = 1) +
  geom_line(aes(y = predicted, color = "Predicted"), size = 0.5) +
  labs(title = "Telsa Actual vs Predicted Values", y = "Price", color = "Legend") +
  scale_color_manual(values = c("Actual" = "blue", "Predicted" = "yellow")) +
  theme_bw() +
  theme(legend.position = "left") +
  geom_vline(xintercept = as.numeric(as.Date("2020-01-01")), 
             linetype="dashed", color="black", size=1)
















##### Random Forest #####

## JPM ##

library(randomForest)
library(quantmod)

getSymbols("JPM", from = '2012-01-01', to = '2022-12-31', src = "yahoo")

adj_JPM <- JPM$JPM.Adjusted
data <- data.frame(adj_JPM, lag(adj_JPM, 1), lag(adj_JPM, 2))
colnames(data) <- c("adj_JPM", "lag1", "lag2")
data <- na.omit(data)

set.seed(1234)
trainIndex <- sample(1:nrow(data), 0.7*nrow(data))
train <- data[trainIndex,]
test <- data[-trainIndex,]

model <- randomForest(adj_JPM ~ lag1 + lag2, data = train, ntree = 1000)

predictions <- predict(model, newdata = test)

mae <- mean(abs(test$adj_JPM - predictions))
mse <- mean((test$adj_JPM - predictions)^2)
rmse <- sqrt(mse)
cat("MAE: ", mae, "\n")
cat("MSE: ", mse, "\n")
cat("RMSE: ", rmse, "\n")

plot_data <- data.frame(date = index(test), actual = test$adj_JPM, predicted = predictions)
ggplot(plot_data, aes(x = date, y = actual)) +
  geom_line(aes(color = "Actual"), size = 1) +
  geom_line(aes(y = predictions, color = "Predicted"), size = 0.5) +
  geom_vline(xintercept = as.numeric(plot_data$date[600]), color = "black", linetype = "dashed") +
  scale_color_manual(values = c("blue", "red", "red"), 
                     labels = c("Actual", "Predicted", "Vertical Line")) +
  labs(title = "JPM Actual vs Predicted Values", y = "Price") +
  theme_bw()



## GOOG ##

library(randomForest)
library(quantmod)

getSymbols("GOOG", from = '2012-01-01', to = '2022-12-31', src = "yahoo")

adj_GOOG <- GOOG$GOOG.Adjusted
data <- data.frame(adj_GOOG, lag(adj_GOOG, 1), lag(adj_GOOG, 2))
colnames(data) <- c("adj_GOOG", "lag1", "lag2")
data <- na.omit(data)

set.seed(1234)
trainIndex <- sample(1:nrow(data), 0.7*nrow(data))
train <- data[trainIndex,]
test <- data[-trainIndex,]

model <- randomForest(adj_GOOG ~ lag1 + lag2, data = train, ntree = 1000)

predictions <- predict(model, newdata = test)

mae <- mean(abs(test$adj_GOOG - predictions))
mse <- mean((test$adj_GOOG - predictions)^2)
rmse <- sqrt(mse)
cat("MAE: ", mae, "\n")
cat("MSE: ", mse, "\n")
cat("RMSE: ", rmse, "\n")

plot_data <- data.frame(date = index(test), actual = test$adj_GOOG, predicted = predictions)
ggplot(plot_data, aes(x = date, y = actual)) +
  geom_line(aes(color = "Actual"), size = 1) +
  geom_line(aes(y = predictions, color = "Predicted"), size = 0.5) +
  geom_vline(xintercept = as.numeric(plot_data$date[600]), color = "black", linetype = "dashed") +
  scale_color_manual(values = c("blue", "red", "red"), 
                     labels = c("Actual", "Predicted", "Vertical Line")) +
  labs(title = "GOOGLE Actual vs Predicted Values", y = "Price") +
  theme_bw()





## TSLA ##

library(randomForest)
library(quantmod)

getSymbols("TSLA", from = '2012-01-01', to = '2022-12-31', src = "yahoo")

adj_TSLA <- TSLA$TSLA.Adjusted
data <- data.frame(adj_TSLA, lag(adj_TSLA, 1), lag(adj_TSLA, 2))
colnames(data) <- c("adj_TSLA", "lag1", "lag2")
data <- na.omit(data)

set.seed(1234)
trainIndex <- sample(1:nrow(data), 0.7*nrow(data))
train <- data[trainIndex,]
test <- data[-trainIndex,]

model <- randomForest(adj_TSLA ~ lag1 + lag2, data = train, ntree = 1000)

predictions <- predict(model, newdata = test)

mae <- mean(abs(test$adj_TSLA - predictions))
mse <- mean((test$adj_TSLA - predictions)^2)
rmse <- sqrt(mse)
cat("MAE: ", mae, "\n")
cat("MSE: ", mse, "\n")
cat("RMSE: ", rmse, "\n")

plot_data <- data.frame(date = index(test), actual = test$adj_TSLA, predicted = predictions)
ggplot(plot_data, aes(x = date, y = actual)) +
  geom_line(aes(color = "Actual"), size = 1) +
  geom_line(aes(y = predictions, color = "Predicted"), size = 0.5) +
  geom_vline(xintercept = as.numeric(plot_data$date[600]), color = "black", linetype = "dashed") +
  scale_color_manual(values = c("blue", "red", "red"), 
                     labels = c("Actual", "Predicted", "Vertical Line")) +
  labs(title = "Telsa Actual vs Predicted Values", y = "Price") +
  theme_bw()


