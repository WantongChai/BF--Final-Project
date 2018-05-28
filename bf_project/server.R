library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)

source("mapping.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    ## Crime Data Prep
    crime_data <- read.csv("../data/Crime_Data.csv", stringsAsFactors = FALSE)
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

    ## Crime Data Wrangling - Graphable Data!
    apply_impact_and_violence_maps <- function(data) {
        data %>% mutate(
            violent_level =
                ifelse(
                    Crime.Subcategory %in% violence_map$violent,
                    "VIOLENT",
                    "NONVIOLENT"
                ),
            impact_level =
                ifelse(
                    Crime.Subcategory %in% impact_map$low_impact,
                    "LOW",
                    ifelse(
                        Crime.Subcategory %in% impact_map$medium_impact,
                        "MEDIUM",
                        "HIGH"
                    )
                )
        )
    }

    crime_data_month_summarize <- crime_data %>%
        mutate(month_index = 12 * (year(Occured.Date) - 2010) + month(Occured.Date)) %>%
        group_by(month_index, Crime.Subcategory) %>%
        summarize(n = n()) %>%
        filter(Crime.Subcategory != "") %>%
        mutate(month_in_year = ifelse(month_index %% 12 == 0,
                                      12,
                                      month_index %% 12)) %>%
        apply_impact_and_violence_maps()

    crime_data_precinct_summarize <- crime_data %>%
        group_by(Precinct, Crime.Subcategory) %>%
        summarize(n = n()) %>%
        filter(Crime.Subcategory != "") %>%
        apply_impact_and_violence_maps()

    ## Crime Data Wrangling Complete

    ## Funding Data Prep
    funding_data <-
        read.csv("../data/matching_funds.csv", stringsAsFactors = FALSE)
    # Beware, this weird code sorts into precincts.
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
