library(plotly)
library(dplyr)

# Make a bar chart
#
# Bar chart showing the number of incidents by the crime subcategory,
# depending on the user choice of violent level
make_bar <- function(dataset, level){
  working_data <- dataset
  working_data <- working_data %>%
    filter(violent_level == level)
  working_data <- working_data %>%
    group_by(Crime.Subcategory) %>%
    summarize(total_incidents = sum (n))
  working_data$text <- paste("Total", working_data$total_incidents)
  bar_chart <- plot_ly(data = working_data, x = ~Crime.Subcategory, y = ~total_incidents,
               type = "bar", text = working_data$text) %>%
    layout(title = "Number of Crime by Category",
           xaxis = list(title = "Category"),
           yaxis = list(title = ""))
  bar_chart
}