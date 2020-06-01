# Probability and Statistics

## What is a probability? Why do we learn probability and statistics in Machine Learning?

You are probably wondering why probability is a material in Computer Science and Machine Learning. But you are on the right page and here you are about to dive into the fundamental concepts of Machine Learning. Probability is the basis of lots of ML algorithms, such as Naive Bayes Algorithm and Expectation-Maximization algorithm, and much more.

How much do we need to know to implement these algorithms? We can start off with two basic concepts, Conditional Probability and Joint Probability and we can expand our knowledge as we go!


## Probability

Probability is an extent to which an event is likely to occur. A probability as a number lies between 0 and 1; 0 means that an event will NEVER happen, and 1 means that an event WILL happen. A probability of 0.3 means an event would happen with a 30% chance and will not happen with a 70% chance.

Often, we use a notation of P(A), which refers to the probability that event A will occur.

<font color='blue'>Pop Quiz:</font>
Suppose the probability that event B will occur is 0.25. Write this expression in a mathematical notation.



## Conditional Probability

Conditional probability is a measure of the probability of an event occurring given that another event has occurred. It’s denoted in a form of P(A|B), which refers to the probability that event A occurs given that event B has occurred.
    
Suppose that the probability that Hannah would bring an umbrella when it rains is 0.85. Let U represent the event that Hannah brings an umbrella and let R represent the event that it rains outside. This statement can be expressed as P(U|R) = 0.85
    
<font color='blue'>Pop Quiz:</font>
Suppose the probability that event B occurs given that event C has occurred is 0.7. Write this expression in a mathematical notation.



## Joint Probability

P(A and B) refers to the probability that event A and event B both occur. In a mathematical notation, we often use P(A ∩ B).
One thing to note is that P(A and B) = P(B and A) and P(A ∩ B) = P(B ∩ A).
    
But, P(A and B) will be different depending on the dependence of the two events.

If the outcome of an event is not dependent on the outcome of the other event, they are independent. 
    P(A and B) = P(A) * P(B)
    
If the outcome of an event affects the outcome of the other event as in the example of Hannah bringing an umbrella when it rains, they are dependent.
    P(A and B) = P(A|B) * P(B)
    
<font color='blue'>Pop Quiz:</font>
Given the following probabilities, calculate the probability that both events R and U (It rains outside AND Hannah brings an umbrella) occur. 
R: It rains outside. P(R) = 0.3
U: Hannah brings an umbrella. P(U) = 0.1
P(U|R) = 0.85


## Summary
In this chapter, you learned the basic concepts of probability, dependence and independence of events, conditional probability, and joint probability. Now you are ready to learn Bayes’ theorem, which uses all of these probabilities you just learned!
    
To learn about Bayes’ theorem, here is a helpful resource!
https://www.youtube.com/watch?v=XQoLVl31ZfQ

