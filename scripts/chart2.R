library(plotly)
library(stringr)
library(dplyr)

## Build a scatter plot for the comparison between fundings 
## and crimes in each precinct.

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
      title = "Matching Funds vs. Crimes in Seattle Areas",
      xaxis = list(title = "Total Crimes"),
      yaxis = list(title = "Total Funds Awarded")
    )
  p
}
