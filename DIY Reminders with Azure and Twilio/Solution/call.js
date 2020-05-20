//set up client with twilio credentials for this account
const accountSid = process.env.TWILIO_SID;
const authToken = process.env.TWILIO_TOKEN;
const client = require('twilio')(accountSid, authToken);

//timer module
module.exports = async function (context, myTimer) {
  var timeStamp = new Date().toISOString();
  //if timer goes off
  if (myTimer.IsPastDue)
  {
      context.log('JavaScript is running late!');//write to log that timer went off
  }
    
    //make call with Twilio
  client.calls
    //initiate the call 
    .create({ 
      url: process.env.TWIML_URL,//link to TWIML code in the bin you made on Twilio
      to: process.env.RECIPIENT_NUMBER,//number to call
      from: process.env.SENDER_NUMBER//number purchased from Twilio
    })
    //write to log that everything went well
    .then(call => {
      context.log("Call sent");
      context.res = {
        //status 200, will be at status 200 already (means OK success)
        body: 'Call sent successfully'
      };
      //write to log that the entire function ran properly
      context.log('JavaScript timer trigger function ran!', timeStamp)
      context.done();
    })
    //if there's an error
    .catch(err => {
      //write error to log
      context.log.error("Twilio Error: " + err.message + " -- " + err.code);
      context.res = {
        //status 500 is a general HTTP status code saying something went wrong
        status: 500,
        body: 'Twilio Error Message: ${err.message}\nTwilio Error code: ${err.code}'
      };
      context.done();
    });
};
