install.packages("plotly")
library(plotly)

data(mtcars)

p <- plot_ly(data = mtcars,
            x = ~wt,
            y = ~mpg,
            type = 'scatter',
            mode = 'markers',
            color = ~as.factor(cyl),
            text = ~paste("cars :", rownames(mtcars)))

p <- p %>% layout(title = "MPG vs Weight",
                  xaxis = list(title = "weight(1000 lbs)"),
                  yaxis = list(title = "Miles per Gallon"))

p

