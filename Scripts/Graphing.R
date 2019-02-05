# graph individuals' season data
rbIndSeasonGraph <- rb %>%
  group_by(name) %>%
  geom_jitter(mapping = aes(y = totalZ), stat = "identity", position = "jitter",
              na.rm = TRUE, show.legend = TRUE, alpha = 1/3)

# graph individuals' career data
indCareerGraph <- indData %>%
  

# graph team data
teamGraph <- teamData %>%
  ()