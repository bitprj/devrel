// Set up client with twilio credentials for this account
const accountSid = process.env.TWILIO_SID;
const authToken = process.env.TWILIO_TOKEN;
const client = require("twilio")(accountSid, authToken);

// Timer module
module.exports = async function(context, myTimer) {
  var timeStamp = new Date().toISOString();
  // If timer goes off
  if (myTimer.IsPastDue) {
    context.log("JavaScript is running late!");//write to log that timer went off
  }

  // Make and send SMS with Twilio
  client.messages
    // Write the text message
    .create({
      from: process.env.SENDER_NUMBER,//number purchased from Twilio
      body: "You're late!",//message to be sent
      to: process.env.RECIPIENT_NUMBER//number to send the message to
    })
    // Write to log that everything went well
    .then(message => {
      context.log("Message sent");
      context.res = {
        // Status 200, will be at status 200 already (means OK success)
        body: "Text sent successfully"
      };
      // Write to log that the entire function ran properly
      context.log("JavaScript timer trigger function ran!", timeStamp);
      context.done();
    })
    // If there's an error
    .catch(err => {
      // Write error to log
      context.log.error("Twilio Error: " + err.message + " -- " + err.code);
      context.res = {
        // Status 500 is a general HTTP status code saying something went wrong
        status: 500,
        body: 'Twilio Error Message: ${err.message}\nTwilio Error code: ${err.code}'
      };
      context.done();
    });
};
