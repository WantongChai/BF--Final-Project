library(plotly)
library(stringr)
library(dplyr)

funding <- funding_data %>%
  group_by(precinct) %>%
  summarise(total_award = sum(Awarded.Amount))
funding <- setNames(funding, c("Precinct", "total_awarded"))

crime_summary <- crime_data_precinct_summarize %>%
  group_by(Precinct) %>%
  summarise(total_crimes = sum(n))

compare <- left_join(funding, crime_summary, by = "Precinct")

build_scatter <- function(dataset) {
  p <- plot_ly(
    data = dataset, x = ~ total_crimes, y = ~ total_awarded,
    type = "scatter",
    mode = "markers",
    marker = list(size = 10),
    color = ~ Precinct,
    text = ~ paste(
      "Total Funds:", total_awarded,
      "<br>Total Crimes:", total_crimes
    )
  ) %>%
    layout(
      title = "Matching Funds vs. Crimes",
      xaxis = list(title = "Total Crimes"),
      yaxis = list(title = "Total Funds Awarded")
    )
  p
}