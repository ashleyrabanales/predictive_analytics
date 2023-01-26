# Question 3

require("fpp2")

#(a) Plot the data and explain what key components (such as trend, seasonality, etc.) it has.
autoplot(debitcards)
  #Increasing trend, seasonal yearly, inc variation


#b) Plot its ACF and also explain how we understand the key components that the data has on the ACF plot.

 # ACF plot
acf(debitcards) # there is a default number formula


# Question 4 

#(a) Plot the data. Do you believe the series are stationary (explain your answer)?
autoplot(gasoline) 
#No its not because it has a trend increase and seasonality. The mean and covariance changes

#(b) In economics, it is often the percentage change in price (termed growth rate or return),
#rather than the absolute price change, that is important. Use a transformation of the
#form yt = ∇ log xt (∇ stands for differencing) to the data, plot the data, look at the
#sample ACFs of the transformed data, and comment.

# yt = ∇ log xt (∇ stands for differencing)
df_gas <- diff(gasoline) 
plot(df_gas)

#Looks as it is stationary since it performs like white noise.


