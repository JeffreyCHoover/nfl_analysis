teamData <- teamData %>%                             # modify current data
  group_by(position, game_year) %>%                  # group by player and year
  mutate_at(vars(-name, -position, -game_year),      # unselect character vars
                                                     # and year var
            funs(z = ((. - mean(.)) / sd(.))))       # create z-score for all 
                                                     # variables 