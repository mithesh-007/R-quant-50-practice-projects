library(quantmod)
library(PerformanceAnalytics)
library(TTR)

symbols <- c("AAPL","MSFT","GOOG")
getSymbols(symbols, src="yahoo", from = "2024-01-01", to = "2024-12-31")

prices <- merge(Ad(AAPL), Ad(MSFT), Ad(GOOG))
colnames(prices) <- symbols

vol_AAPL <- runSD(prices$AAPL, n=30)
vol_MSFT <- runSD(prices$MSFT, n=30)
vol_GOOG <- runSD(prices$GOOG, n=30)

vol_price <- na.omit(merge(vol_AAPL,vol_MSFT,vol_GOOG))
colnames(vol_price) <- symbols

plot.zoo(vol_price,
         col = c("red","blue","green"),
         lwd = 2,
         main = "volatility of 3 assets",
         ylab = "SD of price")

#---------------------------------------------

ATR_AAPL <- ATR(HLC(AAPL), n=14)[, "atr"]
ATR_MSFT <- ATR(HLC(MSFT), n=14)[, "atr"]
ATR_GOOG <- ATR(HLC(GOOG), n = 14)[, "atr"]
ATR_price <- na.omit(merge(ATR_AAPL,ATR_AAPL,ATR_GOOG))
colnames(ATR_price) <- symbols

plot.zoo(ATR_price,
         col = c("steelblue","tomato","darkgreen"),
         lwd = 2,
         main = "volatility based on ATR",
         ylab = "ATR(USD")
  