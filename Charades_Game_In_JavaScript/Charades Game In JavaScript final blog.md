# Charades Game In JavaScript

Quarantine life has been bored without hanging out with friends and buying boba. Everyone is desperate to have some fun at home. I recently read a post about creating a [memery game using Vanilla JavaScript by Marina Ferreira](https://medium.com/free-code-camp/vanilla-javascript-tutorial-build-a-memory-game-in-30-minutes-e542c4447eae), and found the techniques she used are very interesting, so I decided to create another popular game - Charades, using similar techniques and adding more features. You would dive a little more into some JavaScript methods in this tutorial. Let's get start to build our own charades game while learning HTML/CSS and JavaScript together in this one hour!

### Live Demo: [Charades!](https://)
## Download Starter Code
Before we start, you can find all the codes here:  [Charades_Game_in_JavaScript Repo](https://github.com/bitprj/Charades_Game_In_JavaScript). 
You can download the folder **"starter"** directly, or you can also start from scratch by creating **5 HTML files, 3 CSS files, and 4 JavaScript files in one single folder.**

*Don't get scared by the amount! 2 of the HTML files are just the starting and ending page which are very simple, and their corresponding CSS and JavaScript will have a lot in common!*

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

**A friendly tip**: personally, I use [Visual Studio Code](https://code.visualstudio.com/) to write all my codes, since it has colors and makes it easier to read. You could try download it if you don't know where to start!

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

Since this is a very simple page, we don't need a script file to add function to it, and instead of having a separate CSS file to style the contents, we can simply add `style="..."` in each tag to customize the style.

[](https://github.com/bitprj/Charades_Game_In_JavaScript/blob/master/end_code/endpage.html)


### Starting Page
![](https://i.imgur.com/2hL51bx.png)

In the starting page, we would want to have a button so that the player could click on it and start the game. To create a button, use the `<button></button>` tag in HTML.

You could play around with the design of the button in the corresponding **CSS** file "styles.css", and now let's focus on adding the effect when the button is clicked.

##### **in HTML:**
First, the tag `<button>` can have an **"onclick"** event, which would call the function `start()`
![](https://i.imgur.com/aFkiBAS.png)

To make the button work, we need to write the function in JavaScript.

##### **in JavaScript:**
We would want to go to the next page to choose the version when the start button is clicked.

Our `function start() {}` would only have one line to jump to the next HTML page using `window.location`.

![](https://i.imgur.com/eV0yayP.png)


##### **in CSS:**
Here is an example design of the start button, but you can absolutely customize yours by playing around with the features.

![](https://i.imgur.com/hpqyiQl.png)



## Tip: Linking Two HTML Files
As we jump from the starting page to the next page, we change to another HTML file. In order to make this happen, we need to add another line of code in our HTML file.

Use tag `<a href="{{YOUR_NEXT_HTML_NAME}}"></a>` under the `<head>` tag in your starting page's HTML, and now check out the page -- the start button should be working!

![](https://i.imgur.com/HSesBXq.png)



## Choosing the Game's Rule

![](https://i.imgur.com/4yewZS5.png)

The start button redirects us to the second page where we can choose the version we would like to play. One is limited time, the other is limited words.

***Want to play the game right now?? Skip this page! Jump directly to the "Creating Animated Word Cards" section with your preferred version!***

##### **in HTML:**
In this page, we want to have 2 buttons which redirects to 2 different HTML pages. The buttons would be created the same as the start button in the starting page, and we could add a `<p></p>` to create the text box under each button.

Creates two `<div>` with class names "v1" and "v2" for the two button under the `<section>` first. These containers will allow us to set the positions of the button and the text box later in CSS.

Use `<br></br>` tags to create blank lines if you want.

![](https://i.imgur.com/J6igzUP.png)

##### **in CSS:**
We could design our button in the corresponding "chooseVer.css" file. To set the style of the entire class, use the `.` in front of the class name, or use the `#` to refer by the id name. You could also set styles for everything under a tag by directly put `p {...}` for the texts for example.

There are many ways to center a text box or a container, and here I set `margain-top`, `margain-bottom`, `margain-left`, `margain-right` to `auto`, and align the text of the bigger containers to the `center`.

![](https://i.imgur.com/yT1TagC.png)


##### **in JavaScript:**

Similar to the starting page, but now we will have two separate functions corresponding to each of the buttons (invoked by `onclick`) to redirect to different pages.

The `function time() {}` will take us to `"card_time.html"`, and the `function word() {}` will take us to `"card_word.html"`.


### **Challenge: Adding a Countdown Before Redirecting**

![](https://i.imgur.com/FaGi3Yk.gif)

Not yet ready for the game to start right away? Let's create a 5 seconds countdown timer before it starts!

*Here are many ways to add the timer before redirecting, for example, you can simply add another html file, in which you would create a simple countdown timer, and then somehow redirect to the corresponding page (this is a little hard), or you can add the timer either in the same page as the choosing buttons or separately in the two card files. And here, we will try the most straightforward way by **adding it in the "chooseVer.html" page and countdown before redirecting**.*


The timer will be created under `<span></span>` tag in the HTML file.
![](https://i.imgur.com/l5aeE0C.png)

The timer would be exactly the same in both version, and let's start adding it to the `"limiting time"` version first.

### **Phase 1: Hide And Show**
It is important to notice that in the beginning, before the player makes a choice, the countdown should not be shown on the page, so we need to "hide" the timer first. Then, after one of the buttons is clicked, the countdown will "show".
Inspired by Marina's post, I included the "hide" and "show" properties in the CSS file.

##### **in CSS:**
You could set the style of the timer by its tag name, and make sure you include `display: none;` so that it is not shown in the beginning.
The `none` indicates it is not showing, and `block` indicates it is showing.

![](https://i.imgur.com/2rYdVql.png)


##### **in JavaScript**
When the button is clicked, we want the buttons and the texts disappear, while the countdown timer should show up. Therefore, **inside each function**, we would use `.classList.toggle` to hide texts, and change button style to `"hidden"` to hide buttons.

Here we take `time()` for example, and the `word()` is implemented in the exact same way.

1. Hide Texts:
To select the text boxes, we set it to a variable `var element = document.getElementById("intro-words");`. Then, we would modify the style of this element into `"hide"`. Same for the `"intro-time"` text box.

![](https://i.imgur.com/0NXOPNd.png)

2. Hide Buttons:
Since there are two buttons under the `but` class, we need to select them with `const button = document.querySelectorAll('.but');`, then access each of them by using `forEach(but => but...);` The button have a style property called visibility, so we could simple make it to "hidden".

![](https://i.imgur.com/VNnoB6d.png)

3. Show the Counter:
Same as hiding the text boxes, we would select the timer element by its id `"go"`, and use `.classList.toggle` to set it to `"show"`.


### **Phase 2: Timer**
Now we could implement the timer.
The idea is that the timer will take in the `textContent` of our `"go"` element, and show the modified `textContent` every one second. And we update the `textContent` by keeping a counter and decrement it every second.

##### **in JavaScript:**
We first create a variable `seconds` to hold the value in the `textContent` of our `"go"` element, which is 5.

![](https://i.imgur.com/itWasch.png)

Then, we would use `setInterval()` function to let the timer count down at each second (=1000 milliseconds), and update the variable `seconds` by using the decrementing operator `seconds--;`, and also, update the `textContent` with the decremented seconds or whatever words you want (like "Ready??" "Go!!").

We use an `if-else if-else` loop to separate conditions on the seconds. The seconds would go into the `else` statement after 5 iterations, and we would `clearInterval(count);` and jump to the corresponding page.

![](https://i.imgur.com/k6gd2dv.png)

Now try out the new feature you got for your limiting time version! 

### **Phase 3: Copy to Both Functions**

##### **in JavaScript:**
Simply copy and paste all the codes we added in the function `time()` in phase 1 and 2 into the function `word()`. Remember to change the redirecting page into `"card_word.html"`!

Now, try clicking both of the buttons!




## Creating Animated Word Cards
![](https://i.imgur.com/9XlNjfr.png)

Now it is the exciting part to create flipping cards with words on them!
Let's start with creating the elements in HTML.

##### **in HTML:**
The HTML of both versions are exactly the same, besides the different JavaScript they included.

There will be a simple `<div>` holding the card which has a `front-face`, and a `back-face`. As learned from Marina Ferreira's blog, I adapted her procedure to create the flipping card. And in the end, I add a timer to give a reference to the players.

```
<div class="cards" id="words">
    <p class="front-face" id="word2">dog</p>
    <p class="back-face" id="word1">pig</p>
</div>
<span id="timer"></span>
```
##### **in CSS:**
Since both versions have the same HTML elements, we do not need to create separate CSS files for each design (but you can if you want the cards look different in different versions).
Besides the design of cards, there are some important features to add to make the card flips as we want. I mainly adapted these [CSS codes](https://github.com/code-sketch/memory-game/blob/master/video-11/styles.css) from [Marina](https://medium.com/free-code-camp/vanilla-javascript-tutorial-build-a-memory-game-in-30-minutes-e542c4447eae), because she has made the flipping effects very fluent and nice. However, instead of flipping it vertically, I changed to horizontally, so we have `transform: rotateX(180deg);`

You can find my full CSS code [here](https://github.com/bitprj/Charades_Game_In_JavaScript/blob/master/finish_code/cardstyle.css).

![](https://i.imgur.com/r8J1YZg.gif)


Note: Here is a little tricky. Since I used the same CSS codes from Marina, the `back-face` is shown in the beginning as the first word, so I named it with `id="word1"`. I'll refer to `word1`, `word2` instead to make it more clear.


### "Limiting Time" Ver.
In this version, we want to have a timer to keep track of the time that each card has been shown, and flip the card when the time is up.
To do this, we would write a function `function flipWord() {...}` which flips the word, and then start the timer. When the time is up, call `flipWord()` again and reset the `textContent` of the word whichever is hidden now, and it would be the next word to be shown.

##### **in JavaScript:**
**1. the First Flip**
The first flip is different from the rest, because `word2` is already there and we do not need to reset any word. So we could simply use the same `setInterval()` function in our previous timer and call `flipWord()` instead of jumping to the next window. Set the seconds to 30 instead.

*check out the timer implementation in phase 2 in the "Challenge: Adding a Countdown Before Redirecting" section under "Choosing the Game’s Rule" if you skipped that part*

![](https://i.imgur.com/9eTYQo6.png)


**2. `flipCard()` Function**
When we call `flipCard()`, we want to to set the style corresponding to the "flip" we declared in the CSS file. This is similar to the "Hide and Show" strategy we used in the previous section. *Go back and check that phase 1 out!* 
So we would simply have one line here. `document.getElementById("words").classList.toggle('flip');` 

**3. Keep Flipping Cards and Resetting Words**
After the first flip, a new 30 seconds countdown should start, so we add the same timer again in the `flipWord()` function after `toggle('flip);'`. And now we are seeing `word2` on screen, and `word1` is being hidden in the back. This is the time to change `word1` secretly! How would we do that?

While it is definitely an idea to creating a number of the same card's HTMLs and link them one by one to jump to the new words, here we will keep the single HTML file and add a counter to keep track of the new word.

Declare a counter `var word-num = 1;` outside of the function. It starts at 1 because we already flipped the first time. Then, the counter would be incremented by 1 each time until the 30 seconds is up. In this way, we could keep track of how many words we have been guessed.

Now the function should look like this:

![](https://i.imgur.com/T9AFvh8.png)

Now we could reset the word each time by using `if` statements to check the `word_num` conditions. Remember that by saying resetting words, I mean to change the `textContent` of `word1`. Also be careful at which word we are changing at each `word_num`, `word1` or `word2`?

Here is an example to set the 6th and 7th word.

![](https://i.imgur.com/BW8bVpH.png)


**4. Finish!**
After 10 words has been shown, we would jump to the `endpage.html` when `word_num == 11`.

**Congratulations!** Now we are done with the limiting time version, and try it out!

### "How Many Words" Ver.
In this version, we want to flip the card whenever the player clicks on the card. And we would also set a timer of 5 minutes to end the game, and you could count how many words you got right!
To do this, we first need to have a function `flipWord()` to flip the card when we click on the card. This is a little different from the button clicking situation, and we'll discuss it soon. Then, we also want to recursively call `flipWord()` and reset the next word.

##### **in JavaScript:**
**1. Clicking to Flip**
This is a little different from clicking the button, because we are clicking an element with tag `<p>`, which does not have an `onclick` feature to add. So we need to add it by ourselves. As Marina Ferreira did in her Memory Game, we use  `addEventlistener()` to tackle with this clicking. 

![](https://i.imgur.com/vq7pZ6f.png)

Now when we click on the card, the `flipWord()` function would be called.

**2. `flipWord()` Function**
Similar to the "limiting time" version, the function would have a line of `document.getElementById("words").classList.toggle('flip');`, an incrementation of `word_num`, and a call to `flipWord()` again.

**3. Resetting Word**
We would still have a similar strategy of resetting words by checking `word_num`, and change the corresponding word's `textContent`. However, **how would we know when to flip the card again?** We know that we should flip the card whenever the card is clicked, and we used `addEventListener()` to notify the first time to flip the card, so what about the recursive method?
Here we create another function `clicked()` and a boolean variable `CardIsClicked` to indicates if the card is clicked. This strategy to check the clicked card is also introduced in Marina's Memory Game, but we will be using it differently.

![](https://i.imgur.com/kazD4Kf.png)

We know that `CardIsClicked = true` if we click on the card, so the `flipWord()` function should be called recursively if `CardIsClicked == true`.

![](https://i.imgur.com/weZ4MH6.png)

We could reset the words in the exact same way as in the limiting time version by checking the `word_num` conditions. However, after every reset, we would want to make `CardIsClicked = false`, because we want to keep showing it until the next click.

I made this version to have more words since you could skip some unwanted words, but the chices of the numbers and words are all up to you!

So now the resetting should be something like this:

![](https://i.imgur.com/9TVlI5K.png)

We are almost finished! This version should already be working pretty well, but it will only go to the end page when you click all the words. However, remember that we have a time limit! Let's create another timer now!

**4. Timer `setTimeOut()`**
This time, we are not updating the time whenever the card is flipped, but having one single simpler clock. It would still be the same  `setInterval()` function as in all the other timers we've been created. However, this time we have both minutes and seconds, and we could print out the message a little clearer.

![](https://i.imgur.com/i0cMgwK.png)

You can also simply add `window.location = "endpage.html"` in this `else` loop, but I want to introduce another technique to redirect the page. That is the `setTimeOut()` function.

![](https://i.imgur.com/Myk5V3Z.png)

While the `setTimeOut()` is very useful if you do not want to show the count down, and redirect directly after certain amount of time, `setInterval()` could help show the countdown. These two strategies are both easy to understand.



WOO! We are done implementing the clicking version, too! Time to check out the full game! Refer to the finished code in the [repo](https://github.com/bitprj/Charades_Game_In_JavaScript) if you get a different output.



## Final Thoughts
Congratulations again on following through this tutorial and creating your own charades game! Now you could customize it and play with your families and friends!

### Advanced Challenges: Potential Improvements
While this is a fairly easy and straightforward example of making a charades game using HTML/CSS, and JavaScript, there are some more advanced features we could implement in this game pages.

1. Would you be able to combine the two version, where you can click on the card to skip or you finished within 30 seconds and wants to move on, but you still keep a limited 30 seconds on each card?
2. Would it be possible to generate words and assign to each card when flipping?
3. Would there be a way to let us input the words (either being asked on the webpage or write directly as a list in the files) and randomly assign them to the cards, where it would not show up in the original order we put the words in?

I would like to know your ideas!
Have fun learning HTML/CSS and JavaScript, and create more fun games!