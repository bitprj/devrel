## Tired Of Losing at Super Mario Party?
## WIN with Data Simulation

I don't know about the rest of you, but I'm not very good at playing video games. This is super apparent when I'm with playing games with friends and struggling to keep up, so I need every advantage I can get. One game that we tend to play together along with Super Smash Bros, is Super Mario Party. 

There are a variety of characters in Super Mario Party, each with unique dice that you roll to move around the map, and every time you reach the end of the map, you get a star. The winner is determined by how many stars each player has at the end of the set amount of turns for the round. There are many other factors like the number of rounds the game has, and many differnet ways of getting stars, like stealing from other players or winning  mini games, but let's focus on how far the character can traverse the board in 20 turns for now. 

You might be wondering what kind of advantage we might be trying to gain, and that would be in choosing the optimal character to traverse the furthest in the given amount of turns. Using Python to write code to simulate rolling a dice, we can simulate hundreds of games to determine the character that most efficiently traverses the map. 

Here's the code that simulates the roll of the dice. Each character has their unique dice, so we have a dictionary with all the characters names as the key, and each key corresponds with a list that contains each movement value on the sides of the die. The program randomly selects one of the 6 values in the list for each turn, and sums up all the values. The average distance traveled per game is calculated and that allows us to see which character most efficiently traverses the map. 

From running that program for each character and simulating 100 games, we start to see some pretty distinct differences in the characters' performance. From the averages of all the simulated runs, we can see that Bowser is far ahead of Wario, the one who traveled the 2nd furthest, while Rosalina and Hammer Bro are hanging off the opposite end traveling far less than the other characters.

The issue with that, is that with only 100 games simulated, it doesn't give us as good an estimation of the average distance the character will travel in a 20 turn game, so let's try simulating 1000 games and take the averages. 

After running the 1000 game simulations, we start to see that for the most part, the ranking of the characters stay the same with some moving up or down a spot. Although we now have a better prediction of which characters will travel further, our data still isn't ready for us to draw final conclusions. We still need to screen the data for outliers. 

A prime example is in the dataset of when we simulated 100 games with Koopa (shown above). There's one game where Koopa traveled 107 spaces while all the other games had a significantly shorter distance travelled. So let's go through all the characters and replace all the outlier values with the median in the dataset from the 100 game simulations. That should help us get the most accurate prediction of how far these characters will actually travel in game, and here's the final leaderboard.  

