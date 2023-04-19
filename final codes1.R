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





