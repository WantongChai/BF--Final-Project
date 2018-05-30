library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)

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
        crime:",
        tags$ul(
          tags$li(strong("Violent crime"), " = other individuals are generally 
                  physically injured or affected by the crime"), 
          tags$li(strong("Non-violent crime"), " = other individuals are generally", 
                  tags$em("NOT"), "physically injured or affected by the crime"), 
          tags$li("Third list item")
      ),
      hr(),
      p(
        tags$li(strong("Low Impact"), " = generally no harm to individuals or 
                minimal detrimental affects"),
        tags$li(strong("Medium Impact"), " = enough potential danger to victims 
                to be life-threatening"),
        tags$li(strong("High Impact"), " = large enough of a threat to actually
                harm victims and has detrimental consequences & or affects")
      )
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
      "Crimes vs. Matching Funds",
      sidebarLayout(
        sidebarPanel(
          strong("Conclusion"),
          p("We assumed that crime might be a consequence of under-funded social
            programs in areas, so we compared the total crimes happened in each precinct 
            with the total amount of awarded neighborhood matching funds. However, there is 
            no obvious relationship shown based on the plot."),
          hr(),
          p(strong("Note:"),"The Neighborhood Matching Fund (NMF) program was created in 1988 
            to provide matching dollars for neighborhood improvement, organizing, or projects
            that are developed and implemented by community members."),
          hr(),
          p("Source on", a(href = "https://data.seattle.gov/Community/City-Of-Seattle-Neighborhood-Matching-Funds/pr2n-4pn6",
                           "City of Seattle Open Data portal"))
        ),
      mainPanel(plotlyOutput("scatter"))
      )
    )
  )
)
