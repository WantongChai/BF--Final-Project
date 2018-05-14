# BF--Final-Project

## Technical Description

We'll be working with CSV data downloaded from [here](https://data.seattle.gov/Public-Safety/Crime-Data/4fs7-3vj5)
about crimes in Seattle. This dataset contains a few complications that could make it somewhat difficult to get
in a form that is usable. For example, there are two columns in the dataset that list times in an unusual format
that will need some work to convert into a usable format. We'll likely be using the lubridate library to work
with date and time values, and either plotly or ggplot2 to develop graphs and plots for the final report.

This dataset is also extremely extensive. It contains about 474,000 records across 11 variables, which will -
if nothing else - take a significant amount of time and processing power to work with. This is both a benefit
and a detriment, as we have a lot of data to gain insight from, but we'll need to be careful to work efficiently,
especially for any possible interactive elements.

The data is also has a number of variables that are based on categories, so tidyr might be helpful to flatten
the data according to the tidyverse's recommmendations, as well as dplyr for data grouping and summaries. If 
we decide to geocode the neighborhood names and present any maps, the google maps API may also be useful
for its geocoding capabilities. 
