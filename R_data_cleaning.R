library(dplyr)
library(ggplot2)
library(tidyverse)

#read csv, filter # of ratings > 10
ny_beer = read.csv('ba_all_ny.csv', stringsAsFactors = FALSE)
ny_beer$num_ratings = as.numeric(ny_beer$num_ratings)
ny_beer$abv = as.numeric(ny_beer$abv)
ny_beer = filter(ny_beer, num_ratings >10)

#cleaning the 100 unique types
ny_beer$style[grepl("IPA",ny_beer$style)]="IPA"
ny_beer$style[grepl("Lager",ny_beer$style)]="Lager"
ny_beer$style[grepl("Stout",ny_beer$style)]="Stout"
ny_beer$style[grepl("Porter",ny_beer$style)]="Porter"
ny_beer$style[grepl("Ale",ny_beer$style)]="Ale"
ny_beer$style[grepl("German",ny_beer$style)]="German"
ny_beer$style[grepl("Belgian",ny_beer$style)]="Belgian"
ny_beer$style[grepl("Pils",ny_beer$style)]="Pilsner"
ny_beer$style[grepl("Gose",ny_beer$style)]="Gose"
ny_beer$style[grepl("Pumpkin",ny_beer$style)]="Pumpkin"
ny_beer$style = ifelse(ny_beer$style != 'IPA' &
         ny_beer$style != 'Lager' &
         ny_beer$style != 'Stout' &
         ny_beer$style != 'Porter' &
         ny_beer$style != 'Ale' &
         ny_beer$style != 'German' &
         ny_beer$style != 'Belgian' &
         ny_beer$style != 'Pilsner' &
         ny_beer$style != 'Gose' &
         ny_beer$style != 'Pumpkin', yes = 'Other', no = ny_beer$style)

unique(ny_beer$style)
View(ny_beer)


avg_by_style = ny_beer %>% 
  group_by(., style) %>% 
  summarise(style_average=mean(ba_score))
View(avg_by_style)

ny_beer = ny_beer %>%
  inner_join(., avg_by_style, by='style') %>% 
  mutate(., ba_plus = ba_score/style_average * 100)
View(ny_beer)                

ny_top100 = ny_beer %>% 
  arrange(., desc(ba_score)) %>% 
  head(100)


ny_top100_plus = ny_beer %>% 
  arrange(., desc(ba_plus)) %>% 
  head(100)
View(ny_top100_plus)
  

