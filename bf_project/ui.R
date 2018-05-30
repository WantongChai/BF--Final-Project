# Load relevant libraries
library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)

# Create Interface Page
shinyUI(
  navbarPage(
    "Seattle Crime",
    tabPanel(
      "Overview",
      h1("Summary & Sources"),
      p(
        "The dataset which these graphs are created from are based on ",
        a(href = "https://data.seattle.gov/Public-Safety/Crime-Data/4fs7-3vj5", "this crime data set"),
        "from ", a(href = "https://data.seattle.gov", "City of Seattle Open Data Portal"),
        "."
      ),
      p(
        "Overall this report aims to compare the statistics of the crimes that
        occur in the Seattle area, as well as explore possible assocations 
        between crime and lower socioeconomic neighborhoods."
        ),
      h1("Audience & Intended Takeaways"),
      p("Our intended audience for this report consists of those who are interested 
        in investing in real estate, moving to a new neighborhood or starting 
        businesses in the general Seattle area. Investors can get a broad overview 
        of the frequencies of the crimes, as well as type of crimes commonly found
        in each neighborhood, aiding in critical decisions. However, our targeted 
        audience should not limit the message conveyed by this report, as the
        correlation often found together with crime and inequities is a not an 
        isolated issue unique to Seattle.")
    ),
    tabPanel(
      "Clarifications & Definitions",
      h1("Organization of Threat Levels"),
      p("While working with the data set, we decided to categorize and label the 
        featured type of crimes based on how violet or severe they were. Below is a
        key and loose definitions to describe how we categorized our 'levels' of 
        crime:",
        tags$ul(
          tags$li(strong("Violent crime"), " = other individuals are generally 
                  physically injured or affected by the crime"), 
          tags$li(strong("Non-violent crime"), " = other individuals are generally", 
                  tags$em("NOT"), "physically injured or affected by the crime"), 
          p(),
          tags$li(strong("Low Impact"), " = generally no harm to individuals or 
                minimal detrimental affects"),
          tags$li(strong("Medium Impact"), " = enough potential danger to victims 
                to be life-threatening"),
          tags$li(strong("High Impact"), " = large enough of a threat to actually
                harm victims and has detrimental consequences & or affects"))
      ),
      h1("Match Funding"),
      p("While we were unable to directly find a data set that collectively 
        had incomes of Seattle families and or something similar, we were able
        to find a data set that listed the amount of Match Funding given to
        certain Seattle neighborhoods. Match Funding is method for the City of 
        Seattle to improve the social conditions of less fortunate neighborhoods.
        As quoted by the ", 
        a(href = "http://www.seattle.gov/neighborhoods/programs-and-services/neighborhood-matching-fund", "official website"),
        ":", tags$blockquote("The Neighborhood Matching Fund (NMF) program was 
                             created in 1988 to provide matching dollars 
                             for neighborhood improvement, organizing, or 
                             projects that are developed and implemented by 
                             community members."), 
        "We interpreted this as a way to assess areas with lower socioeconomic
        status, as the need for government funding hints to lower immediate
        community wealth.")
    ),
    tabPanel(
      "Violent vs. Non-Violent",
      sidebarLayout(
        sidebarPanel(
          selectInput("select", label = h3("Select Violent Level"),
                      choices = list("Non-Violent" = "NONVIOLENT",
                                     "Violent" = "VIOLENT"), 
                      selected = "NONVIOLENT")
        ),
        mainPanel(
          plotlyOutput("bar")
        )
      )
    ),
    tabPanel(
      "Montly Crime Trends",
      sidebarLayout(
        strong("Description"),
        p(
         "put desc here" 
        ),
        strong("Conclusion"),
        p(
          "put conclusion here"
        )
      ),
      mainPanel(
        plotlyOutput("crime_month")
      )
    ),
    tabPanel(
      "Crimes vs. Matching Funds",
      sidebarLayout(
        sidebarPanel(
          strong("Description"),
          p(
            "The visualization compares the occurrence of crime in Northern, 
              Southern, Southwestern, Eastern, and Western areas of Seattle to
              the total amount of match funding given to the same areas."
          ),
          strong("Conclusion"),
          p("We assumed that crime might be a consequence of under-funded social
            programs in areas, so we compared the total crimes happened in each 
            precinct with the total amount of awarded neighborhood matching 
            funds. However, interestingly, there is no obvious relationship 
            shown based on the plot."),
          p(strong("Note:"),tags$em("The Neighborhood Matching Fund (NMF) program was 
            created in 1988 to provide matching dollars for neighborhood 
            improvement, organizing, or projects that sare developed and 
            implemented by community members."))
        ),
      mainPanel(
        plotlyOutput("scatter")
        )
      )
    )
  )
)
