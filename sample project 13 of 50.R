library(quantmod)
library(ggplot2)
library(forecast)
library(tseries)

getSymbols("AAPL", from = "2023-01-01", to = "2023-12-31")

symbols <- dailyReturn(Ad(AAPL), type = "log")

acf(symbols, main ="ACF of AAPL log returns")
pacf(symbols, main ="PACF of AAPL log returns")

Box.test(symbols, lag = 20, type = "Ljung-Box")

ggAcf(symbols, main = "ACF of AAPL returns" )
ggPacf(symbols, main="PACF of AAPL returns")