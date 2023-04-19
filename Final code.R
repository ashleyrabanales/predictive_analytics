##### ARIMA #####
library(quantmod)
library(smooth)
library(fBasics)
library(ggplot2)
library(forecast)
library(tseries)
library(gridExtra)
library(zoo)

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

# determine the order of differencing needed
auto.arima(train_data, max.p = 3, max.q = 3, max.d = 3)

# determine the order of the ARIMA model
p <- 1
d <- 1
q <- 1

# fit the ARIMA model to the training data
model <- Arima(train_data, order = c(p, d, q))
results <- forecast(model)


# make predictions on the testing data
predictions <- forecast(model, h = nrow(test_data))$mean

# make predictions on the testing data
predictions <- forecast(model, h = nrow(test_data))

# combine the actual and predicted values into a single data frame
results <- data.frame(year = index(test_data), actual = coredata(test_data), predicted = coredata(predictions$mean))

# combine actual and predicted values into a data frame
results_df <- data.frame(actual = c(train_data, test_data),
                         predicted = c(rep(NA, length(train_data)), predictions))

# add a time column to the data frame
results_df$time <- as.Date(index(results_df))

# plot the actual and predicted values
library(ggplot2)
ggplot(results_df, aes(x = time, y = value, color = variable)) +
  geom_line() +
  scale_color_manual(values = c("blue", "red")) +
  labs(x = "Year", y = "Price", color = "") +
  ggtitle("Actual and Predicted Values") +
  theme_minimal()



library(forecast)
# fit the ARIMA model to the training data
model <- Arima(train_data, order = c(p, d, q))

# generate the forecasts
forecast <- forecast(model, h = nrow(test_data))


# evaluate the performance of the ARIMA model
mae <- mean(abs(test_data - predictions))
mse <- mean((test_data - predictions)^2)
rmse <- sqrt(mse)
cat("MAE: ", mae, "\n")
cat("MSE: ", mse, "\n")
cat("RMSE: ", rmse, "\n")





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

# determine the order of differencing needed
auto.arima(train_data, max.p = 3, max.q = 3, max.d = 3)

# determine the order of the ARIMA model
p <- 0
d <- 1
q <- 2

# fit the ARIMA model to the training data
model <- Arima(train_data, order = c(p, d, q))
results <- forecast(model)

# make predictions on the testing data
predictions <- forecast(model, h = nrow(test_data))$mean

# evaluate the performance of the ARIMA model
mae <- mean(abs(test_data - predictions))
mse <- mean((test_data - predictions)^2)
rmse <- sqrt(mse)
cat("MAE: ", mae, "\n")
cat("MSE: ", mse, "\n")
cat("RMSE: ", rmse, "\n")

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
predictions <- forecast(model, h = nrow(test_data))$mean

# evaluate the performance of the ARIMA model
mae <- mean(abs(test_data - predictions))
mse <- mean((test_data - predictions)^2)
rmse <- sqrt(mse)
cat("MAE: ", mae, "\n")
cat("MSE: ", mse, "\n")
cat("RMSE: ", rmse, "\n")

















##### Random Forest #####

## GOOG ##

data <- getSymbols("GOOG", from = '2012-01-01', to = '2022-12-31', src = "yahoo")
data <- GOOG$GOOG.Adjusted

library(randomForest)
library(caret)

# Split the data into training and testing sets
split_idx <- floor(0.8 * nrow(data))
train_data <- data[1:split_idx, ]
test_data <- data[(split_idx + 1):nrow(data), ]

# Prepare the data for random forest training
lags <- 5
X_train <- matrix(nrow = nrow(train_data) - lags + 1, ncol = lags)
y_train <- train_data[(lags + 1):nrow(train_data), ]
for (i in 1:(nrow(train_data) - lags + 1)) {
  X_train[i, ] <- train_data[(i + lags - 1):(i), ]
}
X_test <- matrix(nrow = nrow(test_data) - lags + 1, ncol = lags)
y_test <- test_data[(lags + 1):nrow(test_data), ]
for (i in 1:(nrow(test_data) - lags + 1)) {
  X_test[i, ] <- test_data[(i + lags - 1):(i), ]
}

