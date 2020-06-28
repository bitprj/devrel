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
chest = read.csv("C:\\Users\\ugoch\\Downloads\\usa_county_wise.csv\\Bit Project Supervised Learning\\heart.csv")
#Looks at first 6 rows of dataset
head(chest)
```

![](https://i.paste.pics/5aa972ef76be7d8a186ebd0fc26ed856.png)

As we can see, the data set consists of 14 columns of the necessary factors that affect the patients chances of being diagnosed for heart disease. The next step would be to look at the summary statistics of the given columns.

```r
#Summary Statistics
summary(chest)
```

![](https://i.paste.pics/b299da2b3dd62763ce03138a6b7be6fa.png)

Now that we can see the values of the summary statistics, we shall look into the column names of the dataset to see what specfic features would be best to build out model with.

```r
#Names of the features
names(chest)
```

![](https://i.paste.pics/a2cd4df73adf6445780054f01aca4fde.png)

As you can see here, these are the 14 features that our dataset has. In terms of what columns would seem necessary to fit our model against, we should use the target column since it's our dependent variable in the dataset, sex to classify in terms of the two sexes in the dataset, cp (chest pain type) because the severe level of chest pain can affect the accuracy of the diagnosis (angina could be the real problem rather than heart disease), thalach (maximum heart rate) because the heart could be misconstrued for over exercising, oldpeak (ST depression levels) to measure the control of the heart rate itself, and ca (number of blood vessels colored by fluoroscopy) because we want to measure the levels of cholesterol plaque build up that's accumlate in each patient's blood vessels.

Now that we have covered what metrics seem to make the most sense, we can now start creating the logistic regression model by making a train-test split of a level of 70% and fitting the model directly.

```r
#Train-Test Split by 70%
sample_size = sample.split(chest$target,SplitRatio=0.70)
train=subset(chest,sample_size==TRUE)
test=subset(chest,sample_size==FALSE)
#Logistic Regression Model
Diagnosis_fit=glm(target~sex+cp+thalach+oldpeak+ca,train,family=binomial())
summary(Diagnosis_fit)
```

![](https://i.paste.pics/a8e695c39f63edb05544e7686fc4fac7.png)

Now these are the summary statistics of the logistic regression model given. The P-value (Pr(>|z|)) of the selected columns are all less than the significance level, 0.05, so they're all significant values for factoring out the determination of diagnosis. 

Now we shall predict the target value for our dataset using the testing data.

```r
#Creating the prediction variable
Diagnosis_pred = predict(Diagnosis_fit,test,type="response")
prediction = as.data.frame(Diagnosis_pred)
categorise=function(x){
  return(ifelse(x>0.5,1,0))
}

prediction = apply(prediction,2,categorise)
head(prediction,10)
```

![](https://i.paste.pics/1c6e7ce8081c0e0394b38f5805db6323.png)

We can now see the first 10 rows of the binary values of the target column with in our dataset (1 = misdiagnosed, 0 = diagnosed)

The final step would be to create the confusion matrix to determine the true/false postive and the true/false negatives values of the patients' diagnosis, the accuracy level of the logistic regression model itself, and the confidence interval of the true accuracely level of how the logistic regression model performs.

```r
#Creating the confusion matrix that will also give the accuracy level
confusionMatrix(as.factor(test$target),as.factor(prediction))
```

![](https://i.paste.pics/cd29f1cbf3e96a02d6ddc44e958bae00.png)

This is the numerical information regarding the confusion matrix of our logistic regression model. We can see that that the accuracy level is 80.22% (Accuracy : 0.8022), which means that our model has a high accuracy level of predicting the proper diagnosis of heart disease patients. The 95% confidence interval is between 70.55% to 87.94% (95% CI : (0.7055, 0.8784)) which means that overall, model is fairly accurate since the range of accuracy is much higher than 50%. In terms of the true/false postive and the true/false negative values of each patient's diagnosis, we can look at the true positive rate by looking at the Pos Pred Value entry, which is 0.8049 (80.49%). We can also look at the false positive rate by doing 1 - (Pos Pred Value) which would give us 0.1951 (19.51%). This means that 80.49% of patients were correctly diagnosed to have heart disease and 19.51% of patients were incorrectly diagnosed with heart disease (true postive diagnosed patients = 40, false positive diagnosed patients = 8). As for the true negative rate, we can use the Neg Pred Value entry, which is 0.8000 (80%). We can also look for the false negative rate by doing 1 - (Neg Pred Value) which would give us 0.2000 (20%). This means that 80% of patients were correctly misdiagnosed for heart disease and 20% of patients were incorrectly misdiagnosed for heart disease (true negative misdiagnosed patients = 33, false negative misdiagnosed patients = 10). So if we were to add the total amount of patients that actually have heart disease, it would be 50 people in total (40 + 10 = 50) and if we were to add the total number of people that don't have heart disease, it would be 41 in total (33 + 8 = 41). We can see that the majority of pateints do have heart disease, but there is a moral consequence of clasification error. A false positive for diagnosis would mean that the doctor would waste time and resources on a patient that they believe has heart disease, when they're actually fine. A false negative would mean that the doctor would ignore patients that they believe were misdiagnosed, but they are in dire need of help and cold die of a heart attack at any minute without aid. Luckily it was only a small percent of patients that fall into both groups, but it's still a risky error a doctor can make on the livelihood of their patients.

Overall, logistic regression is a very important machine learning model to implement so that we can determine what perspective binary hroups does our data belong in and that we can avoid as much classification error as possible when conducting the process.
