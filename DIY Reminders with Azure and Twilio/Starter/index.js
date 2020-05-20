//code given when timer module is made in Azure
module.exports = async function(context, myTimer) {
  var timeStamp = new Date().toISOString();

  if (myTimer.IsPastDue) {
    context.log("JavaScript is running late!");
  }
  context.log("JavaScript timer trigger function ran!", timeStamp);
};
