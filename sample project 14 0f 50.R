library(quantmod)
library(ggplot2)
library(forecast)
library(dplyr)
library(zoo)

getSymbols("AAPL", src= "yahoo", from = "2024-01-01", to = "2024-12-31")
data <- Cl(AAPL)

plot (data, main = "plotting the prices of AAPL", col = "blue")

daily_returns <- dailyReturn(data, type="log")
plot(daily_returns, main = "AAPL daily returns", col="green")

z_scores <- (daily_returns - mean(daily_returns, na.rm = TRUE)) / sd(daily_returns, na.rm = TRUE)

outliers <- abs(z_scores) > 3

#extract dates and values at which returns are outlined
outlier_dates <- index(daily_returns)[outliers]
outlier_values <- daily_returns[outliers]

#plot with outliers highlighted

df <- data.frame(date = index(daily_returns), log_return = as.numeric(coredata(daily_returns)), is_outlier = as.logical(outliers) )
str(df)
ggplot(df, aes(x = date, y = log_return)) +
  geom_line(color = "darkgreen") +
  geom_point(data = subset(df, is_outlier), aes(x = date, y = log_return), color = "red", size = 5 ) +
  labs(title = "returns outliers for AAPL", x="date", y = "log returns") +
  theme_minimal()

outlier_result <- tsoutliers(ts(daily_returns, frequency = 252))
print(outlier_result)

