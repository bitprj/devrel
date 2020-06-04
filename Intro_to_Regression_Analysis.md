# Intro to Regression Analysis: Predicting Blood Pressure

## Introduction to Supervised Learning
       
If you're reading this blog post, you're probably interested in using statistics and computer science to approach real-world issues but don't know where to start. There are many fields that use both areas of study, such as data mining, data compression, and speech recognition. In this post, we'll be introducing a popular and approachable subset of artificial intelligence (AI) called machine learning. With machine learning, the user allows the computer to make predictions on its own without explicitly telling it to do so. Because there are many different types of machine learning, we'll only be focusing on supervised learning, in which the computer is trained to make predictions based on labeled categories of data in a given dataset. 

## Accuracy vs. Interpretation
In order to detect the outcomes of our machine learning, we should take into account the accuracy of our model and how much it inteprets what the true value should be. This is also dependent on the flexibility of our model, or how much our fitted model varies from the data we have to train. The more flexible our model is, the less variation it has from the training data, making it more accurate. The less flexible our model is, the more variation it has towards the data, making it more interpretable.

## Regression Example with Scikit-learn
The regression model that we'll create is based on one of Scikit-learn's built-in datasets, the Diabetes dataset. We want to predict the median blood pressure level of diabetes patients based on the given features of our dataset. We'll use a linear regression model because we're measuring quantitative variables and the values are continuous. Also, this specfic model answers questions that doctors would encounter with patients such as, "Given a patient's set of health characteristics such as age, blood sugar, or BMI, how would a doctor or biopharmceutical company predict blood pressure?" Here's what the breakdown of the linear regression formula looks like:
![](https://miro.medium.com/max/2872/1*k2bLmeYIG7z7dCyxADedhQ.png)

The Bi's (Beta i's) are the unknown coefficients from our dataset. B0 is the y-intercept of the function, B1 is the slope coefficent of the function, and X1 is the actual slope. X1 is also the independent variable and Yi is the dependent variable in our dataset. Ei (Epsilon i) is the random error in our function which measures how far off the data points of our function are from the line of best fit.

How do we determine the value of the Bi's? We find it by finding the Residual Sum of Squares (RSS). The RSS is the sum of the amount of variations each data point has from the true value of the line of best fit. The RSS formula can be expressed as this:

