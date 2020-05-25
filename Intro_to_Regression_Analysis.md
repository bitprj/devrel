# Intro to Regression Analysis: Predicting Blood Pressure

## What is Supervised Learning?
       
Hello there. I see that you're very interested in finding interesting applications of using Statistics to solve many
problems in the world. Well this is where machine learning comes in. Now what is machine learning? Machine learning is a
subset of artificial intelliegence where the user allows the computer to make predictions on its own without the programmer explicitly telling
it to do so. A common form of machine learning that we will cover in this article will be supervised learning. So now you're also
wondering, "What is supervised learning?" Supervised learning is a form of machine learning where the user trains the computer to make
predctions based on labeled categories of data in a given dataset. The form of supervised learning that we will cover today will be linear regression.

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
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
sns.set()

diabetes = load_diabetes()
```

The next step would be to convert the dataframe into a pandas dataframe to create the dataset into tabular form and will define our column names as the feature names of the built in dataset.

```python
#Converting dataset to Pandas Dataframe
diabetes_data = pd.DataFrame(diabetes.data, columns = diabetes.feature_names)
```

The next step would be to check the shape of the dataframe to see how large it is.

```python
#Seeing the shape of the dataframe
diabetes_data.shape
```

![](https://www.picturepaste.ca/images/2020/05/25/Diabetes-Shape.png)

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

#Split the data into 80% training and 20% testing. 
#The random_state allows us to make the same random split every time.
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.2,random_state=327)
print('Training data size: (%i,%i)' % X_train.shape)
print('Testing data size: (%i,%i)' % X_test.shape)
```

![](https://www.picturepaste.ca/images/2020/05/25/Diabetes-ML-Shape.png)

Now we can scale the training and testing data to give it a mean of 0 and a standard deviation of 1. We should also print the results to find the training set mean and standrd deviation.

```python
#Scale the data to give a mean of zero and a unified standard deviation
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)
print('Training set mean by feature:')
print(X_train.mean(axis=0))
print('Training set standard deviation by feature:')
print(X_train.std(axis=0))
```
![](https://www.picturepaste.ca/images/2020/05/25/Training-Set.png)

As we can see here, the training set mean is equal to and 0 the standard deviation is equal to 1.

Now we can train the data using a linear regression model as shown here.

```python
#Fitting the Regression Model
regression_model = LinearRegression()
regression_model.fit(X_train,y_train)
```

![](https://www.picturepaste.ca/images/2020/05/25/Diabetes-Linear-Regression.png)

Now we shall look at the coefficients of each feature to interpret what happens for each increase in a feature.

```python
#Finding the coefficients of each feature
intercept = regression_model.intercept_
coef = pd.DataFrame(regression_model.coef_, index=diabetes.feature_names, columns=['Coefficients'])
print('Intercept = %f\n' % intercept)
print(coef)
```

![](https://www.picturepaste.ca/images/2020/05/25/Diabetes-Coefficients.png)

We can see here that the y-intercept (B0) for the function is 15127.195467, which equals to the mean Blood Pressure level for all of the training data when their coefficients are set equal to the mean values (which are zero). The sign difference for each coeffcient should also be taken into account such as an increase in age results in an increase in the median blood pressure level and the increase in T-Cells (s1 column) results in a decrease in the median blood pressure level. These type of factors make senes becaue the older you get, the more likely that you will be frail in health and T-Cells actively try to improve your immune system to stay healthy. 

Now we're going to test the model on new data. We do this by creating a variable called `y_pred` which contains the predicted median Blood Pressure levels and we use this against `y_test` which contains the true Blood Pressure levels. We would also need to calculate the RMSE to see how much our model varies from the true median Blood Pressure level.

```python
#Testing the validity of the performance of our model by seeing how far off it is from the true  median Blood Pressure level
y_pred = regression_model.predict(X_test)
test_rmse = np.sqrt(mean_squared_error(y_test, y_pred))
print('Test RMSE: %f' % test_rmse)
```

![](https://www.picturepaste.ca/images/2020/05/25/Diabetes-RMSE.png)

The RMSE score means that the error in the predicted median blood pressure level is by approximately 5528 mmHg. Given that the range of blood pressure levels is between 25000 mmHg and 34600 mmHg this is an ordinary difference. The reason as to what may cause this difference in the first place might be that either the relationship between the features and the predicted values aren't perfectly linear or some of the features don't correlate very well with the median blood pressure level. To truly figure out where our model stands in terms of fitting the best line of fit, we shall plot the model as shown below. 

```python
#Predicted vs Actual Median Blood Pressure level for Diabetes dataset
plt.scatter(y_test,y_pred)
plt.plot([2500,34600],[2500,34600],'r',lw=2)
plt.xlabel('Actual Blood Pressure')
plt.ylabel('Predicted Blood Pressure')
plt.show()
```

![](https://www.picturepaste.ca/images/2020/05/23/Blood-Pressure-Regression-Line.png)

As we can see here, in the lower end of the line of best fit, the model tends to overpredict what the median blood pressure level is (most of the data points are above the line of best fit) and at the higher end, the model tends to underpredict what the median blood pressure level is (most of the data points are below the best line of fit). Overall, our model could have done a much better job in terms of making the predictions much closer to the true median blood pressure level, but at least you're now aware about what factors to take account for when you're creating you're linear regression model.
