library(quantmod)
library(PerformanceAnalytics)
library(zoo)

start_date = Sys.Date() - 365*2
end_date = Sys.Date()

symbols <- c("AAPL", "MSFT", "GOOG")
getSymbols(symbols, src= "yahoo", from = start_date, to = end_date)

prices <- na.omit(merge(Ad(AAPL),Ad(MSFT),Ad(GOOG)))
colnames(prices) <- symbols

returns <- na.omit(Return.calculate(prices, method = "log"))

vol_30d <- rollapply(returns, width = 30, FUN = function(x) apply(x,2,sd), by.column = 2, align = "right") * sqrt(252)
colnames(vol_30d) <- paste0(symbols, "_volatility")

class(vol_30d)

PerformanceAnalytics::chart.TimeSeries(vol_30d,legend.loc = "topright", main = "voloatility comparision of three stocks", col = c("red", "blue","green"))

plot.zoo(
  vol_30d,
  plot.type = "single",
  col = c("red", "blue", "green"),
  ylab = "volatility",
  main = " 30 day volatility"
)
legend("topright", legend = colnames(vol_30d), col = c("red","blue","green""), lty = 1)
)

mean_vol <- apply(vol_30d, 2, mean, na.rm = TRUE)
print(mean_vol)

