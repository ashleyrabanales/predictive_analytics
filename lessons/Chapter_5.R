require(astsa)


##################################
##
## air passengers example
## AirPassengers
##
##################################

x = prodn
plot(x)
plot(log(x))
plot(diff(log(x)))

acf2(diff(log(x)),100)

## remove the seasonality

####################################################
## remove monthly average
monthplot(diff(log(x))) # plot seasonal (or other) subseries of a time series
xtrans = diff(log(x))

## get monthly average
monthly = tapply(xtrans, cycle(xtrans), mean) #apply some function (mean) to a vector (xtrans), grouped by another vector (cycle(xtrans))

xmean = c(monthly[2:12],rep(monthly,11)) # rep: replicate a vector, Jan, 1949 is missing in the data, so cut that part.

xx = xtrans - xmean
monthplot(xx)

plot(xx)
acf2(xx)
sarima(xx,1,0,1)

#Residuals are useful in checking whether a model has adequately captured the information in the data. A good forecasting method will yield residuals with the following properties:
  
# 1. The residuals are uncorrelated. If there are correlations between residuals, then there is information left in the residuals which should be used in computing forecasts.
# 2. The residuals have zero mean. If the residuals have a mean other than zero, then the forecasts are biased.


# Determining whether the error terms are normally distributed 
# in a time series model can be useful, since some inferences
# assume normal errors.
# A normal Q-Q plot of the residuals is a graphical check for
# normal errors.
# If the Q-Q plot resembles a straight line, then the assumption
# that the errors are normally distributed is reasonable.

# The Ljung-Box test checks whether the entire set of residual
# correlations is larger than we would expect to see if the
# correct ARMA-type model was specified.
# If the p value is greater than 0.05 then the residuals are 
# independent which we want for the model to be correct. 

###############################################
# if we do not remove seasoanlity

## arima(0,1,1)*(0,1,0) s=12
a = sarima(x,1,1,1,0,1,0,12)

## arima(0,1,1)*(0,1,1) s=12
sarima(x,0,1,1,0,1,1,12)

sarima(x,1,1,0,0,1,1,12)

sarima.for(x,24,0,1,1,0,1,1,12) # will forcast next 24 observations




