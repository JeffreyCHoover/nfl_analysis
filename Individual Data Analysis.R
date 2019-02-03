zscore <- function(x) {
  z <- (x - paste0(x, "", "_average", 
                   collapse = NULL)) / paste(x, "", "_stdv", collapse = NULL)
  return(z)
}

indData <- indData %>%
  group_by(position, game_year) %>%
  mutate_at(vars(-name, -position, -game_year), 
            funs(average = mean, 
                 stdv = sd)) %>%
  mutate_at(vars(!str_detect(., "_average") & !str_detect(., "_stdv")), 
            funs(z_score = zscore))

#####ZSCORE NOT WORKING###########