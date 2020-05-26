<div align='center'>
  <img src='./img/0.png' />
</div>

## BEGINNING

Right now is a great time to learn web dev. HTML, CSS, and Javascript are the core trio of languages to learn when it comes to mastering front-end skills. If you’ve found this article, you have undoubtedly heard of React.js, the flashy and widely popular new `div` on the `block` (oh have a sense of humor pleasee). Over the past 5 years or so, React has quickly become the go-to JavaScript library for building dynamic web apps. I emphasize dynamic because “static” is becoming a thing of the past. Companies and consumers need websites that are flexible and can make UI and data changes seamlessly. Just think of your favorite destinations on the Internet (YouTube, Instagram, Facebook) and you will realize that these are in fact all dynamic web apps (more on this later). Now, I wrote this blog to answer the one question that is undoubtedly bouncing around in your mind—what’s with all the craze about React? This is something I didn’t understand when I first began learning React and I wish someone had told me. I’m a firm believer in understanding why you’re doing what you’re doing; thus I believe addressing this topic will definitely make you a better React developer and spur you on in your learning. Read on to find out!

<div align='center'>
  <img src='./img/7.jpg' />
  <p>Programmers love trees. React-ers are no different. Keep reading!</p>
</div>

## MIDDLE
What exactly is React (fun edition)? Let’s begin with the name itself. React is a tool that’s designed to “react” to any changes that the user makes when interacting with a web app, as long as they change app state and/or data. React is like an elegant flower dancing in the wind, constantly changing position but always staying intact. 

<div align='center'>
  <img src='./img/2.jpg' />
  <p>React is one with nature.</p>
</div>

What exactly is React (boring edition, also the one you should focus on)? React is a JavaScript library made for one purpose: to revolutionize and streamline how UIs are built. It’s essentially an extension of vanilla JS that comes with a small API serving as a medium between the programmer and the DOM (DOM stands for Document Object Model and is the tree structure that HTML uses to arrange elements on the page), using something called the Virtual DOM, which makes working with the DOM exponentially easier (more on this later).

<div align='center'>
  <img src='./img/6.png' />
  <p>Document Object Model is your friend.</p>
</div>

This is extremely useful for building web apps that need to change and re-render often. React allows us to simply tell it what we want to render and what changes to make, while it handles all the “how” grunt work under the hood. Without React, we’d have to do all of this heavy-loading ourselves. With React, we can focus on what we as developers care about most: the UI and logic.

Before the days of React, websites were mostly static and pretty boring. They mainly just displayed information and offered very little user interactivity, if any (think back to the early 2000s). Fast-forward to the early 2010s when social media apps began rapidly rising in popularity, and with that, a new way of building web apps was developed—Facebook created the React we all know and love. 

<div align='center'>
  <img src='./img/1.png' />
  <p>React is poppin'</p>
</div>

Whereas in the not-so-distant past, websites were compiled of several static, separate HTML pages, React introduced the single-page application paradigm—creating one HTML skeleton or template and dynamically injecting content into said template based on app state. Instagram is a quintessential example of a single-page app built with React. This is made possible because of JavaScript, which is a definite prerequisite to learning React. JavaScript is the sole focus of React, both syntactically and conceptually; HTML is kept relatively bare-bones, any elements will serve as empty containers for dynamically-passed data. 

<div align='center'>
  <img src='./img/3.png' />
  <p>We have React to thank for Instagram.</p>
</div>

React isn’t hard to learn if you have solid fundamentals in JavaScript. It’s syntactically very similar, with a few useful additions that make coding a lot more pleasant, one of them being JSX—this is basically the ability to write HTML code inside your React files. (You can also write CSS in React files, more on this and JSX later).

The key thing to understand about React is how it works. React encourages the creation of “reusable, composable, and stateful components.” Let me translate that as such: make components that can generalize into more specific use cases and make sure they have internal properties which handle the content they display. Now for the cool part: React components are designed to interact with each other, which means you can pass “props” between components in order to control what’s being rendered. You can even change the internal “state” of one component from another component. (In React, components are the building blocks of your app and can be written as either functions or objects.)

<div align='center'>
  <img src='./img/10.jpg' />
  <p>Now it all makes sense! Our elementary school teachers were trying to prep us all to become React developers!</p>
</div>

Another key thing to know is that React uses a tree hierarchy to internally structure your components, much like the DOM is a tree that structures HTML elements. This means that there is a root file (index.js) that extends into a tree of however-many parent and child components you want. This goes hand-in-hand with the idea of “generalizing components,” since components should get more and more general the closer you get to the root.

<div align='center'>
  <img src='./img/8.png' />
  <p>Gotta get back to our Roots.</p>
</div>

I will end this section on one final key point to understand about React. Remember when I mentioned the Virtual DOM at the start of this section? Well, it’s essentially a copy of the real DOM (HTML tree) that React stores in memory. React does this for efficiency’s sake: React makes changes directly to the Virtual DOM, and then renders just the differences between the Virtual DOM and the real DOM. With vanilla JS, the real DOM would need to re-render itself entirely on each update, which is computationally much more expensive. Don’t worry if this is slightly confusing—it should be, since React is a new way of thinking about web apps, but just know that React makes web dev life much easier.

<div align='center'>
  <img src='./img/5.png' />
  <p>The Virtual DOM compares itself to the real DOM and smartly changes only what needs to be changed.</p>
</div>

## END
If you got this far, congrats. You can stop reading. No, seriously, it’s all code and pictures from here on out in order to illustrate some fundamental features of React for you.

[ React class component ]

[ React functional component ]

[ React JSX ]

[ React inline CSS ]

[ React component with state ]

[ React component with props ]

[ Passing props ]

Hopefully you have a better understanding of what React is and why we use it. I highly encourage you to make your own React apps, no other way of learning compares in terms of enjoyment and how much you will learn in the process. Here are some great resources to get you started:

<a href='https://reactjs.org/tutorial/tutorial.html'>React Tic-Tac-Toe Beginner Tutorial</a>

<a href='https://www.freecodecamp.org/news/yes-react-is-taking-over-front-end-development-the-question-is-why-40837af8ab76/'>An article that goes more in depth on what this blog covers</a>

<a href='https://scrimba.com/p/p7P5Hd/Index'>Scrimba: A Great Interactive Resource for learning how to write React code</a>









