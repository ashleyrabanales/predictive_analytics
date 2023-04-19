library(quantmod)
library(smooth)
library(fBasics)
library(ggplot2)
library(forecast)
library(tseries)
#install.packages("gridExtra") #install the package
library(gridExtra) 


# Load six time series datas
# Bank of America
getSymbols("BAC", from = '2012-01-01', to = '2022-12-31', src = "yahoo")

# Chase Bank
getSymbols("JPM", from = '2012-01-01', to = '2022-12-31', src = "yahoo")

# Apple
getSymbols("AAPL", from = '2012-01-01', to = '2022-12-31', src = "yahoo")

# Google
getSymbols("GOOG", from = '2012-01-01', to = '2022-12-31', src = "yahoo")

# Tesla
getSymbols("TSLA", from = '2012-01-01', to = '2022-12-31', src = "yahoo")

# Honda
getSymbols("HMC", from = '2012-01-01', to = '2022-12-31', src = "yahoo")

#####EDA 
# ARIMA model
#clenaing data
summary(GOOG) #check for NAs

##data clean
GOOG[is.na(GOOG)] <- 0
GOOG$Date <- as.Date(GOOG$Date, format = "%Y-%m-%d")
summary(GOOG)


#plotting this as histograms
gridExtra::grid.arrange(p1, p2, p3, p4, nrow = 2, ncol = 2)

options(repr.plot.width=12, repr.plot.height=12) 
p1 = ggplot(GOOG, aes(GOOG.Adjusted)) + geom_histogram(bins = 50, aes(y = ..density..), col = "red", fill = "red", alpha = 0.3) + geom_density()# + xlim(c(0, 1000))

grid.arrange(p1, nrow=2,ncol=2)


#ACF for column Adj in GOOG
Acf(GOOG$GOOG.Adjusted, lag.max=40) 

## Detrend by difference
df_goog <- diff(GOOG$GOOG.Adjusted) 
plot(df_goog)

Acf(df_goog, lag.max=70, plot=FALSE) # get the autocorrelation values

#partial
Pacf(df_goog, lag.max=70) 
Pacf(df_goog, lag.max=70, plot=FALSE) # get the partial autocorrelation values

###Decomposing
#install.packages("dplyr")
library(dplyr)

ts_data <- ts(GOOG$GOOG.Adjusted, frequency = 365) # Assuming daily data
decomposed_data <- decompose(ts_data)

# Plot the original time series
plot(ts_data, main = "Original Time Series")
# Plot the trend component
plot(decomposed_data$trend, main = "Trend Component")
# Plot the seasonal component
plot(decomposed_data$seasonal, main = "Seasonal Component")
# Plot the remainder component
plot(decomposed_data$random, main = "Remainder Component")



