library(plotly)
library(dplyr)


build_line <- function(dataset, crime) {
  selected_crime <- dataset %>%
    filter(Crime.Subcategory == crime) %>%
    group_by(month_in_year) %>%
    summarize(n = sum(n))

  p <- plot_ly(data = selected_crime,
               x = ~month_in_year,
               y = ~n,
               type = 'scatter',
               mode = 'lines'
               ) %>%
    layout(title = paste0(crime, " Frequencies Across the Year"),
           xaxis = list(title = "Month (By Order in Year)"),
           yaxis = list (title = "Number of Cases"))
}
