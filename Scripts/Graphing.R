# graph individuals' season data
rb %>%
  ggplot(aes(x = game_year, y = totalZ)) +                                   # set vars for axis
  geom_jitter(alpha = 5/9, color = "green") +                                # set alpha and color
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),   # set background to black
        panel.grid.major = element_blank(),                                  # remove major grid lines
        panel.grid.minor = element_blank()) +                                # remove minor grid lines
  ggtitle("RB Performance by Season") +                                      # set graph title
  labs(x = "Year", y = "Total Z Score")                                      # set axes labels

qb %>%
  ggplot(aes(x = game_year, y = totalZ)) +                                   # set vars for axis
  geom_jitter(alpha = 5/9, color = "green") +                                # set alpha and color
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),   # set background to black
        panel.grid.major = element_blank(),                                  # remove major grid lines
        panel.grid.minor = element_blank()) +                                # remove minor grid lines
  ggtitle("QB Performance by Season") +                                      # set graph title
  labs(x = "Year", y = "Total Z Score")                                      # set axes labels

wr_te %>%
  ggplot(aes(x = game_year, y = totalZ)) +                                   # set vars for axis
  geom_jitter(alpha = 5/9, color = "green") +                                # set alpha and color
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),   # set background to black
        panel.grid.major = element_blank(),                                  # remove major grid lines
        panel.grid.minor = element_blank()) +                                # remove minor grid lines
  ggtitle("WR/TE Performance by Season") +                                   # set graph title
  labs(x = "Year", y = "Total Z Score")                                      # set axes labels

# graph team data
teamData %>%
  ggplot(aes(x = game_year, y = totalZ, color = team)) +                     # set vars for axis
  geom_jitter(alpha = 5/9) +                                                 # set alpha
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),   # set background to black
        panel.grid.major = element_blank(),                                  # remove major grid lines
        panel.grid.minor = element_blank()) +                                # remove minor grid lines
  ggtitle("Team Performance by Season") +                                    # set graph title
  labs(x = "Year", y = "Total Z Score")                                      # set axes labels