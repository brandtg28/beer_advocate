#initial intuition was that IPA & Stouts dominate ratings, and was reinforced by the boxplot below
p = ggplot(data = ny_beer, aes(x = reorder(style,ba_score), y = ba_score)) + 
  geom_boxplot(aes(color=style)) + ggtitle(label = "Box Plot by Type") + 
  xlab("Style") + ylab("BA Score")
ggplotly(p)


#freqpoly to see # of reviews by type of beer
p = ggplot(data = ny_beer, aes(x = ba_score)) + zoom + coord_cartesian(xlim = c(2, 5)) +
  geom_freqpoly(aes(color = style)) + ggtitle(label = "# of Reviews") + xlab("BA Score") + ylab("Count")
ggplotly(p)

#original BA density plot by type
zoom = coord_cartesian(xlim = c(2, 5))
p = ggplot(data = ny_beer, aes(x = ba_score)) + zoom + geom_density(aes(color = style)) +
  ggtitle(label = "Density Plot by Type") + xlab("BA Score") +ylab("Density")


#BA+ density plot by type

zoom = coord_cartesian(xlim = c(50,130))
p = ggplot(data = ny_beer, aes(x = ba_plus)) + geom_density(aes(color = style)) + zoom + 
  geom_vline(aes(xintercept=100)) + ggtitle(label = "Adj. Density Plot by Type") + xlab("BA+") +ylab("Density")
ggplotly(p)
#anything with a BA+ above 100 would be an above average beer vs alike styles. 
#Our converstion from original BA rating tightens our group


#orig BA scoring
p = ggplot(ny_top100, aes(style)) +geom_bar(aes(fill=style)) + 
  ggtitle(label = "BA Top 100 in NYS") + xlab("Style") + ylab("Count")
ggplotly(p)

#adjusted BA+
p = ggplot(ny_top100_plus, aes(style)) + geom_bar(aes(fill=style)) +
  ggtitle(label = "New Top 100 in NYS") + xlab("Style") + ylab("Count")


#table of top100 NY beers
View(ny_top100)
View(ny_top100_plus)


#is stronger better?
p = ggplot(ny_beer, aes(x = abv, y = ba_score)) +
  geom_point() + ggtitle(label = "booze vs. score") + geom_smooth()
