# Intro to Logistic Regeression Modeling

## What is Logistic Regression

Hello there. Have you ever wondered how people were able to classify a large group of items into 2 categoires? Well this is the perfect article for you! The technique that is able to accomplish such a goal is called Logistic Regression. Now what is Logistic Regression, you may ask? Logistic Regression is a classification technique that determines what values in our data set belong within a binary group. You have seen certain examples of this throughout your life such as gender clasification (Boy/Girl), posotive and negative terminology (good/bad), and even when it comes to taking exams (pass/fail). This is a very important procedure to understand because you'll be able to correctly classify what groups does your data belong in to reduce any form of error.

## Logistic Regression of UCI Heart Disease Dataset

We're now going to make a classification model using the heart disease dataset from the UCI Machine Learning repository. We want to predict what group of people were diagnosed correctly with heart disease and what group of people were misdiagnosed with heart disease. The model we would use would be logistic regression since it works very well with categorical variables and it helps measure the probability where some data points will belong in one group or the other. We would set our probability level to be at 50% (p(x) = 0.5) where if a large group of data points are greater than 0.5, they will be labeled as misdiagnosed and if a large group of data points are less than 0.5, they will be labeled as diagnosed. The binary numbers that we will use to group these two categories will be that 1 = misdiagnosed and 0 = diagnosed. 

To measure the accuracy of the classification model, there are 2 methods that you can do it. You can calculate the error rate which is the percentage of correct classifications. Another way to calculate the accuracy of the model is to base it off on the types of correct and incorrect predictions for our binary variables. We shall break the terminology of those cases right below:

- A true positive means that the sample was correctly predicted to belong in the positive class (in this case, our positive class is being diagnosed with heart disease and that the patients were correctly diagnosed with the disease).
- A true negative means that the sample was correctly predicted to belong in the negative class (in this case, our negative class is being misdiagnosed and that the patients were correctly misdiagnosed).
- A false positive means that the sample was incorrectly predicted to belong in the positive class (this means that the patients were assumed to have heart disease, but they really don't).
- A false negative means that the sample was incorrectly predicted to belong in the negative class (this means that the patients were assumed to be misdiagnosed, but they actually have heart disease).

Both forms of measuring the accuracy of our logistic regression model are important because the accuracy score ensures that both the true positives and the true negatives equally matter and the correct and incorrect predictions would give us a better course of action on how to handle potentially dangerous mistakes in our study. For example, having a high number of falsely misdiagnosed cases is much worse than having falsely diagnosed cases because you're potentially letting people that are seriously ill live freely for their lives, but they could have a heart attack at any moment without treatment.

Now that we have explained the concept behind logistic regression, let's put this knowledge to practice. The first step would be to import the csv file regarding the heart disease cases and to read the first 6 rows of the dataset.

```r
#Load Dataset
library(dplyr)
library(caTools)
library(caret)
chest = heart
#Looks at first 6 rows of dataset
head(chest)
```

![](https://i.paste.pics/5aa972ef76be7d8a186ebd0fc26ed856.png)
