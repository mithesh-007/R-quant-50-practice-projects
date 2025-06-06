library(quantmod)
library(ggplot2)
library(corrplot)
library(reshape2)

symbols <- c("NVDA","GOOG","MSFT","AAPL","META")

getSymbols(symbols,src= "yahoo", from = Sys.Date() - 180, auto.assign = TRUE)

prices <- do.call(merge, lapply(symbols, function(x) Ad(get(x))))
colnames(prices) <- symbols
head(prices)

returns <- na.omit(ROC(prices, type = "discrete"))
head(returns)

cor_matrix <- cor(returns)
print(cor_matrix)

corrplot(cor_matrix , method = "color",
         type = "upper",
         addCoef.col = "black",
         tl.col = "black",
         col = colorRampPalette(c("red","white","green"))(200),
         title = "corelation heatmap",
         mar = c(0,0,1,0))
                  
#custom heatmap

cor_melt <- melt(cor_matrix)

ggplot(data = cor_melt, aes(Var1, Var2, fill = value))+
       geom_tile(color = "white")+
         scale_fill_gradient(low = "red", high = "green")+
         theme_minimal() +
         labs(title = "corelation heatmap", x ="", y = "", fill = "corr")+
         theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1) )
                  
                  
                  
                  
              
