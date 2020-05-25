# Association Rule Mining in Python

Ever wondered why you get recommendation mails which suggests you to buy things which are quite related to what you bought earlier? Perhaps a pillow cover is recommended when you buy a new bedsheet. You might have noticed that whenever you buy things online, you are also given a list of items which other customers bought along with the item that you buy. For example, when you buy a mobile phone, you are automatically shown a phone case in the recommended products. Similarly, whenever you are in a mall, you might have noticed that bread and butter are kept nearby. This naturally helps us in buying things but it also increases the shop's profit because every retailer knows that if you put two products next to each other on a shelf, they're more likely to be sold together. This magical recommendations of the items based on what others buy with an item is nothing but association mining. 
One of the most astounding association found so far is the diaper-beer pair. You might think how are diaper and beer correlated? But in 1992, Karen Heath, stumbled across this correlation and also evidently, young fathers ran up to stores late at night to buy diapers and beer.  This became quite the folklore of the data analysis.

Let us come to the part where we become the magicians and find out the associations between products. Apriori Algorithm is used for finding the association rules. The three major terms which help to understand the Apriori algorithm are: 
 * Support
 * Confidence
 * Lift

#### Support

Support refers to the default popularity of an item in the dataset and can be calculated by finding number of transactions containing a particular item divided by total number of transactions. Suppose we want to find support for item B. This can be calculated as:

> Support(B) = (Transactions containing (B))/(Total Transactions)

#### Confidence

Confidence refers to the likelihood that an item B is also bought if item A is bought. It can be calculated by finding the number of transactions where A and B are bought together, divided by total number of transactions where A is bought. Mathematically, it can be represented as:

> Confidence(A→B) = (Transactions containing both (A and B))/(Transactions containing A)

#### Lift

 Lift(A→B) refers to the increase in the ratio of sale of B when A is sold. Lift(A → B) can be calculated by dividing Confidence(A→B) divided by Support(B). Mathematically it can be represented as:

> Lift(A→B) = (Confidence (A→B))/(Support (B))

In this blog, after giving a short introduction of how the algorithm works, we will go though  applying the algorithm in Python on a dataset.

### Learning objectives for this activity:

- Help audiences to have a big picture of what the association mining is and what role it plays in the real world
- Get audiences to be familiar with the concept and feel comfortable to use Apriori algorithm.

## Apriori Algorithm

Let us assume that we have the following transactions in a certain shopping mall. Here, TID is the transaction ID.

| TID   | Items  | 
|---|---|
|1|Milk, Coke, Beer|   
|2|Milk, Pepsi, Juice| 
|3|Milk, Beer|
|4|Coke, Juice|
|5|Milk, Pepsi, Beer|
|6|Milk, Coke, Beer, Juice|
|7|Coke, Beer, Juice|
|8|Beer, Coke|

The unique item set is {Milk, Coke, Pepsi, Beer, Juice}.
We define a **basket** as a small subset of items, for example, the products which a customer buys in a single trip to the shopping mall. Also, the **support** for an item set is the number of baskets containing all items in the item set.
Given a support threshold *'s'*, sets of items that appear in at least *s* baskets are called as **frequent item sets**. In this example, let us assume the support threshold is 3.
We will count the frequency of the singleton set, i.e. a single item and decide which of them can be included in the frequent item sets.

|Item| Count/Support|
|---|---|
|M|5|
|C|5|
|P|2|
|B|6|
|J|4|

Here, only 'Pepsi' has a count of 2, which is below the support threshold. Hence, we can say that the frequent item sets of size 1 are {M},{C},{B} and {J}.
Similarly, the frequent item sets of size 2 are {M,B}, {C,B} and {C,J} and frequent item set of size 3 is {M,C,B}.
We now calculate the confidence of the association rules which we can form using the frequent item sets. Assume that the threshold for confidence is 0.75.
Using the formula given above, we calculate the confidence of the rules:
B→M has a confidence of 4/6. This is below the threshold and we do not consider this rule. However, the rule B→C has a confidence of 5/6 and it is above the confidence threshold level, so we consider this as one of the association rule. This is how the association rules are generated.

Now, we turn to the practical application of this algorithm on a given dataset.
(Audiences are encouraged to use various tools to have their implementations, such as Goole Colab, Jupyter notebook)

