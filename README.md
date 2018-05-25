# BF--Final-Project

## Project Description
### Overview

The dataset we will be working on is [Crime Data](https://data.seattle.gov/Public-Safety/Crime-Data/4fs7-3vj5) from [City of Seattle Open Data portal](https://data.seattle.gov). It records the crimes reported by the public to the Seattle Police Department or detected by officers in different neighborhoods in Seattle over the years. It contains the details about each incident such as occured date, crime subcategory, offence description, occured location, etc.


### Audience

While anybody could get some insights from this report, our intended audience for this report consists of those who are interested in investing in real estate, moving to a new neighborhood or starting businesses, such as running a restaurant. They could get a broad overview of the frequencies of the crimes happened lately in each neighborhood, which would be able to help them make decisions.

### Questions

Some questions this project could answer inculdes:

- What are the frequencies of crimes happened in each neighborhood?
- Which neighborhood has the least crimes happened in the past?
- Which neighborhood has the most crimes happened in the past?
- What is the most common crime incidents (crime subcategory)?

## Technical Description

We'll be working with CSV data downloaded from [here](https://data.seattle.gov/Public-Safety/Crime-Data/4fs7-3vj5)
about crimes in Seattle. This dataset contains a few complications that could make it somewhat difficult to get in a form that is usable. For example, there are two columns in the dataset that list times in an unusual formatthat will need some work to convert into a usable format. We'll likely be using the lubridate library to workwith date and time values, and either plotly or ggplot2 to develop graphs and plots for the final report.

This dataset is also extremely extensive. It contains about 474,000 records across 11 variables, which will -if nothing else - take a significant amount of time and processing power to work with. This is both a benefitand a detriment, as we have a lot of data to gain insight from, but we'll need to be careful to work efficiently,especially for any possible interactive elements.

The data is also has a number of variables that are based on categories, so tidyr might be helpful to flatten the data according to the tidyverse's recommmendations, as well as dplyr for data grouping and summaries. If we decide to geocode the neighborhood names and present any maps, the google maps API may also be useful for its geocoding capabilities. 
