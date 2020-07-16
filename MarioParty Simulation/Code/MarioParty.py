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