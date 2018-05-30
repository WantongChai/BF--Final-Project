library(plotly)
library(dplyr)

# Make a Pie chart
#
# Pie chart showing the number of incidents by the crime subcategory,
# depending on the user choice of violent level
make_pie <- function(dataset, level, precinct) {
  working_data <- dataset
  if(level != "ALL") {
     working_data <- filter(working_data, violent_level == level)
  }
  if(precinct != "ALL") {
     working_data <- filter(working_data, Precinct == precinct)
  }
  working_data <- working_data %>%
    group_by(Crime.Subcategory) %>%
    summarize(total_incidents = sum(n))
  test <- plot_ly(working_data,
    labels = ~ Crime.Subcategory, values = ~ total_incidents, type = "pie",
    textposition = "inside",
    textinfo = "label+percent",
    insidetextfont = list(color = "#FFFFFF"),
    hoverinfo = "text",
    text = ~ paste(Crime.Subcategory, ": ", total_incidents),
    marker = list(
      colors = colors,
      line = list(color = "#FFFFFF", width = 1)
    ),
    showlegend = FALSE
  ) %>%
    layout(
      title = "Crime by Category",
      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
    )
  test
}
