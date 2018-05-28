library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    ## Crime Data Prep
    crime_data <-
        read.csv("../data/Crime_Data.csv", stringsAsFactors = FALSE)
    # Remove UID, not particularly useful for our purposes.
    crime_data <- crime_data %>% select(-Report.Number)
    # Isolate and Remove Outliers (general data cleanup).
    beat_outliers <- crime_data %>%
        group_by(Beat) %>%
        summarize(n = n()) %>%
        filter(n <= 10) %>%
        pull(Beat)
    crime_data <- crime_data %>%
        filter(!(Beat %in% beat_outliers))
    crime_data <- crime_data %>%
        filter(
            Precinct != "UNKNOWN" &
                Sector != "" &
                Beat != "" &
                Neighborhood != "UNKNOWN" &
                Precinct != ""
        )
    # Date/Time Transforms
    crime_data$Occured.Date = mdy(crime_data$Occured.Date)
    crime_data$Occured.Time = hours(floor(crime_data$Occured.Time / 100)) +
        minutes(crime_data$Occured.Time %% 100)
    crime_data$Reported.Date = mdy(crime_data$Reported.Date)
    crime_data$Reported.Time = hours(floor(crime_data$Reported.Time / 100)) +
        minutes(crime_data$Reported.Time %% 100)
    # Subset Data to Dates of Interest
    crime_data <- crime_data %>%
        filter(Occured.Date >= mdy("1-1-2010"))
    ## Crime Data Prep Complete!

    ## Funding Data Prep
    funding_data <-
        read.csv("../data/matching_funds.csv", stringsAsFactors = FALSE)
    # Mapping Funding Districts to Crime Precincts
    district_map = list(
        west = c("Downtown", "Magnolia/QA", "Magnolia / Queen Anne"),
        southwest = c("Southwest", "Delridge"),
        east = c("East"),
        north = c("Northeast", "Ballard", "Lake Union", "Northwest", "North"),
        south = c("Southeast", "Greater Duwamish")
    )
    # Beware, this code sorts into precincts.
    funding_data <- funding_data %>%
        filter(Award.Year >= 2010) %>%
        mutate(precinct =
                   ifelse(
                       Neighborhood.District %in% district_map$west,
                       "WEST",
                       ifelse(
                           Neighborhood.District %in% district_map$southwest,
                           "SOUTHWEST",
                           ifelse(
                               Neighborhood.District %in% district_map$east,
                               "EAST",
                               ifelse(
                                   Neighborhood.District %in% district_map$north,
                                   "NORTH",
                                   ifelse(
                                       Neighborhood.District %in% district_map$south,
                                       "SOUTH",
                                       "UNKNOWN"
                                   )
                               )
                           )
                       )
                   )) %>%
        filter(precinct != "UNKNOWN")
})
