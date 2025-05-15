library(ggplot2)
library(quantmod)
library(readr)
getSymbols("nvda", src="yahoo", from="2023-01-01", to="2025-03-01")
stock_data <- data.frame(date = index(NVDA), coredata(NVDA))
ncol(stock_data)
colnames(stock_data) <- c("date", "open", "high", "low", "close", "volume", "adjusted" )
ggplot(stock_data, aes(x=date))+ geom_line(aes(y=open, color="open price"))+ geom_line(aes(y=close, color="close price"))+ 
labs(title = "NVDA opening & closing price",
      x = "date",
      y = "price(USD)", 
      color = "legend")+
  theme_minimal()
