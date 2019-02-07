indData <- indData %>%                               # modify current data
  group_by(position, game_year) %>%                  # group by player and year
  mutate_at(vars(-name, -position, 
                 -game_year, -team),                 # unselect character vars
                                                     # and year var
            funs(z = ((. - mean(.)) / sd(.)))) %>%   # create z-score for all 
                                                     # variables

  ungroup() %>%                                      # ungroup
  select(name, position, game_year, contains("z"))   # restrict vars to zscores

rb <- indData %>%                                    # create dataset for RBs
  select(name, game_year, position, contains("rush")) %>% # select rushing vars
  filter(position == "RB") %>%                       # filter to RB position
  select(-position) %>%
  mutate(rush_fumbles_z = rush_fumbles_z * -1) %>% # reverse score fumbles
  ungroup() %>%
  group_by(name, game_year) %>%                      # group by player name
  mutate(totalZ = rush_att_z + rush_yds_z + rush_avg_z + rush_tds_z + 
              ifelse(is.na(rush_fumbles_z), 0, rush_fumbles_z)) %>%   # create total z score index
  select(name, game_year, totalZ) %>%
  distinct() %>%
  arrange(desc(totalZ))                              # arrange with greatest valuea at top

qb <- indData %>%                                    # create dataset for QBs
  select(name, position, game_year, contains("pass"), contains("int"), 
         contains("sck"), contains("rate")) %>%      # select passing vars
  filter(position == "QB") %>%                       # filter down to QB position
  mutate(int_z_sumZ = int_z * -1,
         sck_z_sumZ = sck_z * -1,
         pass_fumbles_z = pass_fumbles_z * -1) %>%   # reverse score ints, scks, and fumbles
  ungroup() %>%
  group_by(name, game_year) %>%                      # group by player name
  mutate(totalZ = pass_att_z + pass_yds_z + pass_tds_z + int_z + sck_z + 
              ifelse(is.na(pass_fumbles_z), 0, pass_fumbles_z) + rate_z) %>%  # create total z score index
  select(name, game_year, totalZ) %>%
  distinct() %>%
  arrange(desc(totalZ))                              # arrange with greatest valuea at top

wr_te <- indData %>%                                 # create dataset for WRs and TEs
  select(name, position, game_year, contains("rec")) %>% # select receiving vars
  filter(position == "WR/TE") %>%                    # filter down to wr/te
  ungroup() %>%
  group_by(name, game_year) %>%                      # group by player name
  mutate(rec_fumbles_z = rec_fumbles_z * -1) %>%  # reverse score fumbles
  mutate(totalZ = rec_z + rec_yds_z + rec_avg_z + rec_tds_z + 
              ifelse(is.na(rec_fumbles_z), 0, rec_fumbles_z)) %>% # create total z score index
  select(name, game_year, totalZ) %>%
  distinct() %>%
  arrange(desc(totalZ))                              # arrange with greatest valuea at top

rbCareer <- rb %>%                                   # specify rb dataset
  ungroup() %>%                                      # remove previous groupings
  group_by(name) %>%                                 # group by name
  summarise(careerZ = sum(totalZ, na.rm = TRUE)) %>% # sum all zscores by person
  arrange(desc(careerZ))                             # arrange in a descending order
  
qbCareer <- qb %>%                                   # specify qb data
  ungroup() %>%                                      # remove previous groupings
  group_by(name) %>%                                 # group by name
  summarise(careerZ = sum(totalZ, na.rm = TRUE)) %>% # sum all zscores by person
  arrange(desc(careerZ))                             # arrange in a descending order

wr_teCareer <- wr_te %>%                             # specify wr_te data
  ungroup() %>%                                      # remove previous groupings
  group_by(name) %>%                                 # group by name
  summarise(careerZ = sum(totalZ, na.rm = TRUE)) %>% # sum all zscores by person
  arrange(desc(careerZ))                             # arrange in a descending order

rb                                                   # print rb

rbCareer                                             # print rb career data

qb                                                   # print qb

qbCareer                                             # print qb career data

wr_te                                                # print wr_te

wr_teCareer                                          # print wr_te career data

