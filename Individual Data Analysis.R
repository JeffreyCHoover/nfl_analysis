indData <- indData %>%                               # modify current data
  group_by(position, game_year) %>%                  # group by player and year
  mutate_at(vars(-name, -position, -game_year),      # unselect character vars
                                                     # and year var
            funs(z = ((. - mean(.)) / sd(.)))) %>%   # create z-score for all 
                                                     # variables

  ungroup() %>%                                      # ungroup
  select(name, position, contains("z")) %>%          # restrict vars to zscores
  group_by(name, position) %>%                       # group by name and position
  summarise_at(vars(-name, -position), funs(sumZ = sum)) %>% #sum zscores across years
  select(name, position, contains("sumZ"))           # restrict vars to zscore sums

rb <- indData %>%                                    # create dataset for RBs
  filter(position == "RB") %>%                       # filter to RB position
  select(name, contains("rush")) %>%                 # select rushing vars
  mutate(rush_fumbles_z_sumZ = rush_fumbles_z_sumZ * -1) %>% # reverse score fumbles
  group_by(name) %>%                                 # group by player name
  summarise(totalZ = rush_att_z_sumZ + rush_yds_z_sumZ + rush_avg_z_sumZ + 
              rush_tds_z_sumZ + rush_fumbles_z_sumZ) %>%   # create total z score index
  arrange(desc(totalZ))                              # arrange with greatest valuea at top

qb <- indData %>%                                    # create dataset for QBs
  filter(position == "QB") %>%                       # filter down to QB position
  select(name, contains("pass"), contains("int"), contains("sck"), 
         contains("rate")) %>%                       # select passing vars
  mutate(int_z_sumZ = int_z_sumZ * -1,
         sck_z_sumZ = sck_z_sumZ * -1,
         pass_fumbles_z_sumZ = pass_fumbles_z_sumZ * -1) %>%   # reverse score ints, scks, and fumbles
  group_by(name) %>%                                 # group by player name
  summarise(totalZ = pass_att_z_sumZ + pass_yds_z_sumZ + pass_tds_z_sumZ +
              int_z_sumZ + sck_z_sumZ + pass_fumbles_z_sumZ + rate_z_sumZ) %>%  # create total z score index
  arrange(desc(totalZ))                              # arrange with greatest valuea at top

wr_te <- indData %>%                                 # create dataset for WRs and TEs
  filter(position == "WR/TE") %>%                    # filter down to wr/te
  select(name, contains("rec")) %>%                  # select receiving vars
  group_by(name) %>%                                 # group by player name
  mutate(rec_fumbles_z_sumZ = rec_fumbles_z_sumZ * -1) %>%  # reverse score fumbles
  summarise(totalZ = rec_z_sumZ + rec_yds_z_sumZ + rec_avg_z_sumZ + 
              rec_tds_z_sumZ + rec_fumbles_z_sumZ) %>% # create total z score index
  arrange(desc(totalZ))                              # arrange with greatest valuea at top

rb <- as.tibble(rb)                                  # convert rb to a tibble
rb                                                   # print rb

qb <- as.tibble(qb)                                  # convert qb to a tibble
qb                                                   # print qb

wr_te <- as.tibble(wr_te)                            # convert wr_te to a tibble
wr_te                                                # print wr_te