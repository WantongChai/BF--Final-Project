library(plotly)
library(dplyr)


build_line <- function(dataset, crime) {
  selected_crime <- filter(dataset, Crime.Subcategory == crime) %>% 
    select(Crime.Subcategory, n, month_in_year)
  
  p <- plot_ly(data = dataset, 
               x = ~month_in_year, 
               y = ~n, 
               type = 'scatter', 
               mode = 'lines'
               ) %>%
    layout(title = "Crimes Frequencies Across the Year",
           xaxis = list(title = "Month (By Order in Year)"),
           yaxis = list (title = "Number of Cases"))
}