from scrapy import Spider, Request
from beer_advocate.items import BeerAdvocateItem
import re

class BeerAdvocateSpider(Spider):
    name = 'ba_spider'
    allowed_urls = ['https://www.beeradvocate.com/']
    start_urls = ['https://www.beeradvocate.com/place/list/?start=0&&c_id=US&s_id=NY&brewery=Y&sort=name']
    
    
    def parse(self, response):
        result_urls = ['https://www.beeradvocate.com/place/list/?start={}&&c_id=US&s_id=NY&brewery=Y&sort=name'.format(x) for x in range(0,460,20)]
        for result_url in result_urls:
            yield Request(url=result_url, callback=self.parse_result_page)



    def parse_result_page(self, response):
        brewery_urls = ['//div[@id="ba-content"]/table/tr[{}]/td[1]/a/@href'.format(i) for i in range(4,43,2)]
        print(len(brewery_urls))
        print('=' * 50)
        print(brewery_urls)
        for brewery_url in brewery_urls:
            print(response.xpath(brewery_url).extract_first())
            yield Request(url='https://www.beeradvocate.com' + response.xpath(brewery_url).extract_first(), callback=self.parse_table_page)



    def parse_table_page(self, response):
        rows = response.xpath('//div[@style="font-size:1em;"]/table[2]/tbody/tr')
        for row in rows:
            brewery = response.xpath('//div[@class="titleBar"]/h1/text()').extract_first()
            city = response.xpath('//div[@id="info_box"]/a[1]/text()').extract_first()      
            beer_name = row.xpath('./td[1]/a/b/text()').extract_first()
            style = row.xpath('./td[2]/a/text()').extract_first()
            abv = row.xpath('./td[3]/span/text()').extract_first()
            num_ratings = row.xpath('./td[4]/b/text()').extract_first()
            ba_score = row.xpath('./td[5]/b/text()').extract_first()

            item = BeerAdvocateItem()
            item['brewery'] = brewery
            item['city'] = city
            item['beer_name'] = beer_name
            item['style'] = style
            item['abv'] = abv
            item['num_ratings'] = num_ratings
            item['ba_score'] = ba_score
            yield item 