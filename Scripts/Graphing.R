# graph individuals' season data
rb %>%
  #group_by(name) %>%
  ggplot(aes(x = game_year, y = totalZ)) + 
  geom_jitter(show.legend = TRUE, alpha = 5/9, color = "green") + 
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

qb %>%
  ggplot(aes(x = game_year, y = totalZ)) + 
  geom_jitter(show.legend = TRUE, alpha = 5/9, color = "green") + 
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

wr_te %>%
  ggplot(aes(x = game_year, y = totalZ)) + 
  geom_jitter(show.legend = TRUE, alpha = 5/9, color = "green") + 
  theme(panel.background = element_rect(fill = 'black', colour = 'black'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# graph individuals' career data
indCareerGraph <- indData %>%
  

# graph team data
teamGraph <- teamData %>%
  ()