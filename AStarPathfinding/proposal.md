**[Step-By-Step Technical Blog Guide](https://hq.bitproject.org/how-to-write-a-technical-blog/)**



\### :pushpin: Step 1

**TITLE:**  

Introduction to AI with A* Pathfinding



**TOPIC:**  

Artificial Intelligence



**DESCRIPTION (5-7+ sentences):**  

The A* algorithm is used for pathfinding in games and maps. Any time a programmer needs some entity to find the shortest distance from point A to point B, one of the go to algorithms to try first is A*.

A* is an extension on another algorithm Dijkstra's shortest path. A* differs in that it has knowledge about the location of its goal and estimates how far away it is which places it into the realm of artificial intelligence.

I create the environment first, then move to implementing the algorithm and finally add some visualization flair so the reader gets a more intuitive feel on how the algorithm works.



\### :pushpin: Step 2

:family: **TARGET AUDIENCE (3-5+ sentences):**  

Any programmer trying to find the shortest distance from point A to point B in a graph or grid. These would typically be people that are in game dev or robotics. I go over each piece of code and why it's needed so technically anyone should be able to follow it but I do not go over Python basics so I would not recommend this to someone that has not programmed before.



\### :pushpin: Step 3

\> Outline your learning/teaching structure: 



**Beginning (2-3+ sentences):**  

Introduce A*, some applications, how it works, and why it works. I add some pictures to illustrate the f(n) function and its components so the reader can see for themselves that the f(n) function makes sense.



**Middle (2-3+ sentences):**  

I move on to how I created the environment and show code snippets along the way. Then I implement A*. I explain it from the point of view of a 'lazy programmer'. By this I mean that when I create the environment with the Node and Grid classes I only add fields and methods related to the environment. Once I start the A* implementation do I add fields specific to A* and pathfinding to prevent frontloading too much information at once.



**End (2-3+ sentences):**  

After A* is done I move onto how the reader can visualize the algorithm which only requires a few more lines of code since most of the overhead was made along the way. I create a few suggestions the reader can work on if they are interested in building atop the code they have just written. Finally, as an extra aside I show the reader what happens when you mess around with the heuristic function to prove its importance and what happens when its overestimated.