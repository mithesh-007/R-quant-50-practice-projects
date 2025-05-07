library(quantmod)
library(ggplot2)
library(reshape2)

getSymbols("AAPL", src="yahoo", from = Sys.Date()-365, to = Sys.Date())

volume <- Vo(AAPL)

volume_ma <- SMA(volume, n=20)

volume_data <- cbind(volume, volume_ma)
colnames(volume_data) <- c("Volume", "MA")

df <- data.frame(Date = index(volume_data), coredata(volume_data))
df_melt <- melt(df, id.vars = "Date")

ggplot(df_melt, aes(x = Date, y = value, color=variable)) +
  geom_line() +
  geom_bar(data = subset(df_melt, variable == "Volume"),
           aes(x=Date, y=value), stat = "identity", fill="lightblue", alpha = 0.5) +
  labs(title = "aapl volume and 20 MA", y="Volume") +
  scale_color_manual(values = c("volume" = "blue", "MA20"= "red" ))
