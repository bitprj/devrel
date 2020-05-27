'use strict'

let currentDay = new Date();
let newFormat = currentDay.toDateString();
let getData = document.getElementById('today');
getData.innerHTML = newFormat;