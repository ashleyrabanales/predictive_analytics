require("astsa")
###########################################################
##                                                       ##
## analysis of the glacial varve series                  ##
##                                                       ##
###########################################################

plot(varve)

plot(log(varve))

plot(diff(log(varve)))

acf2(diff(log(varve)))

arima(diff(log(varve)),c(0,0,1))

