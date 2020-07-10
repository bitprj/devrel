/*
Author: Chen Meng
Date: 5/18/2020
*/

// dialog is used to show message box in the app
const { dialog } = require('electron').remote;

// Input and display fields
var minutesField = document.getElementById('minutes');
var secondsField = document.getElementById('seconds');
var display = document.getElementById('display');
// Stores the timer used to count time
var myTimer;

// Start Button
const startBtn = document.getElementById('startBtn');
startBtn.addEventListener('click', function(){
    let minutes = parseInt(minutesField.value, 10);
    let seconds = parseInt(secondsField.value, 10);
    // Check for valid inputs, if not valid then timer won't start
    if(minutes >= 0 && minutes <= 59 && seconds >=0 && seconds <=59){
        minutesField.disabled = true;
        secondsField.disabled = true;
        startBtn.disabled = true;
        stopBtn.disabled = false;
        var timer = minutes*60 + seconds;
        // Start timer
        myTimer = startTimer(timer, display);
    }
});

//Stop button
const stopBtn = document.getElementById('stopBtn');
// Disabled at first
stopBtn.disabled = true;
stopBtn.addEventListener('click', function(){
    // Stop the timer
    clearInterval(myTimer);
    clearTimer();
});

// Function to start the timer
function startTimer(time, display) {
    const timer = setInterval(function () {
        let minutes = Math.floor(time/60);
        let seconds = time%60;
        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.textContent = minutes + ":" + seconds;
        // Time's up when time == -1
        if (--time < 0) {
            dialog.showMessageBox({
                title: "Time's Up!",
                message: "Buzzzzzzz, time's up"
            });
            clearTimer();
            clearInterval(timer);
        }
    }, 1000); //set the interval to 1000ms (1s)
    return timer;
}

//Resets the fields and buttons
function clearTimer(){
    display.textContent = "00:00";
    minutesField.value = "0";
    secondsField.value = "0";
    startBtn.disabled = false;
    stopBtn.disabled = true;
    minutesField.disabled = false;
    secondsField.disabled = false;
}