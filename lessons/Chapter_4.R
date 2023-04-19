require("astsa")

###########################################################
##                                                       ##
## estimation and prediction for the recruitment series  ##
##                                                       ##
###########################################################
plot(rec)
acf2(rec)


####### Yule-walker estimation (Method of Moments)
rec.yw = ar.yw(rec,order=2)
rec.yw$x.mean
rec.yw$ar # coefficients


### MLE
rec.mle = ar.mle(rec,order=2)
rec.mle$x.mean
rec.mle$ar

fore.mle = predict(rec.mle, n.ahead=240) #n.ahead: The number of steps ahead for which prediction is required.
ts.plot(rec,fore.mle$pred,col=1:2,xlim=c(1980,2010),ylab="recruitment")

## ordinary least squares (ols) estimation 
regr = ar.ols(rec,order=2,demean=FALSE, intercept=TRUE)

fore = predict(regr, n.ahead=24)
ts.plot(rec,fore$pred,col=1:2,xlim=c(1980,1990),ylab="recruitment")


