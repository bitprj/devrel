// Create a web request object using an XMLHttpRequest object
var http = new XMLHttpRequest();

// This is the url we are making the request to
var url = "https://api.open.fec.gov/v1/presidential/financial_summary/"
+ "?sort=-net_receipts&election_year=2016&sort_null_only=false&page=1&sort_nulls_last=false"
+ "&api_key=x4RnLdBY6jSdpY3qB2skGmZfU6xecsBWPyH9saWg&candidate_id=-P00000001&sort_hide_null=false&per_page=13";

// open and sending the GET request at the url
http.open('GET', url);
http.send();

// this function will run when we receive a response
http.onreadystatechange=function(){
    // only proceed once we receive a VALID response
    if (this.readyState == 4 && this.status == 200) {
        // obtain all the JSON data and parse it into a JavaScript object raw_data
        var raw_data = JSON.parse(this.response);
        // obtain the results array from the raw_data
        var results = raw_data["results"];
        
        // initialize empty arrays for the fields we are interested in displaying in our chart
        names = [];
        operating_expenditures = [];
        total_contribution_refunds = [];
        net_receipts = [];
        individual_contributions_less_refunds = [];
        fundraising_disbursements = [];
        
        // loop through all of the results
        for (i = 0; i < results.length; i++) {
            // obtain the current candidate / party from all the results we are traversing
            current_data = results[i];
            
            /* obtain the candidate name, operating expenditures, etc. by indexing the current_data with
               appropriate key */
            names.push(current_data["candidate_name"]); 
            operating_expenditures.push(current_data["operating_expenditures"]); 
            net_receipts.push(current_data["net_receipts"]);
         	fundraising_disbursements.push(current_data["fundraising_disbursements"]); 
         	individual_contributions_less_refunds.push(current_data["individual_contributions_less_refunds"]);
        } 
        
        // Save the chart from HTML in JavaScript
        var ctx = document.getElementById('chart').getContext('2d');
        // Create a new Chart (will be a bar chart) object
        var chart = new Chart(ctx, {    
        type: 'bar',
        // create the data
        data: {
            // x-axis will be labeled with names
            labels: names,
            /* create an array of different data values for each name, each having respective labels, colors,
               and data that we obtained from the API response earlier*/
            datasets: [
                {
                label: 'Operating Expenditures',
                data: operating_expenditures,
                backgroundColor: "rgba(106, 220, 123, 1)",
                borderColor: "black",
                borderWidth: 1

            },  
                {
                label: "Net Receipts",
                data: net_receipts,
                backgroundColor: "rgba(71, 175, 255, 1)",
                borderColor: "black",   
                borderWidth: 1,                  
                },
                
                {
                label: "Fundraising Disbursements",
                data: net_receipts,
                backgroundColor: "rgba(136, 0, 240, 1)",
                borderColor: "black",    
                borderWidth: 1,                  
                },
                {
                label: "Individual Contributions Less Refunds",
                data: individual_contributions_less_refunds,
                backgroundColor: "rgba(233, 114, 114, 1)",
                borderColor: "black",    
                borderWidth: 1,                  
                }
            ]
        },
        // tinker with various options for the chart
        options: {
            // set a title
            title: {
                display: true,
                text: 'OpenFEC Data Visualization'
            }
        }
    });
    
    }
}
