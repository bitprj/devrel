# Intro to Supervised Learning

## What is Supervised Learning?
       
Hello there. I see that you're very interested in finding interesting applications of using Statistics to solve many
problems in the world. Well this is where machine learning comes in. Now what is machine learning? Machine learning is a
subset of artificial intelliegence where the user allows the computer to make predictions on its own without the programmer explicitly telling
it to do so. A common form of machine learning that we will cover in this article will be supervised learning. So now you're also
wondering, "What is supervised learning?" Supervised learning is a form of machine learning where the user trains the computer to make
predctions based on labeled categories of data in a given dataset. The 2 forms of supervised learning that we will cover today will be
regression and classification models.

## Regression vs. Classification
Before we dive right into the difference between the terms "regression" and "classification", let's define the two terms
individually to get a stronger bearing on the two. Regression is about estimating the relationship between the dependent variable
(the variable we're measuring the outcome of) and the independent variable (the varible we're predicting). Classification refers to what
specific category does specfic data belong in. Now in terms of what makes both of them similar is that they both share the common goal of
accurately predicting the value of the labels in your dataset. For the differences, regression is completely based on quantitative values
(income for currency, mileage of a car, number of cases of a disease, etc...) whereas classification is based on categorical values (binary
values such as yes/no and different shoe brands (Nikes, Jordans, Vans). So now we have covered the basic understanding of what the two models are
about. Now let's explain the factors on what makes a specific model appropriate to use.

## When to use a Specific Supervised Learning Model
So how do we know when to use a specific model for a desired outcome?
Well the answer to that is based on these factors:
- The size of the data would matter since a large sample size would lead to less variability compared to a small sample size
- Distribution of data
- The type of relationship between the labels and features of dataset (linear, non-linear, etc...)
- Data format such as structured data (csv files, txt files, etc...) and unstructured data (json files, audio files, etc...)
- Goal of the actual analysis itself

## Accuracy vs Interpretation
Now in terms of detecting the outcomes of our machine learning, we should take into account about the level of accuracy that our model creates and how much it inteprets what the true value should be. This is also dependent on how flexible our model is, which means how much our fitted model varies from the data we have to train. The more flexible our model is, the less variation it has from the training data and it could fit more distributions of shapes towards the data, making it more accurate. The less flexible our model is, the more variation it has towards the data, which would fit less distributions of shapes towards the data, thus making it more interpretable 
(less accurate). 

## Regression Example with Scikit-learn
The regression model that we will create will be based on one of Scikit-learn's built in datasets called the Diabetes dataset. We want to predict the median blood pressure level of diabetes patients based on the given features of our dataset. The model we will use will be linear regression because since we're measuring quantitative variables and the values are continuous. Now to break down the componets of the linear regression formula, here's what it looks like below:

![](https://miro.medium.com/max/2872/1*k2bLmeYIG7z7dCyxADedhQ.png)

As we can see here, the Bi's (Beta i's) are the unknown coefficients from our dataset and going back to what you have learned from your Algebra and Pre-Algebra classes, B0 is the y-intercept of the function and B1 is the slope coefficent of the function and X1 is the actual slope. X1 is also the indepencdent variable in our dataset and Yi is the dependent variable in our dataset. Ei (Epsilon i) is the random error in our function where it measures how far off the datapoints of our function are from the bestline of fit.

So how do we determine the value of the Bi's? We determine the value of the Bi's through using the finding the Residual Sum of Squares (RSS). The Residual Sum of Squares is the sum of the amount of variations each data point has from the true value for the best line of fit. The RSS formula can be expressed as this:

![](https://cdn-images-1.medium.com/fit/t/1600/480/1*a0hsu_ldXOKOq88Re4xYtQ.png)

As you can see by this image that it's a summation of the linear regression function where each Xi is a different feature that's given in your dataset. The minimum RSS is achieved when the values of the true and predicted labels are very close which results in the creation of the Bi's.

To measure the accuracy of our model, we will use the Root Mean Square Error (RMSE) formula which is the square root of the RSS of each data point. The formula can be expressed as this:

![](https://secureservercdn.net/160.153.137.16/70j.58d.myftpupload.com/wp-content/uploads/2019/03/rmse-2.png)

Now that we have gotten over the important mathematical concepts to build the regression model, let's put this knowledge into practice. The first step is to import the built in Diabetes dataset from sckiit-learn.

```python
#Using Diabetes dataset to predict the average blood pressure level for diabetes patients
from sklearn.datasets import load_diabetes
diabetes = load_diabetes()
```

The next step would be to convert the dataframe into a pandas dataframe to create the dataset into tabular form and will define our column names as the feature names of the built in dataset.

```python
#Converting dataset to Pandas Dataframe
import pandas as pd
diabetes_data = pd.DataFrame(diabetes.data, columns = diabetes.feature_names)
```
