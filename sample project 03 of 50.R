#calculate daily & log returns of a stock 
library(quantmod)
#get stock data
getSymbols("AAPL",src="yahoo", from ="2024-01-01", to = "2024-12-31")
#extract adjusted close price
price <- Ad(AAPL)
#calc daily returns & log returns
daily_returns = dailyReturn(price, type = "arithmetic")
log_returns = dailyReturn(price, type = "log")
#view & plot the results
head(daily_returns)
head(log_returns)
plot(log_returns, main ="log prices of AAPL", col="blue")