X_train <- X_train[1:2209, ]

# Train the random forest model
rf_model <- randomForest(X_train, y_train, ntree = 100, maxdepth = 10)

# Evaluate the model's performance on the testing data
pred_test <- predict(rf_model, X_test)
pred_test <- pred_test[1:549]
mae <- mean(abs(y_test - pred_test))
mse <- mean((y_test - pred_test)^2)
r2 <- cor(y_test, pred_test)^2
cat("MAE:", mae, "\n")
cat("MSE:", mse, "\n")
cat("R-squared:", r2, "\n")


## JPM ##

data <- getSymbols("JPM", from = '2012-01-01', to = '2022-12-31', src = "yahoo")
data <- JPM$JPM.Adjusted

library(randomForest)
library(caret)

# Split the data into training and testing sets
split_idx <- floor(0.8 * nrow(data))
train_data <- data[1:split_idx, ]
test_data <- data[(split_idx + 1):nrow(data), ]

# Prepare the data for random forest training
lags <- 5
X_train <- matrix(nrow = nrow(train_data) - lags + 1, ncol = lags)
y_train <- train_data[(lags + 1):nrow(train_data), ]
for (i in 1:(nrow(train_data) - lags + 1)) {
  X_train[i, ] <- train_data[(i + lags - 1):(i), ]
}
X_test <- matrix(nrow = nrow(test_data) - lags + 1, ncol = lags)
y_test <- test_data[(lags + 1):nrow(test_data), ]
for (i in 1:(nrow(test_data) - lags + 1)) {
  X_test[i, ] <- test_data[(i + lags - 1):(i), ]
}

X_train <- X_train[1:2209, ]

# Train the random forest model
rf_model <- randomForest(X_train, y_train, ntree = 100, maxdepth = 10)

# Evaluate the model's performance on the testing data
pred_test <- predict(rf_model, X_test)
pred_test <- pred_test[1:549]
mae <- mean(abs(y_test - pred_test))
mse <- mean((y_test - pred_test)^2)
r2 <- cor(y_test, pred_test)^2
cat("MAE:", mae, "\n")
cat("MSE:", mse, "\n")
cat("R-squared:", r2, "\n")


## TSLA ##

data <- getSymbols("TSLA", from = '2012-01-01', to = '2022-12-31', src = "yahoo")
data <- TSLA$TSLA.Adjusted

library(randomForest)
library(caret)

# Split the data into training and testing sets
split_idx <- floor(0.8 * nrow(data))
train_data <- data[1:split_idx, ]
test_data <- data[(split_idx + 1):nrow(data), ]

# Prepare the data for random forest training
lags <- 5
X_train <- matrix(nrow = nrow(train_data) - lags + 1, ncol = lags)
y_train <- train_data[(lags + 1):nrow(train_data), ]
for (i in 1:(nrow(train_data) - lags + 1)) {
  X_train[i, ] <- train_data[(i + lags - 1):(i), ]
}
X_test <- matrix(nrow = nrow(test_data) - lags + 1, ncol = lags)
y_test <- test_data[(lags + 1):nrow(test_data), ]
for (i in 1:(nrow(test_data) - lags + 1)) {
  X_test[i, ] <- test_data[(i + lags - 1):(i), ]
}

X_train <- X_train[1:2209, ]

# Train the random forest model
rf_model <- randomForest(X_train, y_train, ntree = 100, maxdepth = 10)

# Evaluate the model's performance on the testing data
pred_test <- predict(rf_model, X_test)
pred_test <- pred_test[1:549]
mae <- mean(abs(y_test - pred_test))
mse <- mean((y_test - pred_test)^2)
r2 <- cor(y_test, pred_test)^2
cat("MAE:", mae, "\n")
cat("MSE:", mse, "\n")
cat("R-squared:", r2, "\n")

