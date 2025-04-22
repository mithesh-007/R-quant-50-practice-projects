library(quantmod) #for stock data
library(dplyr) #for data manipulation
library(PerformanceAnalytics) #for financial summary stats

getSymbols("AAPL", src = "yahoo", from = "2024-01-01", to = "2024-12-31")
head(AAPL)
#convert to data frame & clean
stock_data <- data.frame(Date = index(AAPL), coredata(AAPL))
colnames(stock_data) <- c("date", "open", "High", "Low", "close", "Volume", "Adjusted")
head(stock_data)
stock_data = stock_data %>%
  arrange(date) %>%
  mutate(Daily_return = (Adjusted / lag(Adjusted))-1)

                
head(stock_data, 10)

summary(stock_data)

install.packages("e1071")
library(e1071)
mean(stock_data$Daily_return, na.rm=TRUE)
sd(stock_data$Daily_return, na.rm=TRUE)
median(stock_data$Daily_return, na.rm=TRUE)
min(stock_data$Daily_return, na.rm=TRUE)
max(stock_data$Daily_return, na.rm=TRUE)
kurtosis(stock_data$Daily_return, na.rm=TRUE)
skewness(stock_data$Daily_return, na.rm=TRUE)

return_xts <- na.omit(ClCl(AAPL))
table.Stats(return_xts)