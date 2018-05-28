library(shiny)
library(ggplot2)
library(dplyr)

shinyUI(
  navbarPage(
    "Crime Data",
    tabPanel(
      "Overview",
      h1("Crime Dataset"),
      p(
        "The dataset which these graphs are created from are based on ",
        a(href = "https://data.seattle.gov/Public-Safety/Crime-Data/4fs7-3vj5", "this crime data set"),
        "from ", a(href = "https://data.seattle.gov", "City of Seattle Open Data Portal"),
        "."
      ),
      h1("Audience & Intended Takeaways"),
      p("Our intended audience for this report consists of those who are interested 
        in investing in real estate, moving to a new neighborhood or starting 
        businesses in the general Seattle area. Investors can get a broad overview 
        of the frequencies of the crimes, as well as type of crimes commonly found
        in each neighborhood, aiding in critical decisions. However, our targeted 
        audience should not limit the message conveyed by this report, as the
        correlation often found together with crime and inequities is a not an 
        isolated issue unique to Seattle."),
      h1("Organization of Threat Levels"),
      p("Organization of Threat Levels"),
      p("While working with the data set, we decided to categorize label the 
        featured type of crimes based on how violet or severe they were. Below is a
        key and loose definitions to describe how we categorized our 'levels' of 
        crime:
        - Violent crime = other individuals are generally physically injured or 
        affected by the crime
        - Non-violent crime = other individuals are NOT generally physically 
        injured or affected by the crime
        
        - Low impact = generally no harm to individuals or minimal detrimental 
        affects
        - Medium impact = potential danger to victim enough to be life-threatening 
        - High impact = large levels of harm to victims and has lasting detrimental
        affects")
    ),
    tabPanel(
      "Chart 1",
      mainPanel()
    ),
    tabPanel(
      "Chart 2",
      mainPanel()
    )
  )
)
