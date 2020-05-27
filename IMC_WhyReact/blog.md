<div align='center'>
  <img src='./img/0.png' />
</div>

# What's with all the craze about React?

## A Little Intro

Right now is a great time to learn web dev. HTML, CSS, and Javascript are the core trio of languages to learn when it comes to mastering front-end skills. If you’ve found this article, you have undoubtedly heard of React.js, the flashy and widely popular new `div` on the `block` (oh have a sense of humor pleasee). Over the past 5 years or so, React has quickly become the go-to JavaScript library for building dynamic web apps. I emphasize dynamic because “static” is becoming a thing of the past. Companies and consumers need websites that are flexible and can make UI and data changes seamlessly. Just think of your favorite destinations on the Internet (YouTube, Instagram, Facebook) and you will realize that these are in fact all dynamic web apps (more on this later). Now, I wrote this blog to answer the one question that is undoubtedly bouncing around in your mind—what’s with all the craze about React? This is something I didn’t understand when I first began learning React and I wish someone had told me. I’m a firm believer in understanding why you’re doing what you’re doing; thus I believe addressing this topic will definitely make you a better React developer and spur you on in your learning.

<div align='center'>
  <img src='./img/7.jpg' width='600' />
  <p>Programmers love trees. React-ers are no different. Keep reading!</p>
</div>


## What IS React?
What exactly is React (fun edition)? Let’s begin with the name itself. React is a tool that’s designed to “react” to any changes that the user makes when interacting with a web app, as long as they change app state and/or data. React is like an elegant flower dancing in the wind, constantly changing position but always staying intact. 

<div align='center'>
  <img src='./img/2.jpg' width='600' />
  <p>React is one with nature.</p>
</div>


What exactly is React (boring edition, also the one you should focus on)? React is a JavaScript library made for one purpose: to make the creation of UIs way more efficient than older methods. It’s essentially an extension of vanilla JS that comes with a small but powerful API that serves as a medium between the programmer and the **DOM** (DOM stands for **Document Object Model** and is the tree structure that HTML uses to arrange elements on the page). Developers no longer have to manually communicate each little update to the browser; instead, developers simply tell React what to change and React uses something called the **Virtual DOM** to update the browser (more on this later).

<div align='center'>
  <img src='./img/6.png' width='600' />
  <p>Document Object Model is your friend.</p>
</div>


This is extremely useful for building web apps that need to change and re-render often. React allows us to simply tell it what we want to render and what changes to make, while it handles all the “how” grunt work under the hood. Without React, we’d have to do all of this heavy-lifting ourselves. With React, we can focus on what we as developers care about most: the UI and logic.

Before the days of React, websites were mostly static and pretty boring. They mainly just displayed information and offered very little user interactivity, if any (think back to the early 2000s). Fast-forward to the early 2010s when social media apps began rapidly rising in popularity, and with that, a new way of building web apps was developed—Facebook created the React library. 

<div align='center'>
  <img src='./img/1.png' width='300' />
  <p>React is poppin'</p>
</div>


Whereas in the not-so-distant past, websites were composed of several static, separate HTML pages with hard-coded content, React introduced the **single-page application** paradigm—creating one HTML skeleton or template and dynamically injecting content into said template based on app state. Instagram is a quintessential example of a single-page app built with React. 

<div align='center'>
  <img src='./img/3.png' width='400' />
  <p>We have React to thank for Instagram.</p>
</div>


Long gone are the days of hard-coding content into `div` and `p` tags. In React, HTML is kept relatively bare-bones, any elements will serve as templates that hold data which is dynamically-passed via JavaScript. That said, React wouldn't work without HTML; since HTML is still the skeleton of every website. It simply means the **focus** has shifted from writing static content to writing code that renders content based on UI state. 

React isn’t hard to learn if you have solid fundamentals in JavaScript. This is because JavaScript is the language that React uses; thus React and vanilla JS are syntactically and conceptually similar. However, there are many useful additions that make coding a lot more pleasant, one of them being **JSX**—this is basically the ability to write HTML code inside your React files. (You can also write CSS in React files, which is dubbed **inline-CSS**. More on this and JSX later).

The key thing to understand about React is how it works. React encourages the creation of “reusable, composable, and stateful components.” Let me translate that as such: make components that can generalize into more specific use cases and make sure they have internal properties which handle the content they display. Now for the cool part: React components are designed to interact with each other, which means you can pass **props** between components in order to control what’s being rendered. You can even change the internal **state** of one component from another component. (In React, components are the building blocks of your app and can be written as either functions or objects.)

<div align='center'>
  <img src='./img/10.jpg' width='400' />
  <p>Now it all makes sense! Our elementary school teachers were trying to prep us all to become React developers!</p>
</div>


Another key thing to know is that React uses a tree hierarchy to internally structure your components, much like the DOM is a tree that structures HTML elements. This means that there is a root file (index.js) that extends into a tree of however-many parent and child components you want. This goes hand-in-hand with the idea of “generalizing components,” since components should get more and more general the closer you get to the root.

<div align='center'>
  <img src='./img/8.png' width='600' />
  <p>Gotta get back to our Roots.</p>
</div>


I will end this section on one final key point to understand about React. Remember when I mentioned the Virtual DOM at the start of this section? Well, it’s essentially a copy of the browser DOM (HTML tree) that React stores in memory. React does this for efficiency’s sake: React makes changes directly to the Virtual DOM, and then renders just the differences between the Virtual DOM and the browser DOM. With vanilla JS, the browser DOM would need to re-render itself entirely on each update, which is computationally much more expensive. Don’t worry if this is slightly confusing, things will become more clear as you get more practice coding React. For now, just know that React makes web dev life much easier.

