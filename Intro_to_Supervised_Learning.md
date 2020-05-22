# Intro to Supervised Learning by, Jeffrey Ugochukwu

## What is Supervised Learning?
       
Hello, fellow reader. I see that you're very interested in finding interesting applications of using Statistics to solve many
problems in the world. Well this is where machine learning comes in. Now what is machine learning, you may ask? Machine learning is a
subset of artificial intelliegence where you allow the computer to make predictions on its own without the programmer explicitly telling
it to do so. A common form of machine learning that we will cover in this article will be supervised learning. So now you're also
wondering, "What is supervised learning?" Supervised learning is a form of machine learning where you train the computer to make
predctions based on labeled categories of data in a given dataset. The 2 forms of supervised learning that we will cover today will be
regression and classification models.

## Regression vs. Classification
Before we dive right into the difference between the terms "regression" and "classification", let's define the two terms
individually to get a stronger bearing on the two. Regression is about estimating the relationship between the dependent variable
(the variable we're measuring the outcome of) and the independent variable (the varible we're predicting). Classification refers to what
specific category does specfic data belong in. Now in terms of what makes both of them similar is that they both share the common goal of
accurately predicting the value of the labels in your dataset. For the differences, regression is completely based on quantitative values
(income for currency, mileage of a car, number of cases of a disease, etc...) whereas classification is based on categorical values (binary
values such as yes/no and different shoe brands (Nikes, Jordans, Vans). So now you know the basic understanding of what the two models are
about. Now let's explain the factors on what makes a specific model appropriate to use.

## When to use a Specific Supervised Learning Model
So now you're probably wondering, "This seems nice and all, but how do we know when to use a specific model for a desired outcome?"
Well the answer to that is based on these factors:
- The size of the data would matter since a large sample size would lead to less variability compared to a small sample size
- Distribution of data
- The type of relationship between the labels and features of dataset (linear, non-linear, etc...)
- Data format such as structured data (csv files, txt files, etc...) and unstructured data (json files, audio files, etc...)
- Goal of the actual analysis itself

## Accuracy vs Interpretation
Now in terms of detecting the outcomes of our machine learning, we should take into account about the level of accuracy that our model creates and how much it inteprets what the true value should be. This is alo dependent on how flexible our model is, which means how much our fitted model varies from the data we have to train. The more flexible our model is, the less variation it has from the training data and it could fit more distributions of shapes towards the data, making it more accurate. The less flexible our model is, the more variation it has towards the data, which would fit less distributions of shapes towards the data, thus making it more interpretable 
(less accurate). 

## Regression Example with Scikit-learn
