# Charades Game In JavaScript

Quarantine life has been bored without hanging out with friends and buying boba. Everyone is desperate to have some fun at home. I recently read a post about creating a [memery game using Vanilla JavaScript by Marina Ferreira](https://medium.com/free-code-camp/vanilla-javascript-tutorial-build-a-memory-game-in-30-minutes-e542c4447eae), and found the techniques she used are very interesting, so I decided to create another popular game - Charades using similar techniques and adding more features. You would dive a little more into some JavaScript methods in this tutorial. Let's get start to build our own charades game while learning HTML/CSS and JavScript together in this one hour!

### Live Demo: [Charades!](https://)
## Download Starter Code
Before we start, you can find all the codes [here](https://github.com/bitprj/Charades_Game_In_JavaScript). 
You can download the **starter folder** directly, or you can also start from scratch by creating **5 HTML files, 3 CSS files, and 4 JavaScripts files in one single folder.**

*Don't get scared by the amount! 2 of the HTML files are just the starting and ending page which are very simple, there corresponding CSS and JavaScripts will have a lot in common!*

All the **HTML** files have the same starting template:
```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">

  <title>Charades</title>

  <link rel="stylesheet" href="{{YOUR_CSS_NAME}}">
</head>
<body>

  <script src="{{YOURJAVASCRIPTNAME}}"></script>
</body>
</html>
```

All **CSS** files also have the same template to start with, as we are simply setting the background color and layout here:
```
* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
  }
  
  body {
    height: 100vh;
    display: flex;
    background: #f8e5a6;
  }
```

A friendly tip: personally, I use [Visual Studio Code](https://code.visualstudio.com/) to write all my codes, since it has colors and makes easier to read. You could try download it if you don't know where to start!

Now that we have all our files created, we could move on to the first step -- creating the starting and ending page!

![](https://i.imgur.com/9VQL74c.jpg)



## Starting Page and Ending Page
### Ending Page
In the [live demo](https://), we could see that the ending page is just a page with one single line of words to show a finishing message.

![](https://i.imgur.com/bBJIeDc.jpg)

We can simply write in the HTML file.
A simple header could be able to show the message, but we want it to be wrapped by a section to make it possible to center the text.

```
<body>
    <section>
        <h1>Times up!</h1>
    </section>
</body>
```

Since this is a very simple page, we don't need a javascript to add function to it, and instead of having a separate CSS file to style the contents, we can simply add `style="..."` in each tag to customize the style.

[](https://github.com/bitprj/Charades_Game_In_JavaScript/blob/master/end_code/endpage.html)


### Starting Page
In the starting page, we would want to have a button so that the player could click on it and start the game. To create a button, use the `<button></button>` tag in HTML.

You could play around with the design of the button in the corresponding CSS file "styles.css", and now let's focus on adding the effect when the button is clicked.

##### in HTML:
First, the tag `<button>` can have an **onclick** event, which would call the function 
![](https://i.imgur.com/aFkiBAS.png)

To make the button work, we need to write the function in JavaScript.

##### in JavaScript:
We would want to go to the next page to choose the version when the start button is clicked.

Frist, we need to choose the button by using `const button = document.querySelector('.start_button');`. 

Our `function start() {}` would only have one line to jump to the next HTML page using `window.location`.

![](https://i.imgur.com/eV0yayP.png)


## Tip: Linking Two HTML Files
As we are jumping from the starting page to the next page, we changed to another HTML file. In order to make this happen, we need to add another line of code in our HTML file.

Use tag `<a href="YOUR_NEXT_HTML_NAME"></a>` under the `<head>` tag in your starting page's HTML, and now the start button should be working!

## Choosing the Game's Rule
The start button redirects us to the second page where we can choose the version we would like to play. One is limited time, the other is limited words.

***Want to play the game right now?? Skip this page! Jump directely to the "Creating Animated Word Cards" section with your prefered version!***








