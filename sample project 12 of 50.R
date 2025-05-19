library(quantmod)
library(ggplot2)
library(dplyr)

getSymbols("AAPL", from="2020-01-01", to = Sys.Date(), auto.assign = TRUE)
stock_data <- AAPL[, "AAPL.Adjusted"]

window_size <- 20
rolling_mean <- rollapply(stock_data, width = window_size, FUN = mean, fill = NA, align = "right")
rolling_volatility <- rollapply(stock_data, width = window_size, FUN = sd, fill = NA, align = "right")

data_combined <- data.frame(
  Date = index(stock_data),
  Price = as.numeric(stock_data),
  RollingMean = as.numeric(rolling_mean),
  RollingVolatility = as.numeric(rolling_volatility)
)

str(data_combined)

ggplot(data_combined, aes(x = Date, y = Price)) +
  geom_line(color = "red", size = 1, alpha = 0.7) +
labs(title = "stock price ",
     y = "price", x = "date") +
  theme_minimal()

ggplot(data_combined, aes(x = Date, y = RollingMean)) +
  geom_line(color = "blue", size = 1) +
  labs(title = "stock price of rolling mean(20 days)",
       x = "date", y = "mean") +
  theme_minimal()
  

ggplot(data_combined, aes(x = Date, y = RollingVolatility)) +
  geom_line(color = "purple", size = 1) +
  labs(title = "rolling volatility(20 days)",
       x = "date", y = "volatility") +
  theme_minimal()