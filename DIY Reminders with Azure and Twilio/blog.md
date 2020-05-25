## Azure Alarms
​	I'm a very forgetful person, especially when I'm out having fun. I love hiking and biking, but my allergies make life miserable so I need to take my meds every 24 hours when I head out. To fix this problem, I can just set a notification, but when I'm doing something else, I can very easily miss the slight buzz and tone from my phone.

​	With Azure and Twilio, this problem can be easily remedied. We'll use Azure to set up a timer to trigger other code to run, and integrate Twilio so we can send a text message or call to ourselves to make sure we notice the reminder.

​	It will take a little bit of Javascript to make everything work, but it's pretty straightforward and we'll go over everything together. Firstly, we need to set up 2 accounts, Microsoft Azure , and Twilio. Azure has a 12 month free trial and Twilio has a free trial as well with some credits to experiment with the features.

### Step 1: Create Timer Function
​	Let's pop open Azure and click to create a new resource, get started, then select "Function App". After that, fill in all the info about your function. Make sure you select "JavaScript" for the runtime stack option.

​	Now that we've done all that, we can go ahead and click "Create" and deploy the function.

<img src=".\pics\01.PNG" style="zoom:75%;" />

<img src=".\pics\02.PNG" style="zoom:75%;" />

​	Let's select the "In-Portal" development environment for simplicity, but you can use VS Code instead if you want. Under the "More Templates" option, we'll be choosing a Timer Trigger, because we want the timer to trigger our function in Twilio.

<img src=".\pics\03.PNG" style="zoom:75%;" />	

​	When filling out the time, remember that it's in UTC and  the numbers are '{sec}{min}{hr}{day}{month}{day of week}'

<img src=".\pics\04.PNG" style="zoom:75%;" />

​	That's it for now. The Azure timer function is all set up and now let's integrate Twilio so we can get a notification.

### Step 2: Setting up Twilio Credentials
​	Firstly, let's make sure we have Twilio installed. We'll go to the left panel of our app menu in Azure, and select console. Then type: 

​	npm install Twilio

<img src=".\pics\05.PNG" style="zoom:75%;" />

​	Now let's go over to our Twilio account and purchase a phone number. The free Twilio trial comes with some balance so we can purchase a phone number and send calls and texts using that balance.

​	Back over in Azure, let's go to the same left panel as earlier and go into the Configuration tab. There let's create 4 new application settings for your TWILIO_SID, TWILIO_TOKEN, SENDER_NUMBER, RECIPIENT_NUMBER. Those are all values that we need in our code later, but for security, we put those values under application settings instead of directly writing it into our code. 

<img src=".\pics\06.PNG" style="zoom:75%;" />

### Step 3: Sending a SMS

​	And now, the code. Let's go back to that left menu, select "Functions" and click on the timer trigger we made earlier. There will be a "Code + Test" and we'll be editing index.js.

​	Here's a look at the code:

<img src=".\pics\08.PNG" style="zoom:75%;" />

​	It's not too complex. If the timer is past due, write that in the log, then create and send a message from SENDER_NUMBER to RECIPIENT_NUMBER. If everything works perfectly, log a success, else log the error. 

### Step 4: Making a Call

​	The code to make a call isn't that different from sending a text, but we will have to make some changes. 

​	One of the things that we'll have to do is make a TwiML Bin in Twilio. 

<img src=".\pics\09.PNG" style="zoom:100%;" />

<img src=".\pics\10.PNG" style="zoom:75%;" />

​	In that TwiML Bin, let's write some code so the program knows what to say during the call, and copy the URL for the bin and save it as an Application Setting with all our other Twilio credentials. 

<img src=".\pics\12.PNG" style="zoom:75%;" />

​	Now we can go back and change the code like so:

<img src=".\pics\11.PNG" style="zoom:75%;" />

###  Step 5: Testing and We're Done!

​	With this, we're all done with the code and should test it. Just click the "test" button up top and when the time you set on the timer rolls around it will go off and either send a text or call depending on which one you chose to implement. 

<img src=".\pics\13.PNG" style="zoom:75%;" />

​	If everything works, we're done! We've made an automated text or call that is sent at the time we set to remind us to do something we need to using Azure, Twilio, and a bit of JavaScript. You can customize the code to do whatever you want. You can use it as a wakeup call if you want something more than a simple alarm, or spam a friend with texts (probably shouldn't do that one...). Have fun with it! The sky's the limit. Now if you'll excuse me, I'm going to hit the trails.