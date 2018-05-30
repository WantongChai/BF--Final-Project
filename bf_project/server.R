library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(lubridate)

source("mapping.R")
source("../scripts/chart2.R")
source("../scripts/chart1.R")
source("../scripts/crime_month.R")
source("../scripts/chart3.R")

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
            Precinct != "" &
            Sector != "UNKNOWN" &
            Sector != "" &
            Beat != "UNKNOWN" &
            Beat != "" &
            Neighborhood != "UNKNOWN" &
            Neighborhood != ""
      )
   # Date/Time Transforms
   crime_data$Occured.Date <- mdy(crime_data$Occured.Date)
   crime_data$Occured.Time <-
      hours(floor(crime_data$Occured.Time / 100)) +
      minutes(crime_data$Occured.Time %% 100)
   crime_data$Reported.Date <- mdy(crime_data$Reported.Date)
   crime_data$Reported.Time <-
      hours(floor(crime_data$Reported.Time / 100)) +
      minutes(crime_data$Reported.Time %% 100)
   # Subset Data to Dates of Interest
   crime_data <- crime_data %>%
      filter(Occured.Date >= mdy("1-1-2010"))
   ## Crime Data Prep Complete!
   ##
   ##
   ##
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
   # Summarize and tally crime data by month for each subcategory.
   crime_data_month_summarize_base <- crime_data %>%
      mutate(month_index = 12 * (year(Occured.Date) - 2010) + month(Occured.Date)) %>%
      group_by(month_index, Crime.Subcategory) %>%
      summarize(n = n()) %>%
      filter(Crime.Subcategory != "") %>%
      mutate(month_in_year = ifelse(month_index %% 12 == 0,
                                    12,
                                    month_index %% 12)) %>%
      apply_impact_and_violence_maps()
   # Store a separate base object that won't be modified beyond this point.
   # That way, all graphs can be made with crime_data_month_summarize,
   # which can easily be filtered for specific date ranges, etc, but easily
   # reverted by copying it over from crime_data_month_summarize_base again.
   crime_data_month_summarize <- crime_data_month_summarize_base
   # Summarize and tally crime data by precinct for each subcategory.
   crime_data_precinct_summarize_base <- crime_data %>%
      group_by(Precinct, Crime.Subcategory) %>%
      summarize(n = n()) %>%
      filter(Crime.Subcategory != "") %>%
      apply_impact_and_violence_maps()
   # Same base/working structure as in crime_data_month_summarize.
   crime_data_precinct_summarize <- crime_data_precinct_summarize_base
   ## Crime Data Wrangling Complete
   ##
   ##
   ##
   ## Funding Data Prep
   funding_data <-
      read.csv("../data/matching_funds.csv", stringsAsFactors = FALSE)
   # Filter only funding that matches our target timeframe.
   # Add a precinct column that allows comparison with the crime dataset.
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
   
   ## Summarize information for the second chart
   funding <- funding_data %>%
     group_by(precinct) %>%
     summarise(total_award = sum(Awarded.Amount))
   funding <- setNames(funding, c("Precinct", "total_awarded"))
   
   crime_summary <- crime_data_precinct_summarize %>%
     group_by(Precinct) %>%
     summarise(total_crimes = sum(n))
   
   compare <- left_join(funding, crime_summary, by = "Precinct")
   
   output$scatter <- renderPlotly({
     return(build_scatter(compare))
   })
   
   output$crime_month <- renderPlotly({
     return(build_line(crime_data_month_summarize_base, input$type))
   })
   
   output$pie <- renderPlotly({
     return(make_pie(crime_data_month_summarize, input$select))
   })
   output$precinct_bar <- renderPlotly({
     return(precinct_bar(crime_data_precinct_summarize, input$selectv,input$selecti))
   })
})

