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
#Using Diabetes dataset to predict the median blood pressure level for diabetes patients
from sklearn.datasets import load_diabetes
diabetes = load_diabetes()
```

The next step would be to convert the dataframe into a pandas dataframe to create the dataset into tabular form and will define our column names as the feature names of the built in dataset.

```python
#Converting dataset to Pandas Dataframe
import pandas as pd
diabetes_data = pd.DataFrame(diabetes.data, columns = diabetes.feature_names)
```

The next step would be to check the shape of the dataframe to see how large it is.

```python
#Seeing the shape of the dataframe
diabetes_data.shape
```

```python
(442, 10)
```

We can now see here that there are 442 patients in totatl with 10 specific features.

Let's look at the first 5 rows to see what type of features that we're dealing with.

```python
#Looking at the first 5 rows of the dataset
diabetes_data.head()
```

![](https://www.picturepaste.ca/images/2020/05/22/Diabetes-Columns.png)

We can see that the 10 features would be 
- age: the age of the patient
- sex: the sex that the patient belongs too
- bmi: the patient's body max index
- bp: average blood pressure
- s1: T-Cells (a type of white blood cell)
- s2: low density lipoproteins
- s3: high density lipoproteins
- s4: tch (thyroid stimulating hormone)
- s5: lamotrigine (medication to can control blood pressure levels)
- s6: blood sugar level

Since the median blood pressure level isn't a given column in this dataset, we can create through expressing it this way.

```python
#Creating Blood Pressure column to signify the median blood pressure level because it wasn't given in our dataset
diabetes_data["Blood Pressure"] = diabetes.target*100
```

Now we're going to add the column in our given dataset and also calculate the summary statistics to measure the percentiles of each category.

```python
#Adding the new column into the original data set and looking at the summary statistics
diabetes_data.describe().transpose()
```

![](https://www.picturepaste.ca/images/2020/05/22/Diabetes-Summary-Statistics.png)

Now we can see here that every value is scaled differently. We want to scale each feature with an equal metric because this would give our machine learning model less ambuguity when it interprets the main data given. The method that we can use to solve this problem would
be to standardize each feature to have a mean of 0 and a standard deviation of 1. This would give our coefficients a higher level of intepretability.

Now we're going into the split the data for testing and training. The reason as to why we would seperate our data into two groups is because the testing data is new data that the model hasn't seen before so it would use that as a basis to predict the median blood pressure level whereas the training data is familiar to the model. This would defeat the purpose of this procedure since this would mean that our model will only make predictions based on what it knows rather then working with any form of data that's unfamiliar to it. To create the actual model, we first would need to create the x variable for fetaures (in this case, the last index of the entire dataset) and the y variable for the actual Blood Pressure column. Then we will call the `train_test_split()` to split our data for x and y for testing and training. We will set 80% of the data for training and 20% of it for testing (explains why `test_size = 0.2`). Now that the conceptual material has been explained, let's find the size of our testing and training data.

```python
#Setting up our data for training and testing
X = diabetes_data.iloc[:,:-1]
y = diabetes_data["Blood Pressure"]

from sklearn.model_selection import train_test_split
#Split the data into 80% training and 20% testing. 
#The random_state allows us to make the same random split every time.
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.2,random_state=327)
print('Training data size: (%i,%i)' % X_train.shape)
print('Testing data size: (%i,%i)' % X_test.shape)
```

```python
Training data size: (353,10)
Testing data size: (89,10)
```

Now we can scale the training and testing data to give it a mean of 0 and a standard deviation of 1. We should also print the results to find the training set mean and standrd deviation.

```python
#Scale the data to give a mean of zero and a unified standard deviation
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)
print('Training set mean by feature:')
print(X_train.mean(axis=0))
print('Training set standard deviation by feature:')
print(X_train.std(axis=0))
```
```python
Training set mean by feature:
[-1.76126032e-17  7.54825852e-18  1.00643447e-17  5.03217235e-17
 -2.89349910e-17  2.26447756e-17 -5.03217235e-18  1.25804309e-17
 -7.54825852e-18 -2.01286894e-17]
Training set standard deviation by feature:
[1. 1. 1. 1. 1. 1. 1. 1. 1. 1.]
```

As we can see here, the training set mean is equal to and 0 the standard deviation is equal to 1.

Now we can train the data using a linear regression model as shown here.

```python
#Fitting the Regression Model
from sklearn.linear_model import LinearRegression
regression_model = LinearRegression()
regression_model.fit(X_train,y_train)
```

```python
LinearRegression(copy_X=True, fit_intercept=True, n_jobs=None, normalize=False)
```

Now we shall look at the coefficients of each feature to interpret what happens for each increase in a feature.

```python
#Finding the coefficients of each feature
intercept = regression_model.intercept_
coef = pd.DataFrame(regression_model.coef_, index=diabetes.feature_names, columns=['Coefficients'])
print('Intercept = %f\n' % intercept)
print(coef)
```

```python
Intercept = 15127.195467

     Coefficients
