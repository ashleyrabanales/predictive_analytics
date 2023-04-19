# Stock Price Forecasting and Risk Measurements 

## Problem Statement & Objective: 
- Background: Investors are always looking for ways to maximize their returns while minimizing their risks. Accurate prediction of future stock prices and estimation of risk measures are crucial for making informed investment decisions. ​

- Data: historical stock prices data  in IT, automotive and banking sectors.​

- Aim: Develop effective and robust models and techniques for stock price forecasting and risk measures estimation that can provide accurate and reliable predictions and help investors make informed decisions.


### Stock price forecasting​

- Use time series models like ARIMA model to analyze the historical data of stock prices to identify patterns and trends. ​
- Use machine learning model like Random Forest to train algorithms that can predict future stock prices. ​
- The combination of two models can improve the accuracy of stock price predictions. ​
- Evaluate stock price predictions by MSE, MAE and RMSE.​

    __1. Results__:
    
 ### Orginal ACF plots and Time Series
    
<img width="323" alt="ACF_GOOGLE_ORG" src="https://user-images.githubusercontent.com/85587898/233221077-69d01dc8-f00f-4b91-bedb-2e9bb49d8334.png"> <img width="308" alt="ACF_JPM_ORG" src="https://user-images.githubusercontent.com/85587898/233221094-e749567f-6e4d-42cd-961c-04f931b8ae12.png"> <img width="278" alt="ACF_TELSE_ORG" src="https://user-images.githubusercontent.com/85587898/233221110-41112eb7-80f4-4483-bede-a0728422d7a6.png">



<img width="324" alt="TS_GOOGLE_ORG" src="https://user-images.githubusercontent.com/85587898/233221229-1dca305b-eb93-404e-a165-454bdca681e3.png"> <img width="276" alt="TS_JPM_ORG" src="https://user-images.githubusercontent.com/85587898/233221262-d9238b01-1e50-4c75-89d9-d995eb288c49.png"> <img width="278" alt="TS_TELSA_ORG" src="https://user-images.githubusercontent.com/85587898/233221274-fa75422e-a17b-4733-9b89-0303660985b2.png">





### Estimate risk measures​

- Calculate monthly log return and fit to AR/GARCH model, then predict one-step-ahead log return.​
- Utilize the return distribution to estimate risk measures like VaR. (estimates the maximum amount of loss that could be incurred on a stock investment within a given confidence interval) ​


    __2. Results__:



![](documents/fig_1R.png)



### TEXTBOOKS:
[S] Shumway, R.H., and Stoffer D.S., Time Series Analysis and Its Applications. Fourth Edition. Springer.
https://www.stat.pitt.edu/stoffer/tsa4/
[K] Kleiber, C., and Zeileis, A., Applied Econometrics with R. Springe

### OTHER USEFUL SOURCES:
[R] https://www.econometrics-with-r.org/
[E] The elements of statistical learning: https://web.stanford.edu/~hastie/Papers/ESLII.pdf
[D] Kleinbaum, D.G., and Klein M., Survival Analysis: A Self-Learning Text. Third Edition. Springer.
[T] Regress
