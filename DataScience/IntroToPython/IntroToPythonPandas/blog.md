# Intro to Spyder IDE Using Python Pandas

!["Panda"](https://miro.medium.com/max/1080/1*fUO28EIHi1bkZPhjZ451tQ.jpeg)

In large datasets, it can be very difficult to extract the necessary information by hand. Python helps automate or heavily reduce the work necessary to present the relevant data set. Python is heavy on English-language syntax to promote a low learning curve and to enhance the average end-user experience

Python libraries help save time by giving you pre-written code! We recycle previously created functions to save us time for setting up our powerful data analysis tools. Without them, many programs would be significantly larger and repetitive, and saves end-users time to complete assignments.

Pandas is a premier data science tool. It reads in large data sets such as .csv files or SQL databases and can help extract data based on a meaningful range of values and/or indices. It also has sets of statistical commands to get averages, sums, medians, etc. It also has data cleaning functions useful to remove incomplete entries (NULL values), and is able to join data sets together for more comprehensive presentation. 

!["Wes"](https://cms.qz.com/wp-content/uploads/2017/11/wes_mckinney_pandas.png?w=1400&strip=all&quality=75)

Pandas has become one of the most popular tools in all of computer science, account for almost 1% of all Stack Overflow questions since 2017. The creator of Pandas, Wes McKinney, crated the tool to help all forms of analysts. He says, “I tell them that it enables people to analyze and work with data who are not expert computer scientists...You still have to write code, but it’s making the code intuitive and accessible. It helps people move beyond just using Excel for data analysis."   

Today, we will walk through some of the fundamentals of Pandas and use a variety of commands. This walktrough will use the Spyder IDE from [Anaconda](https://www.anaconda.com/products/individual
). Once installed, go to your application dashboard, then open the new Anaconda3 folder and click on Spyder. Before we can do any work, we have to install pandas through our console. Some editors have basic packages pre-installed, but always check beforehand.

A common way to install packages is:
```
pip install <package_name>
```
In Spyder: click on the Console in the bottom right corner and enter the following command below:
```
pip install pandas
```

Finally, we will need [data to work with](https://www.kaggle.com/benroshan/factors-affecting-campus-placement/data). Once downloaded, click show in folder so that you know its directory. If in a .zip, go into the .zip and copy the csv, go back to the original directory and paste.

### To Do List

#### 1. Install and Create Datasets (Done!)

#### 2. Using Commands to Extract Data

#### 3. Alter Our Datasets

#### 4. Merge and Present Information

## Extracting Our Data

Congrats! We have our library installed and our data set to work with. Now, go into Spyder and in the left terminal hit enter, then type the following to have access to  pandas library:
```
import pandas as pd
```
The “import pandas” portion now includes the entire library for us to use. The “as pd” portion is to use pd as a shortcut when calling the library functions. So now we don’t type out pandas.(function_name) everytime, but instead pd.(function_name). Yay Efficiency! Our first line of code will be to get our data set into a DataFrame object (so find your data!) Enter the file location of your .csv file into the pd.read_csv(“file”) function. On Spyder, there’s a tab called *Variable Explorer* in the middle right. Click on it, and you should see a new DataFrame object of size (215,15).

![Alt text](Users/dstef/Downloads/Spyder.png?raw=true "Optional Title")


|Name|Type|Size|Value
|:-----:|------:|:-----:|------:|
|data|DataFrame|(215,15)|Column names: sl_no, gender, ssc_p, ssc_b, hsc_p, hsc_b, hsc_s, degree...|

A DataFrame is just like an Excel table that we can directly edit using our code.
When creating a DataFrame that is not necessarily imported with read_csv, you can directly build a Dataframe in the following format:
```py
alt = pd.DataFrame({'col A':[1,2], 'col B':[3,4]})
```
Result: 

|Name|Type|Size|Value
|:-----:|------:|:-----:|------:|
|alt|DataFrame|(2,2)|Column names: A,B |

We have our data with us, but it’s very large, so we might be confused as to what to do with it right now... Here are some examples of the commands to use:
- **data.head():** returns top 5 rows
- **data.tail():** returns bottom 5 rows
- **data.head(x)/tail(x):** returns x top/bottom rows
- **data.sort_values(col1):** sorts data ascending based on col1
- **data.sort_values(col1, ascending=False):** will do the same thing, but sorted in Descending order

### Difference Between head() and head(x):

**data.head():**

|Name|Type|Size|Value
|:-----:|------:|:-----:|------:|
|data|DataFrame|(5,15)|Column names: sl_no, gender, ssc_p, ssc_b, hsc_p, hsc_b, hsc_s, degree...|

**data.head(10):**

|Name|Type|Size|Value
|:-----:|------:|:-----:|------:|
|data|DataFrame|(10,15)|Column names: sl_no, gender, ssc_p, ssc_b, hsc_p, hsc_b, hsc_s, degree...|

## Exercise 1

On the Kaggle page used to download our csv, there is a part of the page providing definitions to our data’s column headers, including salary. Use it, and the newly learned commands to:
Get the 6 highest and lowest salary entries from our dataset.

Tip: calling data.head() returns a text answer, but for a new dataframe, write new_data = data.head()

## Solution

```py
salary = data.sort_values(["salary"])

bottom = salary.head(6)
top = salary.tail(6)
```

So you would get 200,000 for the 6 bottom salaries, but the top 6 salaries were NAN. That doesn’t tell us what we really want. We can filter out NULL data (like here where there was no offer made):
```py
salary.dropna(subset=["salary"], inplace = True)
```
Dropna() gets rid of null values, and arguments subset means we can remove NULL values in a certain column (here we use salary). Inplace is to choose between overwriting the same object or create a new one (true = overwrite).

## Revised Solution

```py
salary = data.sort_values(["salary"])

salary.dropna(subset-["salary"], inplace = True)
bottom = salary.head(6)
top = salary.tail(6)
```

## Altering Our Data

!["Alter"](https://data-flair.training/blogs/wp-content/uploads/sites/2/2019/06/Aggregation-and-Grouping-in-Pandas.jpg)


Say I want the average value of a certain set, or maybe I just want the highest percentage from each column. Pandas is equipped with various commands such as the ones above that can help us query the datasaet for relevant information.

data.max() and data.min() will return the highest/lowest value of every column, 
data[‘col1’].max() returns highest value in derived column. Similar implementation for .mean(), .median(), .sum(), .count(), .std() [standard deviation], and more. 

For our data set:

data.max() = 15 values

data[‘Salary’].max() = 1 value

data.mean() = 7 values, since the other 8 columns are non-numerical


## Exercise 2

Let’s get the median and sum of the top 100 salaries, as well as the max mba_p from those 100 candidates

Tip: How are the salaries sorted right now?

## Solution

```py
salary = data.sort_values(["salary"],ascending=False)

hundred = salary.head(100)
sum_hun = hundred["salary"].sum()
med_hun = hundred["salary"].median()
max_mba = hundred["mba_p"].max()
```
## Merging New Data

What if I want to see how all the percentages add up and take the mean? Maybe that can be done with the tools already given, but now I want to add it to our original set as a new column.

There are two ways to add data: **.append()** and **.concat().** Append is to add a dataframe with identical row indexes (same column values), while .concat() adds identical column indexes (same row values).

Code Format:
data1 = To be added
data2 = Data we want to update
data1 = data1.append(data2)
data.concat([data1,data2])
Add two columns with:
New_data = data[col1] + data[col2]
Note: This creates a Series object, not a DataFrame
Add a series to DataFrame by creating new column:
data[“New Col”] = series

Example:
```py
one = pd.DataFrame({'A': [1], 'B': [3]})
two = pd.DataFrame({'A': [2], 'B': [4]})
one = one.append(two,ignore_index=True)
```
2 size(1,2) DataFrames merge into a (2,2) new object. Ignore_index works like inplace earlier.

## Final Exercise Part 1

Let’s take the 5 percentages in our original data set, sum them into one column (and divide by 5 with data /= 5), return the average of the column and add this column to our original data set.

Tip: You can add columns together!

## Solution

```py
new_data = data["ssc_p"] + data["hsc_p"]
new_data = new_data + data["degree_p"]
new_data = new_data + data["etest_p"]
new_data = new_data + data["mba_p"]
new_data /= 5
data["Mean"] = new_data
```
## Final Exercise Part 2

Get the 5 highest mba_p and the 5 highest etest_p candidates and merge their dataset to 10 “premier candidates”

Tip: The two Dataframes share the same column indexes 

## Solution
```py
mba = data.sort_values(["mba_p"],ascending=False)
etest = data.sort_values(["etest_p"],ascending=False)
mba_top = mba.head()
etest_top = etest.head()
mba_top = pd.concat([etest_top,mba_top])
```

Congratulations! With this tuorial, we learned to sort data and isolate information, as well as ignore irrelevant or incomplete data. We could then create new subsets of data for future analysis and readability. Finally, we gained the ability to add the data to create a more comprehensive data set.




