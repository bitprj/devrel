
# How to create a Tableau dashboard:

This blog will teach you how to create a Tableau dashboard in the following steps:
* Step 1: Connect to data source
* Step 2: Create a table with filters
* Step 3: Create a line graph with a date filter
* Step 4: Format the dashboard

Step 1: Connect to data source
- 
Once you open Tableau, you need to connect to a data source. 
We will use a Microsoft Excel file for this dashboard.

![](https://i.imgur.com/UUjUMPf.jpg)


After connection, raw data:

![](https://i.imgur.com/5o0HVof.jpg)



Step 2: Create a table with filters
- 
In the first sheet, we will create a COVID-19 stat table with state and county filters.
This step is broken into three parts:
* Create table
* Remove abc column
* Add filters

**Create table**
This is what you will see on the left side.
Dimensions display Date, State, and County and Measures display numeric columns, such as Cases and Deaths.

![](https://i.imgur.com/0GSeyCd.jpg)

In the table, we would like to display Date, State, County, Cases, and Deaths columns. So we will drag those column names into "Rows" section.

![](https://i.imgur.com/tLH334O.jpg)

But the table looks weird.
We need to set Cases, Deaths columns to "Discrete."

![](https://i.imgur.com/YIseNHc.jpg)

Once we change Cases and Deaths to Discrete, this is what it looks like!

This is what we want, except that there is an Abc column.
![](https://i.imgur.com/d3lQDWo.jpg)


**Remove Abc column**
This blog will cover how to remove the Abc column in the table.
But, feel free to check out the video below if you would like to follow a video tutorial.
https://www.youtube.com/watch?v=6FTZ6TnYaF0

First, click any abc column and click Format.
![](https://i.imgur.com/NZ6WGTx.jpg)

Change Pane color to White.

![](https://i.imgur.com/BcWDLzU.jpg)

This is what it looks like after you change the color.
![](https://i.imgur.com/ceout1e.jpg)

Choose the column on the left of Abc and click Format.
![](https://i.imgur.com/UqUSaab.jpg)


Under the “Borders” (Square icon), set Column Divider Pane to None.
![](https://i.imgur.com/ZVc527t.jpg)

Shrink the width of the blank column! This is the final table!
![](https://i.imgur.com/nTLe6cI.jpg)

**Add filters**
Now, let’s add State, County filter. (Choose Select All from List)

![](https://i.imgur.com/OjVLHO0.jpg)

Right click on the State filter and choose "Show Filter."
![](https://i.imgur.com/xObIbNK.jpg)

This filter shows all of the states. It's too lengthy!

![](https://i.imgur.com/yMBKQLd.jpg)

Right click the tiny dropdown in the State filter and change it to the form you like - I choose Single Value dropdown

![](https://i.imgur.com/ENuRhRh.jpg)

The lengthy filter list changed to a dropdown list!
![](https://i.imgur.com/EPLT9LJ.jpg)

Change title name and this is the final product!
![](https://i.imgur.com/EHpACLh.jpg)


Step 3: Create a line graph with a date filter
- 
In Sheet 2, we would like to draw a graph that displays the number of Cases by each state.

Add Date as a column – default is Year(Date)
![](https://i.imgur.com/KBoRG6v.jpg)

Change Year to Exact Date (You can choose Month, Week Number, etc.)
![](https://i.imgur.com/OySakLB.jpg)

Now, it shows the date!
![](https://i.imgur.com/eb84ztv.jpg)


Let’s add #Cases to Rows and it draws a graph!
![](https://i.imgur.com/NrJmp4B.jpg)

Now, let's apply date range filter.
Add Date column to Filters and select “Range of Dates” and the range of dates automatically shows the range from start date to end date. Hit OK.

![](https://i.imgur.com/TvTq1F7.jpg)

![](https://i.imgur.com/nOSmHtM.jpg)

Click the Date filter and select “Show filter.”
Here we go! The date filter appears on the right side of the dashboard.

![](https://i.imgur.com/GPmQW1X.jpg)

![](https://i.imgur.com/9qxEOry.jpg)

As mentioned above, we would like to display #Cases by state. Drag state dimension to Marks >> Color

![](https://i.imgur.com/EtVsmWf.jpg)

This warning pops up because the dataset contains 54 states, so we will apply a filter to select top states. Click “Filter and then add.” But if you would like to see all states, click “Add all members."

![](https://i.imgur.com/KUUBE5R.jpg)

Select California, Illinois, New Jersey, and New York, which are the states with most coronavirus cases.

![](https://i.imgur.com/osQETRU.jpg)

Tada!
The graph below displays COVID-19 cases by state.
![](https://i.imgur.com/0HDFtwb.jpg)

If you change the date range, the bar graph updates accordingly.
![](https://i.imgur.com/schpEg4.jpg)

If you would like to apply date range filter to sheet 1 (COVID-19 case by state and County), you can do so by applying the date filter to all worksheets using the same data source. Now, the date filter will be applied to sheet 1 and sheet 2.

![](https://i.imgur.com/3XZuNIM.jpg)

Step 4: Format the dashboard
- 

In dashboard 1, drag sheet 1 to the blank page.

![](https://i.imgur.com/ORdHKDE.jpg)

Then you will notice that this dashboard does not have any space to display the bar graph we created in sheet 2. We should expand the size of the dashboard. 

The default size is 1000 x 800. Let’s increase the height to 1600.

![](https://i.imgur.com/iLXt34y.jpg)


Select sheet 1 and click the Downward Arrow and select Floating. This allows you to freely move the table and resize the table.

![](https://i.imgur.com/K25QOae.jpg)

Click “Floating” on State and County filter and move around the table and two filters as you would like.
![](https://i.imgur.com/eAg9Add.jpg)

Follow the same steps above and add sheet 2 to the dashboard.

![](https://i.imgur.com/NGeWYvY.jpg)

Now, let's add title to the dashboard!

Check "Show dashboard title" in the Objects section and add the title.

![](https://i.imgur.com/hbZbZ1h.jpg)

The dashboard looks too plain, so let's add a background color to the title.

![](https://i.imgur.com/8Er750I.jpg)

Right click the title and click "Format title…"

![](https://i.imgur.com/YDKw8AU.jpg)

Apply Shading in the Dashboard Title section.

![](https://i.imgur.com/RsmLOhP.jpg)


Here is the final product of the dashboard!

![](https://i.imgur.com/dbwHZVE.jpg)
![](https://i.imgur.com/4Y8RT3m.jpg)


