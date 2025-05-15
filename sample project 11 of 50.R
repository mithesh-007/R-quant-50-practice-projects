library(quantmod)
library(forecast)
library(tseries)
#download stock data
getSymbols("^NSEI", src="yahoo", from = "2020-01-01", to = Sys.Date())
head(NSEI)
#convert to monthly closing prices
nifty_monthly <- to.monthly(NSEI, indexAt = "lastof", OHLC = FALSE)
nifty_close <- Cl(nifty_monthly)
#display the prices
str(nifty_close)
head(nifty_close)
#converting the xts objects to numerics ensuring for plots
nifty_vector <- as.numeric(nifty_close)
#convert to time series object
nifty_ts <- ts(na.omit(nifty_vector), start = c(2020,1), frequency = 12)
plot(nifty_ts, main = "nifty 50 monthly closing prices", ylab = "prices", col = "blue")

is.ts(nifty_ts) && is.numeric(nifty_ts)
#convert the time series objects to decomposing with STL(seasonal trend decomposition using loess) decompossion method
nifty_stl <- stl(nifty_ts, s.window = "periodic")
plot(nifty_stl)

#the plot generated contains plots of seasonal, trends , reminder components


