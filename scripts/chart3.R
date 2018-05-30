library(plotly)
library(dplyr)



## Given impack level and violent level, draws a bar chart of crimes
## happened over precinct
precinct_bar <- function(dataset1, vlevel, ilevel) {
  p_data <- dataset1
  p_data <- p_data %>%
    filter(violent_level == vlevel) %>%
    filter(impact_level == ilevel)
  validate(
     need(nrow(p_data) != 0,
          "There is no data available for the combination of selected settings.")
  )
  p_data <- p_data %>%
    group_by(Precinct) %>%
    summarize(total_n = sum(n))
  p_data$text <- paste("Total:", p_data$total_n)
  p_chart <- plot_ly(
    data = p_data, x = ~ Precinct, y = ~ total_n,
    type = "bar", text = p_data$text
  ) %>%
    layout(
      title = "Number of Crime by Category",
      xaxis = list(title = "Category"),
      yaxis = list(title = "")
    )
  p_chart
}
