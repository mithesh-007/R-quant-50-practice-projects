library(quantmod)
library(ggplot2)
library(dplyr)
library(tidyr)

tickers <- c("AAPL", "GOOGL", "BLK")
getSymbols(tickers, src="yahoo", from_date="2010-01-01", to_date=Sys.Date())

#data preparation
stock_prices <- NULL
for(ticker in tickers) {
  #extract adjusted close price & add symbol column
  stock_data <- get(ticker)
prices <- data.frame (
  Date = as.Date(index(stock_data)),
  Symbol = ticker,
  price = as.numeric(Ad(stock_data))
)
#add back with previous data
stock_prices <- rbind(stock_prices, prices)
}

#now plot with cleaned data
ggplot (stock_prices, aes(x = Date, y = price, color=Symbol)) +
  geom_line() +
  labs(title = "multiple stock comparision",
       y="prices",
       x = "date")+
  theme_minimal()
       
