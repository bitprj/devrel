# Scraping and Sanitizing Data in Python by Beautiful Soup

There are a lot of tables embedded in websites, like the Billboard Hot 100, TV channel ratings, address books, etc. However, this data is not readily availlable to be downloaded. That's where web scraping comes to allow you to extract information from the internet. Sometimes, this can yield unorganized data, but it is a key tool that vastly increases our access to information. We will use a few Python libraries, most notably BeautifulSoup and Pandas, to help us gather some information off of the internet. 

# Pre-Req: HTML Basics

![Alt Text](https://i.imgur.com/kVOdBf7.png)

If you ever used inspect element to change the around the title of a webpage while messing around with your friends, you were programming HTML! HTML is a language used to affect the presentation of a website, and relies on tags to store different types of information. [W3Schools](https://www.w3schools.com/tags/) is a great resource to learn more, but here are some immediately relevant keywords:

*head:* A container for metadata (data about data) and is placed between the *html* and *body* tags.

*body:* Holds the content of an HTML document, including headings, paragraphs, images, hyperlinks, tables, lists, etc.

*div:* Whenever you a wrapper for content under one set. It can act as the parent for a lot of different elements. 

*href:* Holds the link's URL.

*a:* Describes the links held in the href.

*p:* Used to display text on a page.

*tbody:* Defines a grouping for the content of an HTML table.

*tr:* Signifies a HTML table row.

*th:* Signifies a HTML table header.

*td:* Signifies data in a HTML table.

*table:* Helps format data in cells of rows and columns.

Here's a basic example:
```html
<html>
  <head>
    <title>Title of the Page</title>
  </head>
  <body>
    <div id="base">
      <a href="***">Link</a>
      <p>Paragraph</p>
    </div>
    <table class="table">
      <tr>
        <th>Col 1</th>
        <th>Col 2</th>
      </tr>
      <tr>
        <td class="data">Row 1 Data 1</td>
        <td class="data">Row 1 Data 2</td>
      </tr>
    </table>
  </body>
</html>
```

# Analyzing Our Website

![Alt Text](https://d2p3bygnnzw9w3.cloudfront.net/req/202005291/logos/bbr-logo.svg)

We will scrape statistics from a [set of](https://www.basketball-reference.com/play-index/psl_finder.cgi?request=1&match=single&type=per_game&per_minute_base=36&per_poss_base=100&lg_id=NBA&is_playoffs=N&year_min=1985&year_max=2020&franch_id=&season_start=1&season_end=-1&age_min=0&age_max=99&shoot_hand=&height_min=0&height_max=99&birth_country_is=Y&birth_country=&birth_state=&college_id=&draft_year=&is_active=&debut_yr_nba_start=&debut_yr_nba_end=&is_hof=&is_as=&as_comp=gt&as_val=0&award=&pos_is_g=Y&pos_is_gf=Y&pos_is_f=Y&pos_is_fg=Y&pos_is_fc=Y&pos_is_c=Y&pos_is_cf=Y&qual=&c1stat=pts_per_g&c1comp=gt&c1val=20&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&c5stat=&c5comp=&c6mult=&c6stat=&order_by=pts_per_g&order_by_asc=&offset=0) basketball statistics to find players who scored 20 points per game or more since 1984. www.basketball-reference.com (a fantastic website) has a lot of query tools built into their website, but there filtering is limited, so we need to scrape the data to get what we want. To capture the data table, we first will right-click and select "Inspect Element" on Michael Jordan's name in the first row. As you hover over various parts of the code that pops up, you will see that there is a link (https://www.basketball-reference.com/players/j/jordami01.html) wrapped by a *td* set, and that there are pairs of *td* and *data-stat=* for each stat down the line like season, age, team_id, etc. These are wrapped by a *tr* pair for *data-row-=0*, which is preceded by a *tbody* pair. These are the relevant tags we will need to reference when scraping.

![Alt Text](https://i.imgur.com/g8mi9vx.png)


# Scraping the Data

Understanding where our data lies is crucial for implementing the scraper. BeautifulSoup uses an html parser to locate the data we want, but we have to give it some baseline information to do so. 

Before we start, we want to ensure we have the following libraries installed using pip install *package_name*: pandas, numpy, requests and bs4. The first thing we want to do for our scraper is determine how many pages of information there are. For this particular dataset, it is laid out across 9 different URLs. We have to examine what changes occur between two pages. It is a really long link, but we can see at the end there is a part that says offset=0 for the first page, but is equal to 100 for the second page, and increments by 100 each time. 

Knowing what changes in our url, we will create a for loop that goes from 0 to 900 in increments of 100, and we will copy the base url (everything through `offset=`), and then add our for loop variable `i` to the end of the url with `str(i)`. So, `url = (base url) + str(i)`.

![Alt Text](https://i.imgur.com/XQu2tug.png)

For this dataset, I want to only extract the player, the season, their team, and their points per game. 
Going back to our *td* pairs, I can click inspect element on each element and see what the corresponding *data-row=* is for each statistic. In HTML, they are tagged as 'player', 'season', 'team_id', 'pts_per_g'. We can create two Pandas dataframes to store our information: a temporary DataFrame we use to append a new page of information to our final set, and a final set to hold all the information.

### Access Server Information

At the start of each loop iteration, we are going to have to request an HTTP response for ourl url and store it as plain text. We then will pass it into a BeautifulSoup object, with the second parameter being a built in parser, cleverly named 'html.parser'. Our BeautifulSoup parser has two related functions to call: `find()` and `findAll()`. We can use `find()` to find the instance of our table. This is as opposed to using `findAll()`, when we need to search the entire document for instances of something, find returns the singular result we want directly rather than a list. For us, we are looking for up to 100 instances of relevant rows per page, so we want to use `findAll()`. We can create two for loops: one to loop over each relevant feature we want (player, season, etc.), and another one to loop over each *td* pair in our `findAll(*td*, *data-stat=feature*)`. Since we want the information as plain text, we have to convert it concurrently.

![Alt Text](https://i.imgur.com/l5MaQso.png)

# Append Data

We now have our data, we want to re-format our data and add it to a final set. We take the stats variable and pass it into a Pandas DataFrame. Due to how the information was stored, our stats variable is a 4 element list with each element being size 100. We want the opposite of that, so we call `.transpose()` on our new dataframe to flip the rows to columns and vice versa, and set the column names to our list of features. We then call `.append()` with the final set DataFrame.

# Bonus: Cleaning The Data

We were able to work with a cleaned data set that didn't require too much to change. However, one may want to make more specific queries on the existing data set or eliminate any potential null values. For example, I can use the `.isin()` command to extract a value or list of values. So, if I only wanted the list of twenty point per game scorers from the Suns, Bulls, Lakers, Celtics and Knicks, I can extract them with `isin()`. For null values, imagine an older data set that started from 1964 instead of 1984. The three point line didn't exist before 1979, so I can use `dropna()` to remove any instances of seasons before the three point era. This snippet below showcases a basic use of `isin()` and `dropna()`. 

![Alt Text](https://i.imgur.com/Mn052zQ.png)
