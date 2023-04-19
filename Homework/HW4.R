#Hoemwork 4 

#Q4

crime <- read.csv("https://raw.githubusercontent.com/proback/BeyondMLR/master/data/c_data2.csv")

#(a) Create a histogram with 15 bins to explore the response variable.
hist(crime$total_crime, breaks = 15, col = "skyblue",
     xlab = "Number of Crimes", main = "Histogram of Crime Counts")

#(b) Create a variance-mean graph of the histogram you created and investigate the dispersion within the data using the graph.
library(MASS)
glm.fit <- glm(crime$total_crime ~ 1, family = poisson(link = "log"))
vm <- glm.fit$residuals^2
fit <- glm(vm ~ fitted(glm.fit), family = gaussian(link = "log"))
plot(fit$fitted.values, fit$residuals, xlab = "Fitted values",
     ylab = "Deviance residuals", main = "Variance-Mean Plot")
abline(h = 0, lty = 2, col = "red")

#(c) Fit a Poisson regression model to explore whether or not average crime counts differ with the region.
glm.fit <- glm(total_crime ~ region, data = crime, family = poisson(link = "log"))
summary(glm.fit)

#Null deviance: 20122  on 80  degrees of freedom
#Residual deviance: 18782  on 75  degrees of freedom
#AIC: 19337

#(d) Run a test to check for over-dispersion in your Poisson regression model. Is there evidence of overdispersion
library(AER)
dispersiontest(glm.fit, trafo = 1)
#z = 4.3251, p-value = 7.623e-06
#alternative hypothesis: true alpha is greater than 0
#sample estimates: alpha 264.8659 
#there is over dispersion since p-value in less than alpha

#Q5

data("DoctorVisits", package = "AER")

## Poisson regression
mod_pois <- glm(visits ~ . + I(age^2), data = DoctorVisits, family = poisson)
summary(dv_pois)
library(AER)
dispersiontest(mod_pois, trafo = 1)
#z = 6.5428, p-value = 3.019e-11
#alternative hypothesis: true alpha is greater than 0
#sample estimates:alpha 0.4144272

#p-value of 3.019e-11, which is less than 0.05, providing evidence of overdispersion in the data.
# Therefore, we have to fit zero-inflated poisson model in this case. 

#########   Q6  ##########
install.packages('vcd')
library(vcd)
library(ggplot2)
data("Affairs", package = "AER")


#Based on AIC, negative binomial is the best.
#
## Poisson regression ###
mod_pois <- glm(affairs ~ age + yearsmarried + religiousness + occupation + rating,
               data = Affairs, family = poisson)
summary(fm_pois)

  #1) Log likelihood; -1427.037 (df=6)
  logLik(fm_pois)

  #2) AIC: 2866.1
  AIC(fm_pois)

  #3) Predicted vs. actual
  predicted <- predict(mod_pois, type = "response")
  actual <- Affairs$affairs
  
  df <- data.frame(predicted = predicted, actual = actual)

  ggplot(df, aes(x = predicted, y = actual)) +
    geom_point() +
    geom_abline(intercept = 0, slope = 1, color = "red") +
    xlab("Predicted") +
    ylab("Actual") +
    ggtitle("Predicted vs. Actual Plot")


  
  
### Negative Binomial ###
library(MASS)
mod_nb <- glm.nb(affairs ~ age + yearsmarried + religiousness + occupation + rating,
                  data = Affairs)
coeftest(mod_nb, vcov = vcovOPG)
summary(mod_nb)


  #1) log-likelihood:  -1456.4880 
  #2) AIC: 1470.5
  #3) Predicted vs. actual
predicted <- predict(mod_nb, type = "response")
actual <- Affairs$trips
df <- data.frame(predicted = predicted, actual = actual)

ggplot(df, aes(x = predicted, y = actual)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, color = "red") +
  xlab("Predicted") +
  ylab("Actual") +
  ggtitle("NB Predicted vs. Actual Plot")



### Zero Inflated Poisson ###
library(pscl)
mod_zip <- zeroinfl(affairs ~ age + yearsmarried + religiousness + occupation + rating, data = Affairs, dist = "poisson")
summary(fm_zip)

  #Log-likelihood: -765.9 on 12 Df
  #AIC:1555.732
  AIC(mod_zip)
  #predicted vs actaul
  predicted <- predict(mod_zip, type = "response")
  actual <- Affairs$trips
  df <- data.frame(predicted = predicted, actual = actual)
  
  ggplot(df, aes(x = predicted, y = actual)) +
    geom_point() +
    geom_abline(intercept = 0, slope = 1, color = "red") +
    xlab("Predicted") +
    ylab("Actual") +
    ggtitle("ZIP Predicted vs. Actual Plot")
  
  #rootogram

## Zero Inflated Negative binomial ###
mod_zinb <- zeroinfl(affairs ~ age + yearsmarried + religiousness + occupation + rating, data = Affairs, dist = "negbin")
vuong(fm_pois, mod_zinb)
summary(mod_zinb)

  #Log-likelihood: -698.6 on 13 Df
  #AIC-corrected         -10.47632 model2 > model1 < 2.22e-16
  #BIC-corrected         -10.28496 model2 > model1 < 2.22e-16

  #predicted vs actual
predicted <- predict(mod_zinb, type = "response")
actual <- Affairs$trips
df <- data.frame(predicted = predicted, actual = actual)

ggplot(df, aes(x = predicted, y = actual)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, color = "red") +
  xlab("Predicted") +
  ylab("Actual") +
  ggtitle("ZINB Predicted vs. Actual Plot")
  

  #rootogram for all 
pred_root.pois <- predict(mod_pois)
library(ggplot2)
library(countreg)
install.packages("vcd")
library(rootogram)
library(vcd)
library("grid")
library("MASS")
root.pois <- rootogram(pred_root.pois, style = "hanging", plot = FALSE)
root.nb   <- rootogram(Affairs_nb, style = "hanging", plot = FALSE)
root.zip <- rootogram(Affairs_ZIP, style = "hanging", plot = FALSE)
root.zin <- rootogram(Affairs_ZIN, style = "hanging", plot = FALSE)


ylims <- ylim(-2, 7)  # common scale for comparison
plot_grid(autoplot(root.pois) + ylims, autoplot(root.nb) + ylims, 
          autoplot(root.zip) + ylims, autoplot(root.zin) + ylims,
          ncol = 3, labels = "auto")
