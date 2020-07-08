# Introduction to Web Animations using CSS

In this blog, we are going to keep building our mini city. We will have a car going along the road and the bridge as well as a boat going under the bridge.

![](https://i.imgur.com/9FFPgkl.gif)



## Build the car and the boat

First, let's build our car and boat with HTML and CSS, just like we did for the ground and buildings before.
The car is a rectangle box, and the boat is a rectangle box with a triangle in the front. Both of them have a shadow to help show the 3D-effect.
So we need to have two divs for the car and the boat, and inside each of them, we will have some children divs. Children divs are divs inside a parent div. They are associated to their parent and can be easily aligned with their parent div. The two children divs under the car are to hold the left and front side rectangles while the three children divs under the boat are to hold the triangle in the front and the left and front side rectangles.

##### In HTML
```
<div class = "car">
    <div></div>
    <div></div>
</div>
    
<div class = "boat">
    <div></div>
    <div></div>
    <div></div>
</div>
```

##### In CSS
Now in CSS, try to build the car and the boat on your own by following the similar methods we used for the buildings.
We could build the rectangle body under `.car`. Remeber that the codes under `.car{/*codes*/}` will be applied to the entire class named `car`. Use `box-shadow: /*styles*/` [(refer to box-shadow syntax)](https://www.w3schools.com/cssref/css3_pr_box-shadow.asp) to create the shadow both under the car and the boat.
![](https://i.imgur.com/HRqlOB3.png)  ![](https://i.imgur.com/iHeoG1y.png)


After that, we could work on the child divs. We can refer to the first child and the second child of the car by using `.car div:first-child` and `.car div:nth-child(2)`. These divs are the two parallelograms on the sides and the additional triangle for the boat. The parallelograms are skewed from rectangles using `transform: skew(/*styles*/)` [(refer to skew() method)](https://www.w3schools.com/css/css3_2dtransforms.asp).
![](https://i.imgur.com/u8mhDsM.png)![](https://i.imgur.com/3Uu1ORO.png)


*if we did not talk about box-shadow before
Box-shadow for the boat
Since the boat is not a rectangular-shaped box, we could not*

(full css code here? or direct to the final code deliverables)


## Movements with CSS
Now that we have built our car and boat, we want them to move along the road and the ocean. We will do this by simply using CSS!
CSS is a style sheet with many strong features, and we will be using CSS `animation` and `@keyframes` to create our customized movements.

### CSS Animation
CSS animations have the following properties:
```
animation-name
animation-duration
animation-timing-function
animation-delay
animation-iteration-count
animation-direction
```
We could set these properties of the objects (e.g. the car and the boat) to make them move. The `animation` will gradually change the object from one set of styles to another, as indicated by the codes associated with the `animation-name`. This animation will last for the amount of time that you set `animation-duration` to. Also, we will use `@keyframes` to create our customized animation.

The above 6 properties can also be written shortened in 1 line in that order. For example,    `animation: example 5s linear 2s infinite alternate;`

Therefore, for the boat, we will have 
`animation: boat 15s linear infinite;` in the `.boat` , which means the boat will change from one style to another as `@keyframes boat` shows in 15 seconds, and then it will repeat infinite times.
Similarly, the car will have `animation: car 9s linear infinite;` to change the car as `@keyframes car` shows in 9 seconds and repeat.

### @keyframes
`@keyframes` will set the specific styles throughout the whole animation process. The whole process is indicated by `100%`, so we could set different styles at different stages to create the animation. The `0% {/*starting style*/}` shows the starting stage, where we want our boat to start at position `top: 60px; left: 20px;`. Then, we can set the ending position using `100% {/*ending style*/}`, where we are moving it to this position `top: 150px; left: 220px;`.



This is similar for the car, but we want the car to go onto the bridge; so, we break its route into 5 parts.
![](https://i.imgur.com/3EtTnGI.gif)

1. go straight along the road: 

    ```
    0% {
        top: 240px;
        left: -75px;
    }
    39% {
        top: 190px;
      left: 100px;
    }
    ```
2. climb on to the bridge:

    ```
    39% {
        top: 190px;
        left: 100px;
    }
    50% {
    	top: 170px;
        left: 150px;
    }
    ```
3. go along the bridge:

    ```
    50% {
        top: 170px;
        left: 150px;
    }
    65% {
    	top: 144px;
        left: 240px;
    }
    ```
4. go down the bridge:
   
    ```
    65% {
        top: 144px;
        left: 240px;
    }
    73% {
        top: 145px;
        left: 280px;
    }
    ```
5. go along the rest of the road: 
    ```
    73% {
        top: 145px;
        left: 280px;
    }
    100% {
        top: 95px;
        left: 450px;
    }
    ```
    
## Conclusion
Animation is one of the important features of CSS. CSS has many strong and interesting features, and we will discover more of them in the future.
