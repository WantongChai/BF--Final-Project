library(shiny)
library(ggplot2)
library(dplyr)

shinyUI(navbarPage(
  "Crime Data",
  tabPanel(
    "Overview",
    h1("Crime Dataset"),
    p(
      "The dataset we used is ", 
      a(href="https://data.seattle.gov/Public-Safety/Crime-Data/4fs7-3vj5","Crime Data"),
      "from ", a(href = "https://data.seattle.gov", "City of Seattle Open Data Portal"),
      "."
    ),
    h1("Audience"),
    p("While anybody could get some insights from this report, our intended audience",
      "for this report consists of those who are interested in investing in real estate,",
      "moving to a new neighborhood or starting businesses, such as running a restaurant.",
      "They could get a broad overview of the frequencies of the crimes happened lately in",
      "each neighborhood, which would be able to help them make decisions."
    )
  ),
  # Create a tab panel for population on state level
  tabPanel(
    "Map",
    mainPanel()
  ),

  # Create a tabPanel to show your a bar plot for each county's population
  tabPanel(
    "Chart1",
    mainPanel()
  ),
  tabPanel(
    "Chart2",
    mainPanel()
  )
))
