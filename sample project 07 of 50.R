library(tidyverse)
library(quantmod)
getSymbols(c("AAPL", "GOOG", "MSFT"), src = "yahoo", from = 2024-01-01, to = Sys.Date())

aapl_df <- data.frame(Date = index(AAPL), coredata(AAPL))
goog_df <- data.frame(Date = index(GOOG), coredata(GOOG))
msft_df <- data.frame(Date = index(MSFT), coredata(MSFT))

colnames(aapl_df)[-1] <- paste0("AAPL_", colnames(aapl_df)[-1])
colnames(goog_df)[-1] <- paste0("GOOG", colnames(goog_df)[-1])
colnames(msft_df)[-1] <- paste0("MSFT", colnames(msft_df)[-1])

merge_df <- aapl_df  %>% 
  inner_join(goog_df, by="Date") %>%
  inner_join(msft_df, by = "Date")


head(merge_df)
