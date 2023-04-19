## resource https://otexts.com/fpp2/appendix-for-instructors.html

#install.packages("fpp2")
require("fpp2") # Data for "Forecasting: Principles and Practice" (2nd Edition)

## creating and plotting a time series subject 
a <- c(123,39,78,52,110)
plot(a)

y <- ts(c(123,39,78,52,110), start=2012) # ts object in R
plot(y)

typeof(a)
class(a)

typeof(y)
class(y)

# The monthly Australian electricity demand series
plot(elec)
autoplot(elec) + xlab("Year") + ylab("GWh")

frequency(elec) # the number of observations before the seasonal pattern repeats.
start(elec)

# ACF plot
acf(elec) # there is a default number formula
acf(elec, lag=48) # specific lags

# transformation
plot(log(elec))

plot(sqrt(elec))

plot(log(elec+1000))

## Detrending by differencing
df_elec <- diff(elec) 
plot(df_elec)

# decompose
elec_components <- decompose(elec) # X = Trend + Seasonal + Noise 
plot(elec_components)




