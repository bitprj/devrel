## Tired Of Losing at Super Mario Party?
## WIN with Data Simulation

I don't know about the rest of you, but I'm not very good at playing video games. This is super apparent when I'm with playing games with friends and struggling to keep up, so I need every advantage I can get. One game that we tend to play together along with Super Smash Bros, is Super Mario Party. 

![./pics/logo.jpg](.\pics\logo.jpg)

There are a variety of characters in Super Mario Party, each with unique dice that you roll to move around the map, and every time you reach the end of the map, you get a star. The winner is determined by how many stars each player has at the end of the set amount of turns for the round. There are many other factors like the number of rounds the game has, and many different ways of getting stars, like stealing from other players or winning  mini games, but let's focus on how far the character can traverse the board in 20 turns for now. 

You might be wondering what kind of advantage we might be trying to gain, and that would be in choosing the optimal character to traverse the furthest in the given amount of turns. Using Python to write code to simulate rolling a dice, we can simulate hundreds of games to determine the character that most efficiently traverses the map. 

Here's the code that simulates the roll of the dice.

~~~{.python}
# We import random to be able to simulate the roll of a dice by randomly selecting a value
import random
# This is the list of characters in game to make sure the user inputs a valid character name
char_list = ['donkey kong', 'bowser', 'boo', 'wario', 'peach', 'daisy', 'dry bones', 'pom pom', 'mario', 'luigi', 'waluigi', 
'goomba', 'bowser jr', 'rosalina', 'diddy kong', 'monty mole', 'shy guy', 'yoshi', 'hammer bro', 'koopa']
# This is the dictionary which stores lists corresponding to each character, and the values in the list represent the faces on the dice
characters = {
    'dk': [0,0,0,0,10,10],
    'bowser':[0,0,1,8,9,10],
    'boo':[0,0,5,5,7,7],
    'wario':[6,6,6,6,0,0],
    'peach':[0,2,4,4,4,6],
    'daisy':[3,3,3,3,4,4],
    'db':[1,1,1,6,6,6],
    'pom':[0,3,3,3,3,8],
    'mario':[1,3,3,3,5,6],
    'luigi':[1,1,1,5,6,7],
    'waluigi':[0,1,3,5,5,7],
    'goomba':[0,0,3,4,5,6],
    'bow_j':[1,1,1,4,4,9],
    'rosalina':[0,0,2,3,4,8],
    'diddy':[0,0,0,7,7,7],
    'monty':[0,2,3,4,5,6],
    'shy':[0,4,4,4,4,4],
    'yoshi':[0,1,3,3,5,7],
    'hammer':[0,1,1,5,5,5],
    'koopa':[1,1,2,3,3,10],
}
# Keep prompting the user to enter a character and running the simulation until they enter 'done'
while True:
    # Prompt user for input
    inputs = input("Enter character name to simulate or 'done' to end: ")
    # Make sure the input is all lowercase for eaiser checking later
    inputs = inputs.lower()
    # If the user inputs 'done', exit the while loop
    if inputs == 'done':
        break
    # Check that what the user inputted is a valid character name
    elif inputs in char_list:
        # Depending on the name of the character, replace with it's abreviation in the dictionary keys
        if inputs == 'donkey kong':
            inputs = 'dk'
        elif inputs == 'dry bones':
            inputs = 'db'
        elif inputs == 'pom pom':
            inputs = 'pom'
        elif inputs == 'bowser jr':
            inputs = 'bow_j'
        elif inputs == 'diddy kong':
            inputs = 'diddy'
        elif inputs == 'monty mole':
            inputs = 'monty'
        elif inputs == 'shy guy':
            inputs = 'shy'
        elif inputs == 'hammer bro':
            inputs = 'hammer'
        # Prompt user for number of games to simulate
        rounds = input("Input number of games to simulate: ")
        rounds = int(rounds)
        # These games will all have 20 turns, the longest game allowed in Super Mario Party
        turns = int(20)
        # This will store the final distances of each game simulated
        total = []
        # Retrieve the list containing values corresponding to the values on the character dice
        curChar = characters.get(inputs)
        # Iterate through the number of games to simulate
        for y in range(rounds):
            # Reset the distance traveled before each game simulation
            dist = 0
            # "Roll" the dice 20 times for each game 
            for x in range(turns):
                dist += random.choice(curChar)
            # Append the total distance traversed in the game to the list
            total.append(int(dist))
        # Print out distance traveled in each round and the average overall distance traveled
        print("Distance traveled in each round: ", str(total)[1:-1])
        print("Average distance: ", (sum(total)/rounds))
    # If the character is not in the character list up top, complain
    else:
        print("Not a valid character in Super Mario Party")
~~~

 Each character has their unique dice, so we have a dictionary with all the characters names as the key, and each key corresponds with a list that contains each movement value on the sides of the die. The program randomly selects one of the 6 values in the list for each turn, and sums up all the values. The average distance traveled per game is calculated and that allows us to see which character most efficiently traverses the map. 

From running that program for each character and simulating 100 games, we start to see some pretty distinct differences in the characters' performance.

![100Games](.\pics\100Games.PNG)

<img src=".\pics\ScatterPlot.PNG" style="zoom:75%;" />

 From the averages of all the simulated runs, we can see that Bowser (Grey) is far ahead of Wario (Dark Green), the one who traveled the 2nd furthest, while Rosalina and Hammer Bro are hanging off the opposite end traveling far less than the other characters.

The issue with that, is that with only 100 games simulated, it doesn't give us as good an estimation of the average distance the character will travel in a 20 turn game, so let's try simulating 1000 games and take the averages. 

![](D:\Bit\devrel2\IMC_BigData\DataSimulation\pics\1000Games.PNG)

After running the 1000 game simulations, we start to see that for the most part, the ranking of the characters stay the same with some moving up or down a spot. A prime example of a character experiencing a major shift is Diddy Kong who climbed 8 spaces after simulating 1000 games. Although we now have a better prediction of which characters will travel further, our data still isn't ready for us to draw final conclusions. We still need to screen the data for outliers. 

A prime example is in the dataset of when we simulated 100 games with Koopa (shown above). There's one game where Koopa traveled 107 spaces while all the other games had a significantly shorter distance travelled. So let's go through all the characters and replace all the outlier values with the median in the dataset from the 100 game simulations. That should help us get the most accurate prediction of how far these characters will actually travel in game, and here's the final leaderboard.  

