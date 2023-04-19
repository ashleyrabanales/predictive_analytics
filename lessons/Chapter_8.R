## RecreationDemand Example
## source: https://rdrr.io/cran/AER/man/RecreationDemand.html
install.packages("AER")
library(AER)
data("RecreationDemand")

?RecreationDemand

hist(RecreationDemand$trips)
table(RecreationDemand$trips)

var(RecreationDemand$trips)
mean(RecreationDemand$trips)

## Poisson model:
## Cameron and Trivedi (1998), Table 6.11
## Ozuna and Gomez (1995), Table 2, col. 3
fm_pois <- glm(trips ~ ., data = RecreationDemand, family = poisson)
summary(fm_pois)
coeftest(fm_pois, vcov = sandwich)

## prediction
mu <- predict(fm_pois, type = "response") # predict expected mean count
?predict.glm
predict(fm_pois, type = "response")[1] ## mu1
exp(predict(fm_pois, type = "response")[1])

table(RecreationDemand$trips)
table(RecreationDemand$trips,round(mu)) ## predicted vs actual
plot(table(RecreationDemand$trips,round(mu)))

## now group things to less number of cells
a = RecreationDemand$trips
b = round(mu)
actual = a*(a<=10)+(a>10)*11
predicted = b*(b<=10)+(b>10)*11
table(actual,predicted)
plot(table(actual,predicted))

## test for overdispersion
dispersiontest(fm_pois)
out = dispersiontest(fm_pois)
?dispersiontest

## Negbin model:
## Cameron and Trivedi (1998), Table 6.11
## Ozuna and Gomez (1995), Table 2, col. 5
library("MASS")
fm_nb <- glm.nb(trips ~ ., data = RecreationDemand)
coeftest(fm_nb, vcov = vcovOPG)

## predicted vs actual
a = RecreationDemand$trips
b = round(exp(predict(fm_nb)))
actual = a*(a<=10)+(a>10)*11
predicted = b*(b<=10)+(b>10)*11
table(actual,predicted)
plot(table(actual,predicted))

## ZIP model:
## Cameron and Trivedi (1998), Table 6.11
library("pscl")
fm_zip <- zeroinfl(trips ~  . | quality + income, data = RecreationDemand)
summary(fm_zip)


