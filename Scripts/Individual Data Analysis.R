indData <- indData %>%                               # modify current data
  group_by(position, game_year) %>%                  # group by player and year
  mutate_at(vars(-name, -position, -game_year),      # unselect character vars
                                                     # and year var
            funs(z = ((. - mean(.)) / sd(.)))) %>%   # create z-score for all 
                                                     # variables

  ungroup() %>%                                      # ungroup
  select(name, position, game_year, contains("z"))%>%# restrict vars to zscores
  group_by(name, position, game_year) %>%            # group by name and position
  summarise_at(vars(-name, -position), funs(sumZ = sum)) %>% #sum zscores across years
  select(name, game_year, position, contains("sumZ"))# restrict vars to zscore sums

rb <- indData %>%                                    # create dataset for RBs
  select(name, game_year, position, contains("rush")) %>% # select rushing vars
  filter(position == "RB") %>%                       # filter to RB position
  mutate(rush_fumbles_z_sumZ = rush_fumbles_z_sumZ * -1) %>% # reverse score fumbles
  ungroup() %>%
  group_by(name, game_year) %>%                      # group by player name
  summarise(totalZ = rush_att_z_sumZ + rush_yds_z_sumZ + rush_avg_z_sumZ + 
              rush_tds_z_sumZ + 
              ifelse(is.na(rush_fumbles_z_sumZ), 0, rush_fumbles_z_sumZ)) %>%   # create total z score index
  arrange(desc(totalZ))                              # arrange with greatest valuea at top

qb <- indData %>%                                    # create dataset for QBs
  select(name, position, game_year, contains("pass"), contains("int"), 
         contains("sck"), contains("rate")) %>%      # select passing vars
  filter(position == "QB") %>%                       # filter down to QB position
  mutate(int_z_sumZ = int_z_sumZ * -1,
         sck_z_sumZ = sck_z_sumZ * -1,
         pass_fumbles_z_sumZ = pass_fumbles_z_sumZ * -1) %>%   # reverse score ints, scks, and fumbles
  ungroup() %>%
  group_by(name, game_year) %>%                      # group by player name
  summarise(totalZ = pass_att_z_sumZ + pass_yds_z_sumZ + pass_tds_z_sumZ +
              int_z_sumZ + sck_z_sumZ + 
              ifelse(is.na(pass_fumbles_z_sumZ), 0, pass_fumbles_z_sumZ) + 
              rate_z_sumZ) %>%                       # create total z score index
  arrange(desc(totalZ))                              # arrange with greatest valuea at top

wr_te <- indData %>%                                 # create dataset for WRs and TEs
  select(name, position, game_year, contains("rec")) %>% # select receiving vars
  filter(position == "WR/TE") %>%                    # filter down to wr/te
  ungroup() %>%
  group_by(name, game_year) %>%                      # group by player name
  mutate(rec_fumbles_z_sumZ = rec_fumbles_z_sumZ * -1) %>%  # reverse score fumbles
  summarise(totalZ = rec_z_sumZ + rec_yds_z_sumZ + rec_avg_z_sumZ + 
              rec_tds_z_sumZ + 
              ifelse(is.na(rec_fumbles_z_sumZ), 0, rec_fumbles_z_sumZ)) %>% # create total z score index
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

