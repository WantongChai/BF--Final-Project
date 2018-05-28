# Crime Sorting
violence_map = list(
    violent = c(
        "WEAPON",
        "AGGRAVATED ASSAULT",
        "ROBBERY-STREET",
        "SEX OFFENSE-OTHER",
        "ROBBERY-COMMERCIAL",
        "AGGRAVATED ASSAULT-DV",
        "ARSON",
        "ROBBERY-RESIDENTIAL",
        "RAPE",
        "HOMICIDE"
    ),
    nonviolent = c(
        "CAR PROWL",
        "NARCOTIC",
        "FAMILY OFFENSE-NONVIOLENT",
        "BURGLARY-RESIDENTIAL",
        "MOTOR VEHICLE THEFT",
        "THEFT-ALL OTHER",
        "BURGLARY-COMMERCIAL",
        "THEFT-SHOPLIFT",
        "THEFT-BUILDING",
        "TRESPASS",
        "DUI",
        "THEFT-BICYCLE",
        "PROSTITUTION",
        "LIQUOR LAW VIOLATION",
        "DISORDERLY CONDUCT",
        "BURGLARY-RESIDENTIAL-SECURE PARKING",
        "PORNOGRAPHY",
        "GAMBLE",
        "LOITERING",
        "BURGLARY-COMMERCIAL-SECURE PARKING"
    )
)

impact_map = list(
    low_impact = c(
        "CAR PROWL",
        "FAMILY OFFENSE-NONVIOLENT",
        "BURGLARY-RESIDENTIAL",
        "MOTOR VEHICLE THEFT",
        "THEFT-ALL OTHER",
        "BURGLARY-COMMERCIAL",
        "THEFT-SHOPLIFT",
        "THEFT-BUILDING",
        "TRESPASS",
        "THEFT-BICYCLE",
        "PROSTITUTION",
        "LIQUOR LAW VIOLATION",
        "DISORDERLY CONDUCT",
        "BURGLARY-RESIDENTIAL-SECURE PARKING",
        "PORNOGRAPHY",
        "GAMBLE",
        "LOITERING",
        "BURGLARY-COMMERCIAL-SECURE PARKING"
    ),
    medium_impact = c(
        "NARCOTIC",
        "WEAPON",
        "ROBBERY-STREET",
        "DUI",
        "ROBBERY-COMMERCIAL",
        "ROBBERY-RESIDENTIAL"
    ),
    high_impact = c(
        "AGGRAVATED ASSAULT",
        "SEX OFFENSE-OTHER",
        "AGGRAVATED ASSAULT-DV",
        "ARSON",
        "RAPE",
        "HOMICIDE"
    )
)

# Mapping Funding Districts to Crime Precincts
district_map = list(
    west = c("Downtown", "Magnolia/QA", "Magnolia / Queen Anne"),
    southwest = c("Southwest", "Delridge"),
    east = c("East"),
    north = c("Northeast", "Ballard", "Lake Union", "Northwest", "North"),
    south = c("Southeast", "Greater Duwamish")
)
