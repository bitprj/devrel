# Intro to Supervised Learning Outline

## Explain Classification vs Regression
-Classification deals with categorical variables (Binary labels such as yes or no, product brands, type of weather, etc...)
-Regression deals with quantitative variables (income, height, distance, etc...)

## Explain factors that affect which model would make sense to use
-Size of data
-Distribution of data
-Relationship between features and labels(linear or non-linear)
-Format of data (structured or unstructured)
-Primary goal of the analysis

## Model Accuracy vs Interpretability
-Accuracy is how much the model reaches the correct value
-Interpretability is how precise the model is
-The more flexible the model is, the more accurate it is
-The less flexible the model is, the more it interprets what it thinks is the correct value

## Supervised Learning through Regression Example
-Explain basics behind linear regression formula (y = B0 +BiXi) where the Bi's are the unknown coefficients and the Xi's are the non-linear features.
-Mention how Bi's are determined through the Residual Sum of Squares (RSS) formula
-Mention how accuracy of the model is calculated through the Root Mean Squared Error (RMSE) where you take the square root of the average RSS
-Go through dataset for regression
-Import the necessary libraries (pandas, scikitlearn, matplotlib, and numpy)
-First step would be to import the data and read it through pandas, show the shape of the values, and call the .head() function to see the first 5 rows
-Second step would be to make a "target" column for the specfic value that you want to analyze
-Mention differences between training and testing data (training is for familar data and testing is for new data for the model) to kick of the train_test_split portion of the blog
-Scale training data using StandardScalar() to give the training data a mean of zero and a uniform standard deviation
-Create the Linear Regession model on the training data using LinearRegression()
-Interpret coefficients using (negative coefficient = increase in x is a decrease in y, positive coefficient = increase in x is an increase in y)
-Find the RMSE in the dataset to test the model on the testing data
-If RMSE = 0, then literally every datapoint would fit on the regression line perfectly, but that's rarely the case.

## Supervised Learning through Classification Example
-Bi's are determined through the maximum likelihood method that proves how close they are to one of the binary varibles of logistic regression
-To measure accuracy of Classification: A true positive classification is one where we correctly predicted that a sample belonged to the positive class
-A true negative classification is one where we correctly predicted that a sample belonged to the negative class
-A false positive classification is one where we incorrectly predicted that a sample belonged to the positive class
-A false negative classification is one where we incorrectly predicted that a sample belonged to the negative class
-Import the necessary libraries (pandas, scikitlearn, matplotlib, and numpy)
-First step would be to import the data and read it through pandas, show the shape of the values, and call the .head() function to see the first 5 rows
-Second step would be to make a "target" column for the specfic value that you want to analyze
-Create value counts to determine how much would fit for variable 1 and for variable 0 of logistic regression model
-We need to create a classifier decision boundary in which we organize each sample to the right decision class (varible 1 or variable 0)
-Kick of the train_test_split portion of the blog
-Scale training data using StandardScalar() to give the training data a mean of zero and a uniform standard deviation
-Train the model using LogisticRegression()
-Interpret the coefficients but in this case it's more of a probability on where the samples lie for 1 or 0
-Test the model on new data
-Create a confusion matrix to represent the proportions of true positives, true negatives, false positives, and false negatives
