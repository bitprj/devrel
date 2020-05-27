# How to Build Your Own Website - Introduction to HTML, CSS, and JavaScript

The world of web development and design is growing, and whether it would be to establish a professional online presence, showcase a design portfolio, or record personal events from everyday life, creating a website has become a popular method to connect with the world. As the selection of frameworks and tools continue to expand, however, figuring out this process may seem daunting and overwhelming to beginners who are learning to code and do not know how to start.

For those of you at square one, this blog will serve as your first step as a web developer by teaching you how to create a basic website entirely from scratch, using HTML, CSS, and JavaScript.

In this tutorial, you will learn how to do the following:
- Setup a code editor

- Code HTML, CSS, and JavaScript files

- Run a functional basic website

  

## Coding Environment

### Getting Started
We will be using [Visual Studio Code](https://code.visualstudio.com/) as our *source code editor*, which is a text editor that is specialized for writing computer programs, to create the files for our website. In order to get started, [download Visual Studio Code](https://code.visualstudio.com/download) and install the right version for your computer.

![vscode](photos/vscode.jpg)



## HTML, CSS, and JavaScript Files

To start, open your *terminal* or *command prompt*, which is a command line system on your operating system that allows you execute commands on your computer, and type the following:

```markdown
code index.html style.css interact.js
```

This will automatically create, name, and open the three files you will need for your website in Visual Studio Code. Save each file by selecting **File > Save** and exit the app with **File > Exit**. Create a new folder and move the three files into it to keep them all in one place (we named our folder "website"), then in Visual Studio Code, go to **File > Open Folder** to open your folder and display your files.

![open_folder](photos/open_folder.jpg)

### Building the Foundation: HTML File

*HTML* stands for Hypertext Markup Language and is the standard *markup language*, which is a computer processing system designed for annotating and presenting text, for displaying content on a website.

In your `index.html` file, type in the following lines of code:

```html
<!DOCTYPE html>
<html>
  <head>
    <title></title>
  </head>
  <body>
  </body>
</html>
```

This is the basic underlying structure that is used for most websites that we view online, and before we start editing our code, let us look over what we currently have and understand what each part represents.

`<!DOCTYPE html>` indicates which version of HTML is being used, and in this case, we are using the latest version, HTML5.

HTML code is composed of *elements*, which are chunks of information stored between a set of opening and closing *tags*—for instance, `<html></html>` are the opening and closing tags for the `html` element. Think of these elements as separate boxes with each indented element as a smaller box within a larger enclosing box, marked by its opening and closing tags.

![html_starter](photos/html_starter.jpg)

To create the title of our website, add text between the `<title></title>` tags:

```html
...
  <head>
    <title>My Website</title>
  </head>
...
```

Though this text is not displayed on the web page, having a title is important because it will represent your website in search engines, be set as the default name of your website when it is bookmarked, and allow you to more easily navigate this page of your website.

To add text to the body of web page, we will use a heading tag `<h1></h1>` , which are ranked tags and can be numbered up to `<h6></h6>`, and a paragraph tag `<p></p>` between the opening and closing tags of the `body` element. Write any text you would like to feature on your web page between these tags:

```html
...
  <body>
      <h1>My Website</h1>
      <p>Hello World.</p>
      <p>This is my website.</p>
  </body>
...
```

If you want to multiple blocks of text that are separated by line breaks, then you must use another `<p></p>` element for each indented block of text because HTML will not change be able to detect or display the line breaks in your code onto your webpage.

To add an image to our web page, we will use an image tag `<img>`, which does not have a closing tag because it is a *void element* or an element that cannot hold any kind of content besides *attributes*, which are additional bits of information featured in the heading tag of an element. The `<img>` tag will include two attributes, `src` and `alt`. The `src` attribute will contain the URL or file name of the image, and in case the image cannot load on the website, the `alt` attribute will display an alternative text message in replacement of that image. Add any image and text description you would like to have on your web page:

```html
...
  <body>
      <img src="image.png" alt="Bit Project Cube">
      <h1>My Website</h1>
      <p>Hello world.</p>
      <p>This is my website.</p>
  </body>
...
```

Note that if you are using a local image from your computer, you must place the file in the same folder as the other three files for your website.

![html_update](photos/html_update.jpg)

Now, we can run the our website and see what we have created so far. Go into your folder and double-click on your html file—this will prompt your website to open in a web browser:

![](photos/website_start.jpg)

### Stylizing Content: CSS File

*CSS* stands for Cascading Style Sheets and is the standard style sheet language for defining and stylizing aspects on a website.

Before we can add anything to our CSS file, we need to link our CSS file in our HTML file by adding a `<link />` tag to the `head` element. The `<link />` uses a `ref` attribute, which describes the relationship between the HTML file and the linked file, and a `href` attribute, which states the location or name of the linked file. Add the following line to the `head` element of your HTML file:

```html
...
  <head>
    <title>My Website</title>
    <link rel="stylesheet" href="style.css" />
  </head>
...
```

To start stylizing our website, let us briefly go over how CSS works.

A CSS file is called a *stylesheet*, which is a template file that consists of a web page's font and layout settings, and stylesheets are composed of *declaration blocks* that are defined by a *selector* and contain attributes between *curly brackets*. For our website, we will use an `img` selector and a `body` selector to customize the image and text of our web page:

```css
img {
    
}

body {
    
}
```

For the `img` selector, we will add the `width` attribute, which will determine the width of all images on our web page in pixels. To alter how your image appears, feel free to run your website multiple times while increasing and decreasing the number of pixels in between each run until you are satisfied with the result:

```css
img {
    width: 200px;    
}
...
```

For the `body` selector, we will first adjust the characteristics of the text on our page by adding the following attributes and values:

```css
...
body {
    font-family: helvetica;
    text-align: center;
}
```

You can customize the font of the text on your website by selecting a value from this [CSS font list](https://www.w3schools.com/cssref/css_websafe_fonts.asp) and adding it to your `font-family` attribute. There are also many other attributes you can add to your `body` selector to stylize the text on your website, such as `font-style`, `font-size`, `font-weight`, and so on. The `center` value for the `text-align` attribute will center whatever is listed inside the `body` element in your HTML file.

Then, we can add some color to our website by adding the following attributes:

```css
...
body {
    font-family: helvetica;
    text-align: center;
    
    background: aliceblue;
    color:  darkslategray;
}
```

You can customize the color of your web page by using the `background` attribute and the color of the text by using the `color` attribute. Feel free to browse this [browser-supported colors list](https://www.w3schools.com/colors/colors_names.asp) and select any color you would like to use for your website. 

This is what your completed CSS file should look like:

![css](photos/css.jpg)

Now, let us run our file again to review the stylizations we have added to our website:

![website_2](photos/website_2.jpg)

### Adding Interactivity: JavaScript File

*JavaScript* is a programming language that in used in web development to add interactivity to websites through dynamic behavior, such as buttons, pop-up windows, and so on. For our website, we will add an element that displays today's date on our website.

Before we start coding our JavaScript file, we need to create an element in our HTML file to display our date by adding a set of `<p></p>` tags with an `id` attribute, which specifics a unique identity for an HTML element that can be stylized by CSS and/or manipulated by JavaScript, named `today`. We also need to link our JavaScript file in the HTML file by adding a set of `<script></script>` tags with a `src` attribute to our head element:

```html
...  
  <head>
    <title>My Website</title>
    <link rel="stylesheet" href="style.css" />
    <p id="today"></p>
    <script src="interact.js"></script>
  </head>
...
```

This is what your completed HTML file should look like:

![html_js](photos/html_js.jpg)

Moving back to our JavaScript file, we first need activate *strict mode* for our website to prevent any silent errors from occurring by narrowing down the chance of JavaScript making any false assumptions:

```javascript
'use strict'
```

To acquire the current date, we will create a *variable* named `currentDay` and, to retrieve the data we need, use the `new` *operator* to instantiate a new `Date()` *object*:

```javascript
let currentDay = new Date();
```

To format the data into the current date, we will create another variable named `newFormat` and use `toDateString()`, which will remove the time and time zone from the data we received to only reveal today's date:

```javascript
let newFormat = currentDay.toDateString();
```

To add this data onto the website, we will create one more variable named `getData` to retrieve our `today` element from our HTML file by using `getElementById()` :

```javascript
let getData = document.getElementById('today');
```

Finally, after retrieving our `today` element, we need to insert the data we received into it by using `innerHTML` and setting it equal to our `newFormat` variable to finish our JavaScript code:

```javascript
'use strict'

let currentDay = new Date();
let newFormat = currentDay.toDateString();
let getData = document.getElementById('today');
getData.innerHTML = newFormat;
```

This is what your completed JavaScript file should look like:

![js](photos/js.jpg)

Now, we have completely finished the code for our website!

![website_3](photos/website_3.jpg)



## Conclusion

Congrats on creating your own website! 

From this blog, we discussed the basic components go into the structure of a website—HTML, CSS, and JavaScript—and built a solid foundation of knowledge that will allow you to dive deeper into the world of web development and design with confidence.

Feel free to continue adding more features to your website, such as photos, music, pages, and so on, by researching more about what attributes you can create with HTML, CSS, and JavaScript—the possibilities are endless! By using this website as a base for future endeavors, you will learn how to flesh out the complexity of your web design projects, turn your web application ideas into a reality, and potentially even jumpstart a career as a web developer.