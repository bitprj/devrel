# Why Web Scraping? 

Everyone wants to make money in the society that we live in today. More and more college students want to become engineers, computer scientists, and doctors as it secures a stable income despite its difficulties. However, what if I told you that you do not have to do this to become successful? As an investor myself, I decided to learn about stocks at a very young age. When I first started, I would try to look for the perfect brokerage. One of the important observations that I noticed was that many brokerages were late on updating the price of stocks, which would eventually lead you to losing money. Obviously, I don't want that to happen to you. So look no further! I’ve created a real time stock price scraper using Python that allows you to keep up with the current price of the stock of your interest.

## Installation of Important Modules

Before we begin, there are a few things we need to install. Navigate to your command line and type the following individually. 

```console    
pip install requests
pip install beautifulsoup
```

With that installed on your computer, we can then import the modules necessary for this program to work. 

``` python
import bs4
import requests
from bs4 import BeautifulSoup 
```

Keeping it concise, the bs4 module is a powerful library that allows us to access web pages, APIs, post to forms, and much more operations. The requests module allows you to send HTTP requests. Lastly, the Beautiful Soup (BS4) module sounds like a silly module but in reality it is a parsing library useful for extracting data from HTML / XML documents.

## Implementation of Program

For the website that I decided to web scrape, I chose a simple one *https://finance.yahoo.com/quote/FB?p=FB*. With this url, I was able to use the requests module to access all of the response data. 

```python
url = requests.get('https://finance.yahoo.com/quote/FB?p=FB')
``` 

If you navigate to the link, you can see that we are interested in the Facebook stock.

Currently, the price of one stock of Facebook is 234.91. This may or may not be different for you so it is perfectly fine if it is!


Now we have to utilize the BS4 as well as the BeautifulSoup module, which allows us to extract data from HTML. 

```python
soup = bs4.BeautifulSoup(url.text, features="html.parser")
```


We're not done yet! 

As you may know, a website consists of a plethora of information. From a programmers' perspective, if you tried to understand each and every function contained within the HTML/CSS tag, it would be virtually impossible. However, we can grab just the information that we need, which is the stock price (234.91 when blog was created).

```python
price = soup.find_all("div", {'class': 'My(6px) Pos(r) smartphone_Mt(6px)'})[0].find('span').text
```


Now we have all the information that we need to complete this function, so we can just return the price.

```python
return price
```

To sum up, the purpose of this program is to constantly be able to know the current price of the stock that we are interested in, so we don't want sell our stock at a lower price than we intend. Therefore, we can just put the implementation above into a while loop. 

```python
while True:
    print("The current price: " + str(parsePrice()))
```

## Conclusion

That's it! We've fully implemented a real time stock price scraper using Python. You no longer have to go through the  trouble of looking up the price of a stock. You can simply run this program! Here's how our output should look like. 

![](https://i.imgur.com/3xBFRuj.png)

