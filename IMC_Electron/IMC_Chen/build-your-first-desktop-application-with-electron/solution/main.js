/*
Author: Chen Meng
Date: 5/18/2020
*/
const { app, BrowserWindow } = require('electron')

function createWindow() {
    // Create the browser window.
    win = new BrowserWindow({
        // Dimension of the window
        width: 230,
        height: 170,
        // Starting position of the window: topleft
        x: 0,
        y: 0,
        // Window is not resizable, minimizable, or maximizable
        resizable: false,
        minimizable: false,
        maximizable: false,
        webPreferences: {
            nodeIntegration: true
        }
    })
    // Load index.html upon creation
    win.loadFile('index.html')
}
app.whenReady().then(createWindow)