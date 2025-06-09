library(quantmod)
library(ggplot2)
library(lubridate)
library(dplyr)
library(scales)

getSymbols("AAPL", src="yahoo", from = "2024-01-01", to="2024-12-31", auto.assign = TRUE)
AAPL_prices <- AAPL[, "AAPL.Adjusted"]

aapl_returns <- dailyReturn(AAPL_prices)
df <- data.frame(date = index(aapl_returns), return = coredata(aapl_returns))

df <- df%>% mutate(
  year = year(date),
  month = month(date , label = TRUE, abbr = TRUE),
  weekday = wday(date, label = TRUE, abbr = TRUE),
  week = isoweek(date),
  daily = day(date)

 )

names(df)

ggplot(df, aes(x= weekday, y=week, fill = daily.returns))+
  geom_tile(color = "white")+
  facet_wrap(~month, ncol = 3)+
  scale_fill_gradient2(low = "red",
                       mid = "white",
                      high = "green",
                      midpoint = 0,
                      labels = percent_format(accuracy = 1))+
  labs (title = "calender heatmap for AAPL", fill = "Return")+
  theme_minimal()
theme(
  axis.title = element_blank(),
  panel.grid = element_blank(),
  strip_text = element_text(face = "bold"),
  axix.text.x = element_text(angle = 0)
)
