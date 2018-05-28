library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    ## DATA PREP!
    data <- read.csv("../data/Crime_Data.csv", stringsAsFactors = FALSE)

    # Remove UID, not particularly useful for our purposes.
    data <- data %>% select(-Report.Number)

    # Isolate and Remove Outliers (general data cleanup).
    beat_outliers <- data %>%
        group_by(Beat) %>%
        summarize(n = n()) %>%
        filter(n <= 10) %>%
        pull(Beat)
    data <- data %>%
        filter(!(Beat %in% beat_outliers))

    precinct_outliers <- data %>%
        group_by(Precinct) %>%
        summarize(n = n()) %>%
        filter(n <= 10) %>%
        pull(Precinct)
    data <- data %>%
        filter(!(Precinct %in% precinct_outliers))

    # Null Transforms
    data <- data %>%
        mutate(Sector = ifelse(Sector == "", "UNKNOWN", Sector),
               Beat = ifelse(Beat == "", "UNKNOWN", Beat))

    # Date/Time Transforms
    data$Occured.Date = mdy(data$Occured.Date)
    data$Occured.Time = hours(floor(data$Occured.Time / 100)) +
        minutes(data$Occured.Time %% 100)
    data$Reported.Date = mdy(data$Reported.Date)
    data$Reported.Time = hours(floor(data$Reported.Time / 100)) +
        minutes(data$Reported.Time %% 100)

    ## Data Prep Complete!
})
