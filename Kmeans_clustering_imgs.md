# Extracting Information from Images Using K-Means Clustering

You’ve probably heard the phrase “a picture is worth a thousand words.” In our digitally-advanced age, this is more accurate than ever; a lot of information can be extracted from an image. High-level computer vision systems have allowed self-driving cars to recognize whether an object is a pedestrian crossing or a static road hazard up ahead, and Instagram filters are face-detecting and interactive. These advancements stem from the most of the fundamental approaches of machine learning.

Machine learning involves the learning process machines undertake in order to understand data and provide some answers about the data. In the context of image processing, an application of machine learning could be the attempt to process an image digitally, with numbers that represent the pixels and colors as data. 

Approaches that don't provide prediction or assume a correct set of outputs but instead uncover insights from a given dataset are referred to as unsupervised. One such technique for image processing and information extraction is Kmeans clustering, a learning approach that aims to partition **n** data points into **k** groups.

## Background on K-Means

The Kmeans clustering technique can be illustrated by the following rock collecting analogy. Suppose I’d like to separate a collection of rocks of various sizes and colors into 3 subgroups.


![](https://i.imgur.com/RArtpOd.png)
I start by randomly selecting 3 different rocks as models to represent each group.


![](https://i.imgur.com/5AY6skk.png)

I then group each of the remaining rocks with the 3 rock types based on size-similarity.

### First Iteration

Group 1            |  Group 2 | Group 3
:-------------------------:|:-------------------------: | :-------------------------:
![](https://i.imgur.com/zoMMoe2.png) | ![](https://i.imgur.com/YyzHfgL.png) | ![](https://i.imgur.com/6U05nSB.png)


Once I have 3 subgroups, I find the mean rock size of each group. The rocks that best exemplify the rock size of their respective group become the new model rock. Now I can reallocate the rest of the rocks based on size-similarity to the new models, and the size mean of each group is redetermined. This process repeats until the new mean of each group does not change significantly from the previous mean, meaning that the convergence point has been reached and are rocks are organized properly.

Some number of iterations later, the groups resulting from KMeans should be more homogeneous than its original mix. 
Group 1            |  Group 2 | Group 3
:-------------------------:|:-------------------------: | :-------------------------:
![](https://i.imgur.com/9jwvfLJ.jpg) |![](https://i.imgur.com/gSdctgw.jpg)|![](https://i.imgur.com/qz6MfeO.jpg)




# Now let's perform clustering on the first image

A restriction of this process is that we have only have access to digital images of rocks, not physical rock specimens themselves. So instead of size, we’ll cluster based on color.


If we consider the digital images as collections of data points that represent pixeled coordinates, we can try applying some math (K-Means) to those data points, represented as decimals organized as a table of some number of rows and columns

Before beginning the implementation,import these packages:

```
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import numpy as np
import cv2
from skimage import io
from google.colab.patches import cv2_imshow
```

## Data Processing

We start by reading in the *link* to the image we are interested in working with. 

```
url = "https://i.imgur.com/RArtpOd.png" #first image
img = io.imread(url)
```

To see the contents of these numbers, simply print them. You should see:

![](https://i.imgur.com/kPMrdqB.png)

It is also important to understand the size of image. In python, we have converted it to a numpy data storage type, using "io.imread()". To see its dimensions, run:

```
img.shape #(500, 500, 4)
```
A tuple containing the number of rows, columns and layers the image has is returned. You can think of each layer as a shade/filter of the image that gives the image its raw appearance.

Make a copy of the image we will cluster. This is in case we make modifications and want to preserve the original data.

```
img_init = img.copy() # save a copy of initial image, will modify this image for clustering
```

To view the image in its raw form:

```
plt.figure(figsize=(6, 6)) # plot initial image
plt.imshow(img_init)
```

We use *matplotlib*'s plotting function and *figsize=(6,6)* is just the size of our output viewing window in the colab notebook.


It should appear exactly as expected.

![](https://i.imgur.com/IltxwKj.png)



Reshape the image above into a workable format, such as a 2-dimensional shape

```
img = img.reshape((img.shape[0] * img.shape[1],img.shape[2])) 
```

## Model Fitting
Create an instance of the KMeans class. This basically means that grab the *KMeans* tool from our set of *sklearn* toolbox.

Suppose that we'd like to extract 5 groups or colors from our dataset, pass in *n=5* as a parameter.
```
k = 5
clt = KMeans(n_clusters = k) # "pick out" the K-means tool from our collection of algorithms
clt.fit(img) # apply the model to our data, the image
```

Fitting the model means to apply our tool, Kmeans, familiarizing our model with the contents of the data. The relationship between our data and the output is "learned" by the algorithm. [Standord](https://stanford.edu/~cpiech/cs221/handouts/kmeans.html) provides a detailed explanation behind the theory and implementation of this algorithm.


## Handling the output
The output of our model will need to be stored somehow. Create a numpy array that has length the number of clusters, starting at 0.


Let's observe what the model outputs so far after fitting. Run:


![](https://i.imgur.com/CZDhWav.png)

The first 3 datapoints belong to group *4* and the last 3 points belong to group *2*. Somewhere in between, there should be some assortment of 0s,1s, and 3s for the assigned group labels.



To represent the number of colors we want to observe and in what quantity they appear in the image, a histogram will be used to portray the proportions.


```
label_indx = np.arange(0,len(np.unique(clt.labels_)) + 1) 
```
Initializes an array of length == # clusters. These are the set the indices for the histogram

Each "data" point of the image array will consist of its own color class label, so we plot the frequency of each color.The more a certain color appears in an image, the more data points it will have associated with it

![](https://i.imgur.com/spfxuak.png)

Notice that the output of the above line are two arrays. At the moment, 67942 is the frequency that corresponds to the first class 0. 52586 corresponds to class 1. Grabbing only the first array, we name two variables below called "hist" and "_" and store both inside a tuple. "_" denotes empty storage as we do not need the secondary output.

Normalize the numbers within the array to get proportions that amount to 1. 

![](https://i.imgur.com/f6vJfk4.png)

The proportions for each class label. From above, the frequency count for some unknown color, 67942, makes up approximately 27% of all the colors. 

Next, create a grid to hold our colors and their proportionate components. 

```
hist_bar = np.zeros((50, 300, 3), dtype = "uint8") 
```
'Np.zeros()' initializes an array of some arbitary shape. Here, we choose a shape that spans 50 pixels in height and 300 pixels in length.

Loop over the percentage of each cluster and the color of each cluster. A loop is something that causes a command to repeat over and over for some duration, each time iterating over some variable, we iterate over 2 arrays containing the color frequencies and the cluster centers.

```
startX = 0
for (percent, color) in zip(hist,  clt.cluster_centers_): 
  endX = startX + (percent * 300) # to match grid
  cv2.rectangle(hist_bar, (int(startX), 0), (int(endX), 50),
      color.astype("uint8").tolist(), -1)
  startX = endX
```
Colors are identified with 'color.astype("uint8")' that converts the numbers into another color representation that tells Python that a certain number will be identified as a particular color. Remember that initially, we converted the image into its numerical representation. This is just the undoing of that first process.

```cv2.rectangle()``` builds the rectanglur grid, with sections that match the partitions of each color

## Plotting the output

Plot both the original image and its color/quantity extraction.

![](https://i.imgur.com/xDGKYlr.jpg)

The first gray group has the largest proportion, followed by a brownish/red group and so on... Exact colors are not extracted, but with artistic perception and some shading involved, you could probably achieve it!


If we enlarge our K to 10, we'll see a wider variety of colors seen in the image. 


![](https://i.imgur.com/dpGh5CL.png)


Testing for a new image for K = 5:

![](https://i.imgur.com/L3aNnM6.png)

Make note that the larger K is, the more computation and time it takes to complete



# Conclusion

By following the logic of KMeans clustering, we were able to automate the assortment of colors within an image. The digital image provides information only on the colors it possesses. By considering its pixeled coordinates and color features, we can specify the number of clusters we want to observe, fit the model based on that specified number, and return the colors and their proportions.

Going forward, if the dataset included information on the rock’s size and weight in grams, perhaps you could cluster based on size, fulfilling the intial analogy provided.

What other images can you try?

