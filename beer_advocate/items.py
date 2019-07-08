import scrapy

class BeerAdvocateItem(scrapy.Item):
    brewery = scrapy.Field()
    city = scrapy.Field()
    beer_name = scrapy.Field()
    style = scrapy.Field()
    abv = scrapy.Field()
    num_ratings = scrapy.Field()
    ba_score = scrapy.Field()
