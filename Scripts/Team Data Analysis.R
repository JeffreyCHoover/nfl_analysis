teamData <- teamData %>%                             # modify current data
  group_by(game_year) %>%                      # group by player and year
  mutate_at(vars(-team, -game_year),                 # unselect character vars
                                                     # and year var
            funs(z = ((. - mean(., na.rm = TRUE)) / sd(., na.rm = TRUE)))) %>%   # create z-score for all 
                                                     # variables 

ungroup() %>%                                        # ungroup
  select(team, game_year, contains("z")) %>%         # restrict vars to zscores
  group_by(team, game_year) %>%                      # group by name and position
  summarise_at(vars(-team, -game_year), funs(sumZ = sum(., na.rm = TRUE))) %>%    #sum zscores across years
  mutate(rush_fumbles_z_sumZ = rush_fumbles_z_sumZ * -1,
         rec_fumbles_z_sumZ = rec_fumbles_z_sumZ * -1,
         int_z_sumZ = int_z_sumZ * -1,
         sck_z_sumZ = sck_z_sumZ * -1,
         pass_fumbles_z_sumZ = pass_fumbles_z_sumZ * -1) %>% # reverse score fumbles, sacks, and ints
  ungroup() %>%
  group_by(team, game_year) %>%
  summarise(totalZ = rush_att_z_sumZ + rush_yds_z_sumZ + rush_avg_z_sumZ + 
              rush_tds_z_sumZ + rush_fumbles_z_sumZ + rec_z_sumZ + 
              rec_yds_z_sumZ + rec_avg_z_sumZ + rec_tds_z_sumZ +
              rec_fumbles_z_sumZ + pass_att_z_sumZ + pass_yds_z_sumZ + 
              pass_tds_z_sumZ + int_z_sumZ + sck_z_sumZ + 
              pass_fumbles_z_sumZ) %>%               # create total z score index
  arrange(desc(totalZ))                              # sort in descending order

teamData                                             # print teamData