![](https://cdn-images-1.medium.com/fit/t/1600/480/1*a0hsu_ldXOKOq88Re4xYtQ.png)

This image is a summation of the linear regression function where each Xi is a different feature given in your dataset. The minimum RSS is achieved when the values of the true and predicted labels are very close. This results in the creation of the Bi's.

To measure the accuracy of our model, we will use the Root Mean Square Error (RMSE) formula, or the square root of each data point's RSS. The formula can be expressed as this:

![](https://secureservercdn.net/160.153.137.16/70j.58d.myftpupload.com/wp-content/uploads/2019/03/rmse-2.png)

Now that we've covered the necessary mathematical concepts to build the regression model, let's put this knowledge into practice. The Python packages that will be helpful to build our model are Scikit-learn, NumPy, Pandas, Matplotlib, and Seaborn. Scikit-learn has the necessary tools to carry out the calculations of our machine learning model. NumPy handles computations with lists and matrices of elements. Pandas manipulates the structure of our data. Matplotlib and Seaborn both help visualize our models, but Seaborn makes Matplotlib's visuals more asthetically pleasing and smooths out the outlines of drawn figures in our graphs. The first step is to import the built-in Diabetes dataset from Scikit-learn.

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

Next, convert the data frame into a Pandas DataFrame to make the dataset tabular and define our column names as the feature names of the built-in dataset.

```python
#Converting dataset to Pandas Dataframe
diabetes_data = pd.DataFrame(diabetes.data, columns = diabetes.feature_names)
```

Then, check the shape of the dataframe to see how large it is.

```python
#Seeing the shape of the dataframe
diabetes_data.shape
```

![](https://www.picturepaste.ca/images/2020/05/25/Diabetes-Shape.png)

There are 442 patients in total with ten specific features.

Let's look at the first five rows to see what type of features we're dealing with. We do this by using the command `diabetes_data.head()` and the `.head()` function call showcases only the first five rows of the dataset by default. You can specify a number inside the parentheses of the `.head()` function call if necessary.

```python
#Looking at the first 5 rows of the dataset
diabetes_data.head()
```

![](https://www.picturepaste.ca/images/2020/05/22/Diabetes-Columns.png)

We can see that the ten features would be: 
- Age: the age of the patient
- Sex: the sex of the patient
- BMI: the patient's body max index
- BP: average blood pressure
- s1: T-Cells (a type of white blood cell)
- s2: low density lipoproteins
- s3: high density lipoproteins
- s4: tch (thyroid stimulating hormone)
- s5: lamotrigine (medication to can control blood pressure levels)
- s6: blood sugar level

Since the median blood pressure level isn't a given column in this dataset, we can create it by expressing it this way. Even though we have the information regarding the average blood pressure across from each patient, we want to see how close our data is to the 50th percentile of the various levels of blood pressure across each patient.

```python
#Creating Blood Pressure column to signify the median blood pressure level because it wasn't given in our dataset
diabetes_data["Blood Pressure"] = diabetes.target*100
```

We're going to add the column to our given dataset and calculate the summary statistics to measure the percentiles of each category. To do this, we have to express the function as this `diabetes_data.describe().transpose()` where `.describe()` gives the summary statistics. `.transpose()` reorients the x and y columns to include the values of the `diabetes_data["Blood Pressure"]` when you read in on the summary statistics of the entire data frame.

```python
#Adding the new column into the original dataset and looking at the summary statistics
diabetes_data.describe().transpose()
```

![](https://www.picturepaste.ca/images/2020/05/22/Diabetes-Summary-Statistics.png)

Every value is scaled differently right now, but we want to scale each feature with an equal metric so that our machine learning model is less ambiguous when it interprets the main data given. To scale them with equal metrics, standardize each feature to have a mean of 0 and a standard deviation of 1. This will give our coefficients a higher level of interpretability.

Now, we're going to split the data for testing and training. We want to separate our data into two groups because the testing data is new data that the model hasn't seen before. The model uses the testing data as a basis to predict the median blood pressure level whereas the training data is already familiar to it. However, this defeats the purpose of this procedure since our model will only make predictions based on what it knows rather then working with any form of data that's unfamiliar to it. To create the actual model, we first need to create the x variable for features (in this case, the last index of the entire dataset) and the y variable for the actual Blood Pressure column. Then, we will call the `train_test_split()` to split our data for x and y for testing and training. We will set 80% of the data for training and 20% of it for testing (explains why `test_size = 0.2`). Now, let's find the size of our testing and training data.

```python
#Setting up our data for training and testing
X = diabetes_data.iloc[:,:-1] #.iloc[] indexes only integers in a list
y = diabetes_data["Blood Pressure"]

#Split the data into 80% training and 20% testing. 
#The random_state allows us to make the same random split every time.
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.2,random_state=327)
print('Training data size: (%i,%i)' % X_train.shape)
print('Testing data size: (%i,%i)' % X_test.shape)
```

![](https://www.picturepaste.ca/images/2020/05/25/Diabetes-ML-Shape.png)

Now, we can scale the training and testing data to give it a mean of 0 and a standard deviation of 1. We should also print the results to find the training set mean and standrd deviation. We do this using Scikit-learn's `StandardScaler()` package, which removes the mean, converts it to 0, and creates a unified standard deviation of 1.

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

The training set mean is equal to 0 and the standard deviation is equal to 1.

Now, we can train the data using a linear regression model as shown here. We do this using Scikit-learn's `LinearRegression()` package, which fits the models of the trained data using the `.fit()` function call.

```python
#Fitting the Regression Model
regression_model = LinearRegression()
regression_model.fit(X_train,y_train)
```

![](https://www.picturepaste.ca/images/2020/05/25/Diabetes-Linear-Regression.png)

Look at the coefficients of each feature to interpret what happens for each increase in a feature.

```python
#Finding the coefficients of each feature
intercept = regression_model.intercept_
coef = pd.DataFrame(regression_model.coef_, index=diabetes.feature_names, columns=['Coefficients'])
print('Intercept = %f\n' % intercept)
print(coef)
```

![](https://www.picturepaste.ca/images/2020/05/25/Diabetes-Coefficients.png)

The y-intercept (B0) for the function is 15127.195467, which equals to the mean Blood Pressure level for all of the training data when their coefficients are equal to the mean values (which equal to zero). The sign difference for each coeffcient should also be taken into account. For instance, an increase in age results in an increase in the median blood pressure level. An increase in T-Cells (s1 column) results in a decrease in the median blood pressure level. These factors make sense because the older you get, the more your health declines and T-Cells actively try to improve your immune system to stay healthy. 

Now, we're going to test the model on new data. We do this by creating a variable called `y_pred`, which contains the predicted median Blood Pressure levels, and we use this against `y_test`, which contains the true Blood Pressure levels. We also need to calculate the RMSE to see how much our model varies from the true median Blood Pressure level.

```python
#Testing the validity of the performance of our model by seeing how far off it is from the true  median Blood Pressure level
y_pred = regression_model.predict(X_test)
test_rmse = np.sqrt(mean_squared_error(y_test, y_pred))
print('Test RMSE: %f' % test_rmse)
```

![](https://www.picturepaste.ca/images/2020/05/25/Diabetes-RMSE.png)

The RMSE score means that the error in the predicted median blood pressure level is by approximately 5528 mmHg. Given that the range of blood pressure levels is between 25000 mmHg and 34600 mmHg, this is an ordinary difference. This difference occurred because the relationship between the features and the predicted values isn't perfectly linear, or some of the features don't correlate well with the median blood pressure level. 

To figure out where our model stands relative to the line of best fit, we must plot the model: 

```python
#Predicted vs Actual Median Blood Pressure level for Diabetes dataset
plt.scatter(y_test,y_pred)
plt.plot([2500,34600],[2500,34600],'r',lw=2)
plt.xlabel('Actual Blood Pressure')
plt.ylabel('Predicted Blood Pressure')
plt.show()
```

![](https://www.picturepaste.ca/images/2020/05/23/Blood-Pressure-Regression-Line.png)

At the lower end of the line of best fit, the model tends to overestimate what the median blood pressure level is (most of the data points are above the line of best fit). At the higher end, the model tends to underestimate what the median blood pressure level is (most of the data points are below the line of best fit). Overall, our model could have made the predictions much closer to the true median blood pressure level, but at least you now know what factors to look for when creating your linear regression model.
