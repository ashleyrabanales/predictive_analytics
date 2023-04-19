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




     __1. Process__:
    
 ### Orginal ACF plots and Time Series
    
<img width="323" alt="ACF_GOOGLE_ORG" src="https://user-images.githubusercontent.com/85587898/233221077-69d01dc8-f00f-4b91-bedb-2e9bb49d8334.png"> <img width="308" alt="ACF_JPM_ORG" src="https://user-images.githubusercontent.com/85587898/233221094-e749567f-6e4d-42cd-961c-04f931b8ae12.png"> <img width="278" alt="ACF_TELSE_ORG" src="https://user-images.githubusercontent.com/85587898/233221110-41112eb7-80f4-4483-bede-a0728422d7a6.png">



<img width="324" alt="TS_GOOGLE_ORG" src="https://user-images.githubusercontent.com/85587898/233221229-1dca305b-eb93-404e-a165-454bdca681e3.png"> <img width="276" alt="TS_JPM_ORG" src="https://user-images.githubusercontent.com/85587898/233221262-d9238b01-1e50-4c75-89d9-d995eb288c49.png"> <img width="278" alt="TS_TELSA_ORG" src="https://user-images.githubusercontent.com/85587898/233221274-fa75422e-a17b-4733-9b89-0303660985b2.png">

- These are the orginal ACF plots and Time series in which we detrend the difference in order to make it stationary.

<img width="299" alt="image" src="https://user-images.githubusercontent.com/85587898/233222764-ef623b0a-961b-4ef3-9156-258e20f20b7d.png"> <img width="298" alt="image" src="https://user-images.githubusercontent.com/85587898/233222788-62cad079-cb4e-4f67-b106-f282dcaeb029.png"> <img width="297" alt="image" src="https://user-images.githubusercontent.com/85587898/233222797-b21dae0a-0b0f-4c73-888b-21e3017b4eeb.png">

<img width="277" alt="image" src="https://user-images.githubusercontent.com/85587898/233222837-ef62fe5d-6b0d-45aa-b261-b863a653fcab.png"> <img width="227" alt="image" src="https://user-images.githubusercontent.com/85587898/233222846-eed0f9d5-48d1-4687-9dea-fca1dbb4c7c1.png">  <img width="239" alt="Screenshot 2023-04-19 at 7 58 28 PM" src="https://user-images.githubusercontent.com/85587898/233224095-d146df9c-e4cf-4584-b960-b25c23df091a.png">


## ARIMA MODELS

<img width="442" alt="JPM_Arima" src="https://user-images.githubusercontent.com/85587898/233223276-81b3fc21-7fb1-45cb-9ed1-ffdbfccfc50f.png"> <img width="464" alt="GOOGLE_Arima" src="https://user-images.githubusercontent.com/85587898/233223287-6b3b5edb-76be-4722-838b-e1da489b43ab.png"> <img width="464" alt="TELSA_Arima" src="https://user-images.githubusercontent.com/85587898/233223479-a5233eb3-4832-4d06-b2e8-fc7eb8d636b0.png">



- ### Metric Summary 

<img width="868" alt="Screenshot 2023-04-19 at 7 36 09 PM" src="https://user-images.githubusercontent.com/85587898/233223548-17a5acb8-56c4-4ee3-a80c-2712281a018f.png">





## RANDOM FOREST MODELS

<img width="454" alt="JPM_RF" src="https://user-images.githubusercontent.com/85587898/233223785-47bde396-482f-4cb1-8f45-e0308943c004.png"> <img width="420" alt="TESLA_RF" src="https://user-images.githubusercontent.com/85587898/233223790-6dc001a6-d650-49bc-a7ed-8f19f487ac30.png"> 
<img width="456" alt="GOOGLE_RF" src="https://user-images.githubusercontent.com/85587898/233223801-1d3429bc-1247-4317-91be-255e121ed5dc.png">



- ## Metric Summary

<img width="824" alt="Screenshot 2023-04-19 at 7 37 09 PM" src="https://user-images.githubusercontent.com/85587898/233223767-f48ea518-9c97-46be-8fef-ea76306ce2a2.png">





   __1. Results__:
   
   
   - Based on RMSE,
ARIMA model outperforms in terms of prediction performance
Why? ARIMA models are designed specifically for time series data, on the other hand, Random Forest models are a more general-purpose machine learning algorithm.


<img width="429" alt="summary" src="https://user-images.githubusercontent.com/85587898/233222425-dca2275c-f92d-4382-9e9d-03089863ad0a.png">




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
