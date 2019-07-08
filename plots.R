#initial intuition was that IPA & Stouts dominate ratings, and was reinforced by the boxplot below
g = ggplot(data = ny_beer, aes(x = reorder(style,ba_score), y = ba_score))
g + geom_boxplot(aes(color=style)) + ggtitle(label = "Box Plot by Type")


#freqpoly to see # of reviews by type of beer
g = ggplot(data = ny_beer, aes(x = ba_score))
zoom = coord_cartesian(xlim = c(2, 5))
g + geom_freqpoly(aes(color = style)) + zoom + ggtitle(label = "# of Reviews")


#original BA density plot by type
g = ggplot(data = ny_beer, aes(x = ba_score))
zoom = coord_cartesian(xlim = c(2, 5))
g + geom_density(aes(color = style)) + zoom + ggtitle(label = "Density Plot by Type")


#BA+ density plot by type
g = ggplot(data = ny_beer, aes(x = ba_plus))
zoom = coord_cartesian(xlim = c(50,135))
g + geom_density(aes(color = style)) + zoom + 
  geom_vline(aes(xintercept=100)) + ggtitle(label = "Adj. Density Plot by Type")
#anything with a BA+ above 100 would be an above average beer vs alike styles. 
#Our converstion from original BA rating tightens our group


#orig BA scoring
g = ggplot(ny_top100, aes(style))
g+geom_bar(aes(fill=style))+ggtitle(label = "BA Top 100 in NYS")

#adjusted BA+
g = ggplot(ny_top100_plus, aes(style))
g+geom_bar(aes(fill=style))+ggtitle(label = "New Top 100 in NYS")


#table of top100 NY beers
View(ny_top100)
View(ny_top100_plus)


#is stronger better?
g = ggplot(ny_beer, aes(x = abv, y = ba_score))
g + geom_point() + ggtitle(label = "booze vs. score") + geom_smooth()