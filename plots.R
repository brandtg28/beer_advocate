#original BA density plot by type
b = ggplot(data = ny_beer, aes(x = ba_score))
zoom = coord_cartesian(xlim = c(2, 5))
b + geom_density(aes(color = style)) + zoom

#BA+ density plot by type
p = ggplot(data = ny_beer, aes(x = ba_plus))
zoom = coord_cartesian(xlim = c(50,135))
p + geom_density(aes(color = style)) + zoom

#anything with a BA+ above 100 would be an above average beer vs alike styles. 
#Our converstion from original BA rating tightens our group

