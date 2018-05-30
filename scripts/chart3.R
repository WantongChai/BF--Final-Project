library(plotly)
library(dplyr)



## Given impack level and violent level, draw a bar chart of crimes
## happened over each precinct.
precinct_bar <- function(dataset1, vlevel, ilevel) {
  p_data <- dataset1
  if(vlevel != "ALL") {
     p_data <- filter(p_data, violent_level == vlevel)
  }
  if(ilevel != "ALL") {
     p_data <- filter(p_data, impact_level == ilevel)
  }
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
      title = "Number of Crimes by Precinct",
      xaxis = list(title = "Precinct"),
      yaxis = list(title = "Total Crimes Committed Since 2010")
    )
  p_chart
}
