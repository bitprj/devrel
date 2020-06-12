# Scraping and Sanitizing Data in Python by Beautiful Soup

Sometimes, you come across some rankings that intrigues you, like the Billboard Hot 100. However, there's no simple download button that lets you look at the informaton as a database. That's where web scraping comes in, allowing you to extract information from the internet. Sometimes, this can yield unorganized data, but it is a key tool that vastly increases our access to information. We will use a few Python libraries, most notably BeautifulSoup and Pandas, to help us gather some information off of the internet. 

# Pre-Req: HTML Basics

![Alt Text](https://i.imgur.com/kVOdBf7.png)

If you ever used inspect element to change the around the title of a webpage to mess with your friends, you were programming HTML! HTML is a language used to affect the presentation of webpages, and relies on tags to store different types of information. [W3Schools](https://www.w3schools.com/tags/) is a great resource to learn more, but some relevant keywords for us are as follows: 

*head:* element is a container for metadata (data about data) and is placed between the *html* tag and the *body* tag.

*body:* contains all the contents of an HTML document, such as headings, paragraphs, images, hyperlinks, tables, lists, etc.

*div:* Whenever you include certain content, you enclose it together inside this single entity. 
It can act as the parent for a lot of different elements. 

*href:* Specifies the URL the link goes to.

*a:* The links are described in this tag, where the webpage that will get loaded on 
click of this link is mentioned in its property href.

*p:* Whenever some information is to be displayed on the webpage as a block of text, 
this tag is used. Each such tag appears as its own paragraph.

*tbody:* Defines a grouping for the content of an HTML table.

*tr:* Defines a row in an HTML table.

*th:* Defines a header in an HTML table.

*td:* Defines a data cell in an HTML table.

*table:* Tables are displayed in HTML with the help of this tag, 
where data is displayed in cells formed by intersection of rows and columns.

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

We will scrape statistics from a set of [set of](https://www.basketball-reference.com/play-index/psl_finder.cgi?request=1&match=single&type=per_game&per_minute_base=36&per_poss_base=100&lg_id=NBA&is_playoffs=N&year_min=1985&year_max=2020&franch_id=&season_start=1&season_end=-1&age_min=0&age_max=99&shoot_hand=&height_min=0&height_max=99&birth_country_is=Y&birth_country=&birth_state=&college_id=&draft_year=&is_active=&debut_yr_nba_start=&debut_yr_nba_end=&is_hof=&is_as=&as_comp=gt&as_val=0&award=&pos_is_g=Y&pos_is_gf=Y&pos_is_f=Y&pos_is_fg=Y&pos_is_fc=Y&pos_is_c=Y&pos_is_cf=Y&qual=&c1stat=pts_per_g&c1comp=gt&c1val=20&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&c5stat=&c5comp=&c6mult=&c6stat=&order_by=pts_per_g&order_by_asc=&offset=0) basketball players who have scored more than twenty points per game in a season after 1984. We are able to get a specific data set due to the query commands offered by www.basketball-reference.com (a fantastic website), but there are limits to their tools. To capture the data table, we first will right-click and select "Inspect Element" on Michael Jordan's name in the first row. As you hover over various parts of the code on the right, you will see that there is a link (https://www.basketball-reference.com/players/j/jordami01.html) wrapped by a *td* set, and that there are pairs of *td* and *data-stat=* for each stat down the line like season, age, team_id, etc. These are wrapped by a *tr* pair for *data-row-=0*, which is preceded by a *tbody* pair. 

![Alt Text](image1)


# Scraping the Data

Understanding where our data lies is crucial for implementing the scraper. BeautifulSoup uses an html parser to locate the data we want, so being able to give it the tags that relate to that stats table is the engine behind our machine. Before we start, we want to ensure we have the following libraries installed using pip install *package_name*: pandas, numpy, requests and bs4. The first thing we want to do for our scraper is determine how many pages there are to scraper. For this particular dataset, it is laid out across 9 different URLs. We have to examine what changes occur between two pages of our dataset. It is a really long link, but we can see at the end there is a part that says offset=0 for the first page, but is equal to 100 for the second page, and increments by 100 each time. 

This, combined with having nine pages of information, means we will create a for loop that goes from 0 to 900 in increments of 100, and we will copy the base url (everything through 'offset='), and then add our for loop variable i to the end of the url with str(i). So, base url + str(i).

![Alt Text](image2)

For this dataset, I want to only extract the player, the season, their team, and their points per game. 
Going back to our *td* pairs, I can click inspect element on each element and see what the corresponding *data-row=* is. For this, it would be the tags 'player','season','team_id','pts_per_g'. We can create two Pandas dataframes to store our information: a final set to hold all the information, and a temp one we use to append a new page of information to our final set.

### Access Server Information

At the start of each loop iteration, we are going to have to make an HTTP response and store it. This stored response has to be converted to text, then will be used to pass into a BeautifulSoup object, with the second parameter being a built in parser, cleverly named 'html.parser'. Our BeautifulSoup parser has two related functions to call: find() and find_all(). We can use find() to find the instance of our table. This is as opposed to using find_all(), when we need to search the entire document for instances of something, find returns the singular result we want directly rather than a list. For us, we are looking for up to 100 instances of relevant rows per page, so we want to use find_all(). We can create two for loops: one to loop over each relevant feature we want (player, season, etc.), and another one to loop over each *td* pair in our find_all(*td*, *data-stat=feature*). Since we want the information as plain text, we have to convert it concurrently. All of this is passed as a variable.

![Alt Text](image3)

# Append Data

We now have our data, we want to re-format our data and add it to a final set. We take the stats variable and pass it into a Pandas DataFrame. Due to how the information was stored, our stats variable is a 4 element list with each element being size 100. We want the opposite of that, so we call .transpose() on our new dataframe to properly format it, and set its columns to be equal to our features variable.
We then call .append() with the final set DataFrame.

# Bonus: Cleaning The Data

We were able to work with a cleaned data set that didn't require too much to change. However, I may want to make more specific queries on the existing data set or eliminate any potential null values. For example, I can use the .isin() command to extract a value or list of values. So, if I only wanted the list of twenty point per game scorers from the Suns, Bulls, Lakers, Celtics and Knicks, I can extract it with isin(). For null values, say I was looking at an older data set that started from 1964 instead of 1984. The three point shot didn't exist before 1979, so I can use dropna() to remove any instances of seasons before the three point era. This snippet below showcases a basic use of isin() and dropna(). If you comment out the dropna and add a few null rows to the dataset, then call dropna to see them go away.

![Alt Text](image4)
