# Introduction to OpenFEC Data Visualization with ChartJs
## Purpose

The importance of understanding politics and the implications of being informed voters are profound. The ability for citizens of a country to understand the financial spending of candidates running for office (at any level) allows one to understand where a candidate's priorities lie. Observing and analyzing financial trends allows one to make predictions about who may win a particular election. A lot of the time, however, it’s easy to get lost in the numbers! 

Thus, being able to visualize this data in a graphical manner helps in truly comparing and understanding a candidate’s financial spending in comparison to others in an easy manner. However, how do you verify the graphs you see online are indeed accurate? 

It’s a catch-22 situation! Either you receive accurate numbers (hard to analyze) or potentially biased graphs. Today, you’ll learn how to make the graph yourself, using the official financial data available at the OpenFEC API.

For this tutorial, we’ll walk through how to make a bar graph visualizing various financial information (operating expenses, net receipts, fundraising disbursements, and individual contribution less refunds) for Democrats and Republicans as a whole, as well as specific candidates for the 2016 presidential election.

## Setup

1. Sign up for the OpenFEC API Key through this [website.](https://api.data.gov/signup/)
2. Check your email for the API Key and save it
3. Download ChartJS through this [website.](https://www.jsdelivr.com/package/npm/chart.js) This is done by clicking the download icon (fourth button), which will download a zip file. Once the zip file is downloaded, move to the desired location where you will store all your project files.
4. Create one HTML file (call it OpenFEC.html) and one JS file (call it OpenFEC.js) in the same location as ChartJS files you downloaded in step 3.
5. Download a text editor if you don’t have one. You'll need one to code everything up!
6. At the end, to see your output, right-click on the HTML file and open with Google Chrome!

## How Will We Use the API?

Now that you have the ChartJS dependency, HTML (OpenFEC.html) and JS (OpenFEC.js) files set up, let’s get to coding!
In OpenFEC.html, add the following lines of code.
**

<canvas id="chart" width="400" height="400"></canvas>
**
<script src = "./package/dist/Chart.js"> </script>
**

<script src = "./OpenFEC.js"></script>

Line 1 is used to create a canvas tag (needed for chartJS) with the specified width and height. This is where our graph will go on the webpage! Line 2 points our HTML file to the ChartJS JS file that we downloaded earlier. Line 3 points the HTML file to our personal JS file, which is where we will do all of our coding to retrieve the information and display the graph.
Before we start on the JS file, let’s understand the API request we will make. Go to https://api.open.fec.gov/developers/ and scroll down and click on the “presidential” tab.
![img](https://lh5.googleusercontent.com/XQkwdh_p7KUfuWYIq-dsY6qvHNcIwwTyGtqwGvMu_w83vl9cPiI6ndsAcNTSRQZ43fhriuaUBlNQnLozvXSVeuRtLj4kQvCP5jBGlw_g7Sx0VbtG9Lxy9MB25f-F2d_JzIcaTyHG)This should open up a drop down with many options of the different type of information you can obtain. For our purposes, tab seen below.
![img](https://lh3.googleusercontent.com/Ll6Yfe0YHMbXSOIMfHd0eF8X622SrDHYGtpZPUtvDTR4E8jUQI2hlLYYzrG74_oQZg5ypfa845vbqykqDM2V_Hbn9aEyCoQkwKlHgizlh0F1WmS9qJuQ6FaWwtsQws0iN2HUYKDo)
This should now populate your screen with a description of the information available for this specific request as well as certain parameters you can use to filter this information. There is an immense amount of information available on this website and you can specify what information you want by playing around with the parameters and different tabs (“presidential” is just one!). For now, click the “Try it out” button and enter the following parameters.
![img](https://lh5.googleusercontent.com/NfrTdUNTY8xhu8WRZaZky7Ol9EI_u7yeOlCtRuWiKiGW9r-XnP3T_J0fOF7DTsb2JrglWRpSaM13z5CrgOIb1D9NiNG-HAnxuXK10Tc_zBiL9xAfhilJGS0G9Qdu3ZKz7YG8mVvA)
As you can see from this, we are filtering our financial information to focus on the 2016 presidential election, for all candidates (-P00000001) organized by decreasing order of net receipts. There will be multiple pages returned, but we want to focus solely on the first 13 results, so we place the first 13 results on page 1. Make sure to enter the API key you signed up for earlier!
Next, hit the execute button. You should get a response that has a box labeled Request URL that looks like this (note the API key has been colored out).![img](https://lh6.googleusercontent.com/BddSxVFQbcmZMHzQLF7agWbnbBJE-zcduWAxS5FSzq_LjguLLIPTXSw7cWfTgcQ859cjx42nOMtnTCi3m6eCA8sijixLVjg5AApyCePYTdEiSW-jqXczUV5iRL19ucjftccta5Kz)
 Copy and paste this link into any web browser.
Woah! You should’ve been hit with a big wall of text! What does this all mean?!
![img](https://lh6.googleusercontent.com/g38gPiOMAgZCpmVUFzVbHXdaPfqewPBkQoupf94P4V6SgnPH59A3qqvPJQr2nRpOlZCGo5w1u3ddIfvJpBfX6bYt73FpFaCHrBoyGYuSlEzRUfiSROQnj2b38QJFue5HUL6R968V)
What you received was a JSON (JavaScript Object Notation) response after making API GET request. Essentially, this is the raw format where all the information you requested from OpenFEC. To make it more readable, copy and paste all the text and enter it into a JSON beautifier (https://codebeautify.org/jsonviewer) and hit “beautify”.
![img](https://lh4.googleusercontent.com/A4G4jxrZLtO0EKJr_xils2XmUh-olr_fXPnbA8M3x3DXAZdXoAEY4wkkI0lKnfhFzUFEWlo57EshTJTTQaM_wG7BleNGbq4hqchuhkxbU1p1Mr0v9Ggv5Zb8m9OnV9XP6FPJptKX)Now that’s much easier to read! As you can see everything is in key-value pairs. For example there is a key “net_receipts” and a value 799419661.15 associated with it. Scroll through the JSON on the right to see what other information you have found.
There are few important things to note about JSON.Text surrounded by curly braces indicate a JSON objectText surrounded by square brackets are elements of an array.
You should notice that there is a “results” key whose value is an array of multiple JSON objects, all of which have various information for different candidates / parties!
Great, now we have our information. But how to get it into the code?
Let’s open our JS file and enter the following lines of code. The link will be same link we got from the OpenFEC website.
*// Create a web request object using an XMLHttpRequest object*
var http = new XMLHttpRequest();

*// This is the url we are making the request to*
var url = "https://api.open.fec.gov/v1/presidential/financial_summary/"
\+ "?sort=-net_receipts&election_year=2016&sort_null_only=false&page=1&sort_nulls_last=false"
\+ "&api_key=YOUR API KEY HERE&candidate_id=-P00000001&sort_hide_null=false&per_page=13";

XMLHttpRequest is used to create a JavaScript Object which we can make request to the internet! Now, enter the following code:
*// open and sending the GET request at the url*
http.open('GET', url);
http.send();
This allows us to open an “GET” (we want to GET information from the webpage) request to our specified URL. We then send the request! Note that there are other types of HTTP requests but we won’t worry about that here.
Now that we have made our request, we need to set up the onreadystatechange function, which will be invoked when we receive a response. We also need to verify that the response we received is valid (this.readyState == 4 and this.status == 200) before we start using the information we receive from the request. Learn more about HTTP status codes at https://en.wikipedia.org/wiki/List_of_HTTP_status_codes. 
*// this function will run when we receive a response*
http.onreadystatechange=function(){
  *// only proceed once we receive a VALID response*
  if (this.readyState == 4 && this.status == 200) {
Now, we have to extract that data from the response we received from the request. This is done by JSON.parse(this.response), which takes the response we received and parses it into a JavaScript Object (raw_data) we can use. We then want to focus on the information available under the “results” key from the API response, so we index our raw_data by the key “results”.
*// obtain all the JSON data and parse it into a JavaScript object raw_data*
    var raw_data = JSON.parse(this.response);
    *// obtain the results array from the raw_data*
    var results = raw_data["results"];
Now that we have our results saved in the results array our work is almost done! Results stores all the JSON objects of each respective candidate / party with all their financial information.
To set up for ChartJS (which will be discussed below), we want to get all our candidate / party names in a single array and all our data (operating expenditures, net receipts, fundraising disbursements, and individual contributions less refunds) into separate arrays. This is done as follows.
*// initialize empty arrays for the fields we are interested in displaying in our chart*
    names = [];
    operating_expenditures = [];
    total_contribution_refunds = [];
    net_receipts = [];
    individual_contributions_less_refunds = [];
    fundraising_disbursements = [];
    
    *// loop through all of the results*
    for (i = 0; i < results.length; i++) {
      *// obtain the current candidate / party from all the results we are traversing*
      current_data = results[i];
      
      */\* obtain the candidate name, operating expenditures, etc. by indexing the current_data with**
\*        *appropriate key \*/*
      names.push(current_data["candidate_name"]); 
      operating_expenditures.push(current_data["operating_expenditures"]); 
      net_receipts.push(current_data["net_receipts"]);
     	fundraising_disbursements.push(current_data["fundraising_disbursements"]); 
     	individual_contributions_less_refunds.push(current_data["individual_contributions_less_refunds"]);
    } 
After initializing all our empty arrays, we loop through all of our results and save the current element (remember, the current element is a JSON object which has the information of a specific candidate / party). We then index this element by the keys associated with our desired information (see the API response shown earlier for the various keys) and push the information into the appropriate arrays. After doing this for every respective element of the results array, we have all the information that we desire from the API saved. Onto using the information in ChartJS! 
ChartJS Customization
Now that we have our data from the API integrated, we will be creating and customizing the graph. 
To create the graph, we want to instantiate the chart by passing in the 2d context of the canvas where the chart will be drawn. We want to create a bar graph, which is a pre-defined type integrated in. 
*// Save the chart from HTML in JavaScript*
    var ctx = document.getElementById('chart').getContext('2d');
    *// Create a new Chart (will be a bar chart) object*
    var chart = new Chart(ctx, {  
    type: 'bar',
Once we’ve instantiated it, we start customizing the graph. Since we already have arrays with all of the data types, we can just call it. ‘Labels: name,’ prints the name of each candidate/group on the x axis. Once we’ve set the x axis, we will begin labeling each data type under ‘datasets: [‘. 
We set the data according to the label and once that's done, we can work with the background color of each bar. You can have, for example, “black”, “white”, “yellow” or you could do “rgba(0, 0, 0, 0.1)”. Use https://www.hexcolortool.com/ for reference to any color you want! Same as well as borderColor and you can mess around with the width. Repeat for every data set you have.
data: {
      *// x-axis will be labeled with names*
      labels: names,
      */\* create an array of different data values for each name, each having respective labels, colors,**
\*        *and data that we obtained from the API response earlier\*/*
      datasets: [
        {
        label: 'Operating Expenditures',
        data: operating_expenditures,
        backgroundColor: "rgba(106, 220, 123, 1)",
        borderColor: "black",
        borderWidth: 1

​      },
Once you’re done labeling and customizing with each data set, you can add options to create a title for the graph.
*// tinker with various options for the chart*
​    options: {
​      *// set a title*
​      title: {
​        display: true,
​        text: 'OpenFEC Data Visualization'
​      }
​    }
  });
  
  }
}
Lets see how the graph looks! Save your OpenFEC.JS and open your files. Look for OpenFEC.html and right click it. Click ‘Open with safari’(Google Chrome) and it should look like below !
Expected Output![img](https://lh4.googleusercontent.com/vrlUSf7GTKdVCinKZix2Lo8O5Mg0WE70j79mNBWtX7td2tRCp6sGvg2OJQnJO2fg34-enEqBEtlg9rRIF9YNSfhrh5O07Z2odv_oUvuyBjHozHjjfGHPIo0F4NOTUm0OkN6rQtWW)

ConclusionFrom this tutorial, you should have learnedHow to use the OpenFEC API to obtain desired informationWhat JSON isHow to make an API request from your JS code using XMLHttpRequest and how to extract information from the responseHow to visualize data using ChartJS in order to make a bar chart
While this example was simple, it served to illustrate the power of understanding how to use APIs to extract information and how to use this information to create your own charts. The variety of information you can explore even within one API and how you can visualize the information for trend analysis is an extremely powerful tool that helps in discovering a multitude of information.
Next StepsAs next steps, the reader is encouraged toGraph data comparing specific information from the 2016 election and 2020 election in order to find similarities and differencesExplore coloring and other ChartJS features