The data which we will work on, is a real online retail transaction data set of two years which is available on this [link](https://archive.ics.uci.edu/ml/datasets/Online+Retail+II).
The data has 1067371 instances and 8 features. The downloaded dataset is in an excel file format.
Let us first start with importing the libraries which are required to run the program.

##### Import Libraries

```
import pandas as pd
import numpy as np
from mlxtend.frequent_patterns import apriori, association_rules
```

In the script above we import pandas, numpy, apriori and association_rules libraries.

Some audiences may encounter problems like missing modules. To solve, simply install the libraries using ``` pip install <library name> ``` or follow the instructions given in the documentations of the respective libraries to install the required components.

##### Importing the Dataset

Now let's import the dataset and see what we are working with. Download the dataset and place it in the *data* folder  and execute the following script:

```
data = pd.read_excel("data/online_retail_II.xlsx")
data_temp = pd.read_excel("data/online_retail_II.xlsx", 'Year 2010-2011')
```

If you open the excel file, you will notice that the data is separated into years by different worksheets. Hence, we import both the worksheets and combine them into a single data frame using the following code:

```
data = pd.concat([data,data_temp])
```

To see the first 5 rows of the data:

```
data.head()
```

The data frame will look like this:

![data_head output](/images/data_head.png)

To check if we are on the right track, we can look at the number of rows and columns in the data and verify it with the actual numbers. 

```
data.shape
```

The output should be (1067371, 8).

##### Data Pre-processing

For the data to be of the same format, we strip the *Description* column of extra spaces while converting it to string type.

```
data['Description'] = data['Description'].str.strip() 
```

If we observe the data carefully, we observe that some of the transactions are Credit transactions and such transactions have invoice number which contains a *'C'* in the beginning. We need to remove such transactions as they do not count towards sales.

```
data['Invoice'] = data['Invoice'].astype('str') 
data = data[~data['Invoice'].str.contains('C')] 
```

In this code snippet, we convert the *Invoice* column into string type before finding if it contains a 'C'.

##### Applying Apriori Algorithm

The next step is to apply the Apriori algorithm on the dataset. To do so, we can use the apriori function that we imported from the *mlxtend* library.

The sales and thus, the association rules will be different in different countries. For example, people in Saudi Arabia will probably buy less number of winter clothes than the people in Canada. So we will make baskets (subset of items) according to countries.
Let's start with finding what are the countries which are included in the data.

```
data.Country.unique()
```

We can create baskets for each country by executing the following code:

```
basket_USA = (data[data['Country'] =="USA"] 
          .groupby(['Invoice', 'Description'])['Quantity'] 
          .sum().unstack().reset_index().fillna(0) 
          .set_index('Invoice'))
```

Here, we have filtered the data according to the country. We need to group the data according to *Invoice* number and *Description* and structure the data such that for each invoice, we can give a value *(Quantity)* to each item based on whether it is bought. If a certain item is bought in a transaction, we put the *quantity* or else a *0*. 

Because, we are not concerned with the Quantity of the product sold, we convert the values to *0* or *1* indicating *False* or *True* respectively. It shows if the product is sold in a particular transaction.

```
def hot_encode(x): 
    if(x<= 0): 
        return 0
    if(x>= 1): 
        return 1
        
basket_encoded = basket_USA.applymap(hot_encode) 
basket_USA = basket_encoded
```

Using the apriori function, and also assuming the support threshold to be *0.06*, we find the frequent item sets.

```
frq_items = apriori(basket_USA, min_support = 0.06, use_colnames = True)
```

To find the association rules, we use the *association_rules()* function. We pass the frequent item sets as one of the parameters. We use the **Lift** metric and set the minimum threshold to be 1.2.

```
rules = association_rules(frq_items, metric ="lift", min_threshold = 1.2)
rules = rules.sort_values(['confidence', 'lift'], ascending =[False, False]) 
```

We also sort the rules based on the confidence value and the lift metric value such that the rules with higher confidence and lift are shown on the top.

Let us see how the rules table looks. Execute the following code and you should get an output similar to the image shown below.

```
rules.head(6)
```

![rules_head output](/images/rules_head.png)

For example, here it shows that if a customer in USA buys a *Mini Paint Set Vintage*, he/she will most likely buy *60 Cake Cases Dolly Girl Design*.

The support value for the first rule is 0.1. This number is calculated by dividing the number of transactions containing *Mini Paint Set Vintage* divided by total number of transactions. The confidence level for the rule is 1.0 which shows that out of all the transactions that contain *Mini Paint Set Vintage*, 100% of the transactions also contain *60 Cake Cases Dolly Girl Design*. Finally, the lift of 10.0 tells us that *60 Cake Cases Dolly Girl Design* is 10 times more likely to be bought by the customers who buy *Mini Paint Set Vintage* compared to the default likelihood of the sale of *60 Cake Cases Dolly Girl Design*.

You can try this for other countries and find interesting association rules while changing the threshold values as required.

## Conclusion

* Audiences are able to understand the basic concept of association mining
* Audiences are able to know how to implement the basic association mining instance with Apriori Algorithm in Python which includes: 
1. Correctly import the dataset
2. Understanding the dataset
3. Preprocessing the dataset
4. Implementing Apriori Algorithm
5. Evaluation of the model
* Use of association mining in the real world to boost the businesses, especially retail sellers
* Audiences may extend their thinkings of association mining in a broader way and fields, such as internet ads, promotional discounts, etc

Apriori algorithm is very useful for finding simple correlations between the data items. It is easy to implement and is simple to understand. However, for more faster algorithms, more complex algorithms such as [SON algorithm](https://smartech.gatech.edu/bitstream/handle/1853/6678/GIT-CC-95-04.pdf?sequence=1&isAllowed=y) and [FP-Growth](https://en.wikipedia.org/wiki/Association_rule_learning#FP-growth_algorithm) algorithms are used.

#### References
1. Association Rule Mining via Apriori Algorithm in Python. [https://stackabuse.com/association-rule-mining-via-apriori-algorithm-in-python/](https://stackabuse.com/association-rule-mining-via-apriori-algorithm-in-python/)
2. Montana Tech CSCI347 Jupyter Notebook and Association Rules. [https://katie.mtech.edu/classes/csci347/Schedule/hm03_ans.pdf](https://katie.mtech.edu/classes/csci347/Schedule/hm03_ans.pdf)
