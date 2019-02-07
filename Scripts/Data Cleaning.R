# specify which packages are needed
needed_packages <- c("tidyverse", "dplyr", "ggplot2", "readr", "stringr",
                     "hrbrthemes", "colorblindr", "cowplot")
# attempt to load packages
load_packages <- function(x) {
  # if packages aren't already installed, install them
  if (!(x %in% installed.packages())) {
    install.packages(x)
  }
  suppressPackageStartupMessages(require(x, character.only = TRUE))
}
vapply(needed_packages, load_packages, logical(1))

#load data in better
data <- read_csv("data/nfl_2010-2017.csv") %>%
  select(-X1)

#condense individual data into yearly stats
indData <- data %>%
  select(-game_week) %>%   # remove irrelevant vars
  group_by(name, game_year, team) %>%              # group by player and year 
  summarise_at(.vars = vars(-name, -team, -game_year, -position), 
               .funs = funs(sum), na.rm = TRUE) %>% # sum all statistics and remove NAs
  ungroup()                                  # ungroup

#add position variable back into individual data
indData <- data %>%
  select(name, position, team) %>%
  left_join(indData, by = c("name", "team"))

#condense team data into yearly stats
teamData <- data %>%
  filter(!is.na(team)) %>%                          # remove entries w/ NA team 
  select(-name, -position, -game_week, -rate) %>%   # remove irrelavant vars
  group_by(team, game_year) %>%                     # group by team and year
  summarise_all(funs(sum), na.rm = TRUE) %>%        # sum all statistics and remove NAs
  ungroup()                                         # ungroup