########### 5 
#Consider the Monthly Federal Reserve Board Production Index data prodn (from library astsa).
require("astsa")

#(a) Fit the model using first-order differenced log transformed series.
plot(prodn)

df <- prodn
df2 <- diff(log(df))
plot(df2)

#(b) By visually checking, decide what SARIMA models seem appropriate, i.e., 
#specify p, d, q and P,D,Q in SARIMA model, ARIMA(p, d, q) × (P, D, Q)s. Choose the most appropriate two models and explain your answer.

#0 2 2 3 0 0 and 0 1 2 3 1 0

#(c) Fit the two SARIMA models which you chose in part (b) using sarima function in R and interpret the result. 
#Choose the better model and explain the reason.
test1 = sarima(log(df), 0, 2, 2, 3, 0, 0,S=12)
test2 = sarima(log(df), 0, 1, 2, 3, 1, 0, S=12)

#test 2 is better bc it the acf tends to be stationary than test1

#(d)Make a prediction for the next 4 values based on your final model.
#Make sure that you predict the values in the original scale, not transformed values.

library(caret)
predict(test1, n.ahead=4)$pred
predict(test2, n.ahead=4)$pred

########## 6



pidenticaltwin <- function(fraternalprob, indenticalpron)
    results <- ((identicalprob * 1/2) /(fraternalprob * 1/4 + identicalprob *1/2))  
    return(result)

pidenticaltwin(fraternalprob = 1/150, identicalprob = 1/400)
               
pidenticaltwin(fraternalprob = 1/125, identicalprob = 1/300)
               