<div align='center'>
  <img src='./img/5.png' width='600' />
  <p>The Virtual DOM compares itself to the browser DOM and smartly re-renders only what has been changed (in red), instead of re-rendering the entire DOM.</p>
</div>

## When to React and when not to React?
I just spent many paragraphs describing what React is great at and how it has ushered in a new paradigm into the web dev universe. However, React doesn't need to be used for EVERYTHING web-related. For instance, if all you want is a simple blog site, making a React app would be gross overkill, at least for 99% of blogs out there. 

You should strongly consider React when you are building something that is **highly interactive**. This is exactly what React was built for. Projects like messenger apps, social media apps, board games, audio workstations, notetaking and productivity apps, etc. are where React will shine brightest.


## How-to React
Congrats for reaching this point in the blog! In this final section, I have included several code examples illustrating fundamental React concepts to get you familiar with the code. At the very end, I have included three great resources where you can learn more about React in depth. 

I have tried to make these examples as easy to follow as possible, but don't worry if some of the syntax is confusing. Instead, try to get a feel for how React code flows and is structured. 


1. React class component
```js
import React from 'react'; 
import ReactDOM from 'react-dom';

// Class components are essentially JavaScript objects
class NewComponent extends React.Component {
  
  // This is where content is rendered in the form of HTML or other React components
  render() {
    return (
      <div>hello</div>
    )
  };
};

ReactDOM.render(
  <NewComponent />,
  document.getElementById('root')
)
```


2. React functional component (more popular)
```js
// Functional components are becoming more popular than class components, since they are more flexible and can perform the same duties with less code.
function AnotherComponent() {

  // You don't need a render() {} block like in class components, just a return() function
  return (
    <div>hello</div>
  );
};

ReactDOM.render(
  <AnotherComponent />,
  document.getElementById('root')
)
```


3. React JSX
```js
let anime = 'Hunter x Hunter';

// A very simple example of JSX - assigning an HTML element to a variable
let element = <div>My favorite anime is {anime}.</div>;

ReactDOM.render(
  element,
  document.getElementById('root')
);
```

4. React inline CSS 
```js
let element = 
  <div 
    // Inline-CSS is written as a JavaScript object
    style={{
      border:'solid purple 2px', 
      padding:'5em',
      textAlign: 'center' // JSX uses camelCase syntax instead of hyphenating multi-word attributes like in vanilla CSS
    }}
  >
    My favorite anime is {anime}.
  </div>
ReactDOM.render(
  element,
  document.getElementById('root')
);
```

5. React component with state
```js
class ClassComponentWithState extends React.Component {
  constructor() {
    // Component's state is initialized here, in the constructor, as a JavaScript object
    this.state = {
      animes: [
        'Hunter x Hunter',
        'One Piece',
        'Neon Genesis Evangelion'
      ],
      recs: []
    };
    this.handleClick = this.handleClick.bind(this)
  };

  handleClick() {
    if (this.state.animes.length !== 0) {
      // Changing state happens here
      this.setState(state => ({
        animes: state.animes.slice(0, state.animes.length-1),
        recs: state.recs.push(state.animes[state.animes.length-1])
      }))
    }

    else {
      alert('We have no more anime recommendations for you today! Please return after you have finished watching the ones we have already given you. Good luck!')
    }
  }

  // Don't forget the render() {} block, since this is a class component!
  render() {
    // map() is an extremely useful Array function you will be using very frequently
    let recommended = recs.map(anime => <p style={{margin:'.5em'}}>{anime}</p>)

    // Actual content to be rendered is inside return()
    return (
      <div style={{display:'block', padding:'1.5em'}}>
        <button 
          style={{padding:'.5em', margin:'1em'}}
          onClick={this.handleClick}>
          Click to get new anime recommendation!
        </button>
        {recommended}
      </div>
    );
  };
};

ReactDOM.render(
  <ClassComponentWithState />,
  document.getElementById('root')
);
```

6. React component with props
```js
// If you want your component to be able to hold props, simply pass "props" as a parameter.
// Alternatively, you could omit "props" and individually put prop names within an object, and pass the object as a parameter to your component
function FunctionalComponentWithProps(props) {
  return (
    <div style={props.styles}>
      <h1>You should watch the following animes!</h1>
      {props.animes.map(anime => <p>{anime}</p>)}
    </div>
  )
}

// Here is the "style" prop I will pass to my component
let myStyles = {
  display: 'block',
}

// Here is the "animes" prop I will pass to my component
let myAnimes = [
  'Hunter x Hunter',
  'One Piece',
  'Neon Genesis Evangelion'
]

ReactDOM.render(
  <FunctionalComponentWithProps 
    styles={myStyles} // passing styles
    animes={myAnimes} // passing animes
  />,
  document.getElementById('root')
);
```


Hopefully, you now have a better understanding of what React is and why it's used. I highly encourage you to make your own React apps, no other method of learning comes close in terms of enjoyment and improvement potential. Below are some great resources to get you started on your React journey. Thank you for reading!

<a href='https://reactjs.org/tutorial/tutorial.html'>React Tic-Tac-Toe Beginner Tutorial</a>

<a href='https://www.freecodecamp.org/news/yes-react-is-taking-over-front-end-development-the-question-is-why-40837af8ab76/'>An article that goes more in depth on what this blog covers</a>

<a href='https://scrimba.com/p/p7P5Hd/Index'>Scrimba: A Great Interactive Resource for learning how to write React code</a>









