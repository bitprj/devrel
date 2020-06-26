# Exploring Movie Streaming Data With R
Raymond Wang

## Exploratory Data Analysis
Exploratory data analysis, or EDA for short, is an approach to exploring data that can help you obtain basic but essential insights before performing more complex operations. Although the techniques employed by EDA are relatively simple, EDA is a critical component of any statistical analysis. For starters, it allows us to understand the underlying structure of the data and evaluate the validity of our assumptions. It can also help us formulate hypotheses about the data, which we can then test with more defined models. In this blog, I will show a few examples of EDA using R, the programming language of choice for many data scientists. If you’d like to try out these examples for yourself, make sure you have R installed (see [here](https://www.r-project.org/) for details on how to do this). When actually coding, I like using Jupyter Notebook, but you can use any environment you’d like (RStudio is another great option).

## EDA Techniques
If you’ve ever worked with data before, you’ve likely used some EDA techniques, even if you’ve never heard of the term. That’s because EDA is an incredibly broad topic, and there’s usually no single model or method that defines your approach. Many common techniques are graphical in nature; histograms, box plots, and scatter plots all help us understand data visually. Tabular results describing correlations, averages, and other summary statistics are also incredibly helpful. For this blog, I will be using a movie streaming dataset, courtesy of Kaggle, which you can download for yourself [here](https://www.kaggle.com/ruchi798/movies-on-netflix-prime-video-hulu-and-disney). I’ll also be using some packages from Tidyverse to help with the analysis.

## What is Tidyverse?
Although R is an incredibly popular language, it’s also quite old, meaning that many of the newest advancements in the language have come from packages like dplyr and ggplot2 (both of which we will explore later). Tidyverse is a collection of these packages that work together to make collecting, cleaning, and manipulating data faster and easier.

To install Tidyverse, run `install.library(“Tidyverse”)`. Now, we can load its packages with the library function, as seen below.

![](https://i.imgur.com/tx6dz70.png)

Here, we can see the list of packages included in Tidyverse. Each one brings unique tools to R. Broadly speaking, here are their uses:

ggplot2 - data visualisation
dplyr - data manipulation
tidyr - data tidying
readr - importing data
purrr - functional programming
tibble - adding enhanced dataframes, called tibbles
stringr - string manipulation
forcats - handling factors (categorical data)

## Getting the Data
Now that we’re all set up, let’s import our data and check it out. To do this, we can enter `movies <- read.csv(“MoviesOnStreamingPlatforms_updated.csv”)`.

![](https://i.imgur.com/CYGQIaI.png)

The `<-` arrow here assigns the dataframe returned by the `read.csv()` function to the variable “movies”. Now, if we take a look at “movies”, we can see that it contains a data frame with 16,744 rows (each containing a unique movie) and 17 columns.

![](https://i.imgur.com/pXFqNdk.png)![](https://i.imgur.com/4cUu6OE.png)


These columns contain information about the movie, like what year it was released, who the director was, its runtime and genres, and more, along with its ratings on IMDb and Rotten Tomatoes. It also tells us whether or not we can find a given movie on Netflix, Hulu, Prime Video, and Disney. It’s clear to see that there are a lot of potential questions we could explore with this data. But before we begin, we should try cleaning it up a bit. For starters, there is a column, X, which contains no useful information (it’s a redundant index column), so let’s remove it to illustrate how you might go about removing other unnecessary columns.

![](https://i.imgur.com/lCS6vNw.png)

Here, `%>%` is an infix operator which is frequently used by Dplyr, one of the Tidyverse packages we mentioned earlier. And in this case, we’re using it with select, a Dplyr function to subset columns in a data frame. As you can see, that X column is no longer here.

We also have the issue of missing data. There are a handful of ways to address missing data, but for our purposes here, I will simply remove incomplete rows. This can be done with `complete.cases()`, a function which, as its name may suggest, returns a vector specifying which rows or observations have no missing values.

![](https://i.imgur.com/d1WmQxC.png)

Looking at the details of the data frame in the top left hand corner, we can see that the data now has 15,189 rows, meaning we removed 925 movies. Unfortunately, cleaning data is rarely this easy. As we will see later on, there can still be missing values, misformatted data, and even incorrect data.

## Analyzing the Data
Before doing anything, let’s look at some summary statistics to see if anything pops out at us.

![](https://i.imgur.com/cEHMQ1d.png)

Right away, there are some oddities that show up. The maximum runtime of a movie, for instance, is 1,256 minutes - almost 21 hours! Or so it seems. If we try to find this observation, we see that it’s an old movie from 1940 called Colorado. After looking it up online, it’s real runtime is actually only 57 minutes and 54 seconds. Errors like these highlight the importance of exploring your data and investigating any odd values.

Moving on for now, let’s look at the summary statistics for the year of release. We can see that the oldest movie is from 1902 (A Trip to the Moon), with the mean in 2003. These numbers alone don’t tell us much though. To get a better idea of when these movies were released, let’s see what a distribution for Year looks like.

![](https://i.imgur.com/ljgI0dY.png)

Now, we can clearly tell that there were far more movies released in recent times, which is unsurprising. These charts, known as histograms, are an easy way to get important information about our data.

Now let’s say we wanted to look at which genres of movies are the most common. Our initial summary statistics gave us the top 6, but suppose we wanted to see more. We can use Dplyr again to accomplish this task.

![](https://i.imgur.com/G41IbRN.png)

Here, we started with our data frame, movies. Using the `%>%` operator introduced earlier, we can then group the data by genre with `group_by()`, then count the total number of observations in each group with `tally()`, and finally rearrange the results with `arrange(-n)`, where the `-n` specifies that we want the count column, n, to be in descending order.

If we tweak this code a bit, we can investigate the data in more detail as well. Say, for example, you’re considering subscribing to Netflix. You’d be much more interested in what genres of movies are most common on Netflix, instead of in the entire dataset. We can simply add a filter to only include observations where the Netflix column has a value of 1.

![](https://i.imgur.com/4j3Z5lC.png)

Now if you were considering subscribing to any other streaming service, and you wanted to compare your options, you could run this with all the other sites as well to see which sites have the most movies from genres you enjoy. It would also be great to compare the size of their overall selections. We can get these numbers by filtering and running `summarise(count = n())`.

![](https://i.imgur.com/kx96FBW.png)

As we’ve seen, graphs and tables are great ways to understand specific characteristics of the data. And we can get quick answers to a lot of initial questions with Dplyr. But when we look at data, we are often interested in the relationships between variables as well. To get an example of this, let’s look at whether IMDb scores are correlated with Rotten Tomatoes scores.

## IMDb vs Rotten Tomatoes
IMDb and Rotten Tomatoes are two of the most popular sites for movie ratings. Given that they both perform a similar function, it would be reasonable to expect that the score a movie receives on IMDb would be correlated to the score it receives on Rotten Tomatoes, despite the fact that their scoring systems are quite different (IMDb scores come from audiences, while Rotten Tomatoes scores come from critics).

Before we begin, let’s take a look at the distribution of scores from each site.

![](https://i.imgur.com/u7A7KRv.png)![](https://i.imgur.com/QgiMv0U.png)

Right away, something seems very wrong. The histogram of IMDb scores looks great, but there seems to be far too many near 0 observations for Rotten Tomatoes scores. It’s likely that we are looking at missing values, so we’ll need to look through our data. It’s worth noting here that since Rotten Tomatoes rates movies with a percentage, R has identified this as a factor variable, instead of a numeric one. To get proper results, we needed to convert these values to numbers with `as.numeric()`.

![](https://i.imgur.com/pUMPbdq.png)

Just as suspected, many of the movies are missing Rotten Tomatoes scores. There are a number of ways we could handle this, one of which is to create a new dataframe of movies that are missing this rating, and to then remove these movies from our original dataframe.

![](https://i.imgur.com/KctYyDx.png)

Now, let’s look at our Rotten Tomatoes histogram again.

![](https://i.imgur.com/fCcGusO.png)

This is much better. Although it still isn’t nearly as pretty as the IMDb distribution, we should be able to use this to find the correlation between the two sites. Getting the actual r value for correlation is super easy in R, we just need to use the `cor()` function with two numerical lists. We can also use ggplot, a package from Tidyverse, to create a scatter plot so that we can visualize this relationship. In the `ggplot()` function call, tomatoes is our dataset of movies with non-empty Rotten Tomatoes scores, and we specify IMDb as the x-axis and Rotten Tomatoes as the y-axis. The `geom_point()` component at the end is used to create the actual scatterplot.

![](https://i.imgur.com/6LUfDqw.png)

Our correlation coefficient, 0.377, tells us that there is a moderate relationship between IMDb and Rotten Tomatoes scores, and we can see this in the scatterplot (as IMDb scores increase, Rotten Tomatoes scores tend to increase as well). However, the relationship is a lot weaker than you might’ve expected, which tells us that audiences often perceive movie quality fairly differently from the critics.

## Are Movies on Netflix Above Average?
Let’s take a look at this one last question to illustrate some other simple EDA techniques you can perform in R. From our last analysis, we’ve seen that IMDb scores are far more normally distributed than Rotten Tomatoes scores. So to answer this question, we’ll see if there’s a statistically significant difference between the average IMDb score of movies on Netflix vs the average score of movies not on Netflix.

First, let’s look at some summary statistics:

![](https://i.imgur.com/KD0aTfJ.png)

Here, it seems like movies on Netflix do indeed have a higher average rating (6.274 compared with 5.807). I also threw in statistics about the year of release as well, to see if movies on Netflix are more recent. And indeed they are.

To get a better understanding of the difference here, we can try to compare these two populations graphically, using side by side boxplots created with ggplot. Now, instead of `geom_point()`, we want to use `geom_boxplot()`, and we want to specify how the groups are assigned, rather than the x-axis.

![](https://i.imgur.com/suSVoYw.png)

Unfortunately, these boxplots still don’t tell us too much. It’s clear again that Netflix does have slightly higher rated movies, but we need to get a measure of statistical significance. This is where a two sample t-test comes in. With the `t.test()` function, we can test the null hypothesis that these two sample populations have the same mean.

![](https://i.imgur.com/yqnKM91.png)

Our results show that the p-value is incredibly low, meaning that there is a very low probability that the differences in mean IMDb scores are a result of random chance. Instead, movies on Netflix are most likely better on average than other movies, and we can reject the null hypothesis.

Of course, this was perhaps a silly question to begin with. Of course the world’s most popular and profitable streaming site would select better movies than the overall average of ~15,000 movies. A more interesting question would be comparing two different streaming sites, taking the movies from Netflix and comparing them to those on Hulu, for instance. With the tools shown here, you can do that analysis for yourself and find out!