age    168.813322
sex  -1079.915788
bmi   2480.399465
bp    1378.119030
s1   -3108.492284
s2    1763.874470
s3     278.482641
s4     685.792186
s5    3799.116004
s6     109.684471
```
We can see here that the y-intercept (B0) for the function is 15127.195467, which equals to the mean Blood Pressure level for all of the training data when their coefficients are set equal to the mean values (which are zero). The sign difference for each coeffcient should also be taken into account such as an increase in age results in an increase in the median blood pressure level and the increase in T-Cells (s1 column) results in a decrease in the median blood pressure level. These type of factors make senes becaue the older you get, the more likely that you will be frail in health and T-Cells actively try to improve your immune system to stay healthy. 

Now we're going to test the model on new data. We do this by creating a variable called `y_pred` which contains the predicted median Blood Pressure levels and we use this against `y_test` which contains the true Blood Pressure levels. We would also need to calculate the RMSE to see how much our model varies from the true median Blood Pressure level.

```python
#Testing the validity of the performance of our model by seeing how far off it is from the true  median Blood Pressure level
from sklearn.metrics import mean_squared_error
import numpy as np
y_pred = regression_model.predict(X_test)
test_rmse = np.sqrt(mean_squared_error(y_test, y_pred))
print('Test RMSE: %f' % test_rmse)
```

```python
Test RMSE: 5527.810024
```

The RMSE score means that the error in the predicted median blood pressure level is by approximately 5528 mmHg. Given that the range of blood pressure levels is between 25000 mmHg and 34600 mmHg this is an ordinary difference. The reason as to what may cause this difference in the first place might be that either the relationship between the features and the predicted values aren't perfectly linear or some of the features don't correlate very well with the median blood pressure level. To truly figure out where our model stands in terms of fitting the best line of fit, we shall plot the model as shown below. 

```python
#Predicted vs Actual Median Blood Pressure level for Diabetes dataset
import matplotlib.pyplot as plt
import seaborn as sns
sns.set()
plt.scatter(y_test,y_pred)
plt.plot([2500,34600],[2500,34600],'r',lw=2)
plt.xlabel('Actual Blood Pressure')
plt.ylabel('Predicted Blood Pressure')
plt.show()
```

![](https://www.picturepaste.ca/images/2020/05/23/Blood-Pressure-Regression-Line.png)

As we can see here, in the lower end of the line of best fit, the model tends to overpredict what the median blood pressure level is (most of the data points are above the line of best fit) and at the higher end, the model tends to underpredict what the median blood pressure level is (most of the data points are below the best line of fit). Overall, our model could have done a much better job in terms of making the predictions much closer to the true median blood pressure level, but at least you're now aware about what factors to take account for when you're creating you're linear regression model


## Classification Example with Scikit-learn

We're now going to make a classification model using the heart disease dataset from the UCI Machine Learning repository. We want to predict what group of people were diagnosed correctly with heart disease and what group of people where misdiagnosed with heart disease. The model we would use would be logistic regression since it works very well with categorical variables and it helps measure the probablity where some data points will belong in one group or the other. We would set our probability level to be at 50% (p(x) = 0.5) where if a large group of data points are greater than 0.5, they will be labeled as misdiagnosed and if a large group of data points are less than 0.5, they will be labeled as diagnosed. The binary numbers that we will use to group these two categories will be that 1 = misdiagnosed and 0 = diagnosed. 

To messure the accuracy of the classification model, there are 2 methods that you can do it. You can calculate the error rate which is the percentage of correct classifications. Another way to calculate the accuracy of the model is to base it off on the types of correct and incorrect predictions for our binary variables. We shall break the terminology of those cases right below:

- A true positive means that the sample was correctly predicted to belong in the positive class (in this case, our postive class is being diagnosed with heart disease and that the patients were correctly diagnosed with the disease).
- A true negative means that the sample was correctly predicted to belong in the negative class (in this case, our negative class is being misdiagnosed and that the patients were correctly misdiagnosed).
- A false positive means that the sample was incorrectly predicted to belong in the positive class (this means that the patients were assumed to have heart disease, but they really don't).
- A false negative means that the sample was incorrectly predicted to belong in the negative class (this means that the patients were assumed to be misdiagnosed, but they actually have heart disease).

Both forms of measuring the accuracy of our logistic regression model are important because the accuracy score ensures that both the true postives and the true negatives equally matter and the correct and incorrect predictions would give us a better course of action on how to handle potentially dangerous mistakes in our study. For example, having a high number of falsely misdiagnosed cases is much worse than having falsely diagnosed cases because you're potentially letting people that are seriously ill live freely for their lives, but they could have a heart attack at any moment without treatment.

Now that we have explained the concept behind logistic regression, let's put this knowledge to practice. The first step would be to import the csv file regarding the heart disease cases.

```python
#Using the UCI Machine Learning Dataset to determine who has heart disease
import pandas as pd
heart_disease = pd.read_csv("heart.csv")
```

Now we're going to find the shape of the data set.

```python
#Finding the shape of the dataset
heart_disease.shape
```

```python
(303, 14)
```

We can see here that the dataset has 303 patients and 14 features. 

We should look at the first five rows of the dataset to see what we're dealing with.

```python
#Look at first 5 rows of heart disease dataset
heart_disease.head()
```

![](https://www.picturepaste.ca/images/2020/05/23/Heart-Disease-Summary-Statistics.png)

Here's a breakdown of all 14 features:

- age: the age of each patient
- sex: sex identity of each patient
- cp: chest pain type
- trestbps: resting blood pressure
- chol: cholestoral
- fbs: fasting blood sugar
- restecg: resting electrocardiographic results
- thalach: maximum heart rate achieved
- exang: exercise induced angina
- oldpeak: ST depression induced by exercise relative to rest
- slope: the slope of the peak exercise ST segment
- ca: number of major vessels
- thal: 3 = normal; 6 = fixed defect; 7 = reversable defect
- target: 1 or 0

The class column to represent the binary variables, 1 and 0, hasn't been included in this dataset. We will do this through creating the column as shown here.

```python
#Adding the class label to distingish between misdiagnosed patients with heart disease
heart_disease["class"] = heart_disease.target
```

Now we should look at the value counts to see how many people were grouped into binary varaible 1 (misdiagnosed) and binary variable 2 (diagnosed). 

```python
#Counting the amount of cases of heart disease (1 = people that have it, 0 = misdiagnosed)
pd.value_counts(heart_disease["class"])
```

```python
1    165
0    138
Name: class, dtype: int64
```

We can see here that there are 165 misdiagnosed cases and 138 diagnosed cases. This means that the majority of patients are deemed to not have heart disease. How accurately this was measured is what we will find out later.

We're going to find out about the summary statistics of our dataset with the new class column that we have created earlier.

```python
#Adding the class of binary varibles for level of diagnosis
heart_disease.describe().transpose()
```

![](https://www.picturepaste.ca/images/2020/05/23/Heart-Disease-Stats.png)

The next step now is to form a geometric boundary to determine where one group belongs for the binary variables. We will visualize this using matplotlib and we'll base our metric on the maximum heart rate achieved (thalach) because you can easily misinterpret this as over exercising, which could factor in on the diagnosis of each patient. Here is the visualization below.

```python
#Plotting the class of diagnosis
import matplotlib.pyplot as plt
import seaborn as sns
sns.set()
x = range(len(heart_disease["thalach"]))
y = heart_disease["thalach"]
plt.scatter(x,y,c=heart_disease["class"])
plt.xlabel("sample")
plt.ylabel("thalach")
plt.show()
```

![](https://www.picturepaste.ca/images/2020/05/23/heart-disease-graph.png)

We can see here that the bounday seems to be approximately at the x-axis at the sample size equaling 170. So if the x-axis values are less than 170, it would be considered to be misdiagnosed. If it's greater than 170, it would be considered as diagnosed.

We're now going to start to create the model using `test_train_split()` just like the regression example and our x value is based on the column for the maximum heart rate due potential misinterpretation due to over exercsing and our y value is based the class column that we have made earlier. We're also going check the size of our `X_test` and `X_train` variables

```python
#Training the heart disease model
X = heart_disease["thalach"].values.reshape(-1,1)
y = heart_disease["class"].values.reshape(-1,1)
from sklearn.model_selection import train_test_split
# Split the data into 80% training and 20% testing. 
# The random_state allows us to make the same random split every time.
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.2,random_state=327)
print('Training data size: (%i,%i)' % X_train.shape)
print('Testing data size: (%i,%i)' % X_test.shape) 
```

```python
Training data size: (242,1)
Testing data size: (61,1)
```

We're also going to scale the mean to 0 and the standard deviation to 1 for the features just like the regression model like so.

```python
#Scale the data so that it has a mean of zero and a uniform standard deviation
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)
print('Training set mean by feature:')
print(X_train.mean(axis=0))
print('Training set standard deviation by feature:')
print(X_train.std(axis=0))
```

```python
Training set mean by feature:
[2.67921589e-16]
Training set standard deviation by feature:
[1.]
```

Just like that, we have ensured that the features have a mean of approximately 0 and a standard deviation of 1.

