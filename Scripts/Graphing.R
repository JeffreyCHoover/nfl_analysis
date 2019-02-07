# graph individuals' season data
rb %>%
  #group_by(name) %>%
  ggplot(aes(x = game_year, y = totalZ)) + 
  geom_jitter(alpha = 5/9, color = "green") +
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  ggtitle("RB Performance by Season") +
  labs(x = "Year", y = "Total Z Score")

qb %>%
  ggplot(aes(x = game_year, y = totalZ)) + 
  geom_jitter(alpha = 5/9, color = "green") + 
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  ggtitle("QB Performance by Season") +
  labs(x = "Year", y = "Total Z Score")

wr_te %>%
  ggplot(aes(x = game_year, y = totalZ)) + 
  geom_jitter(alpha = 5/9, color = "green") + 
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  ggtitle("WR/TE Back Performance by Season") +
  labs(x = "Year", y = "Total Z Score")

# graph team data
teamData %>%
  ggplot(aes(x = game_year, y = totalZ, color = team)) + 
  geom_jitter(alpha = 5/9)  + 
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  ggtitle("Team Performance by Season") +
  labs(x = "Year", y = "Total Z Score")