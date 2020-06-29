import random
char_list = ['donkey kong', 'bowser', 'boo', 'wario', 'peach', 'daisy', 'dry bones', 'pom pom', 'mario', 'luigi', 'waluigi', 
'goomba', 'bowser jr', 'rosalina', 'diddy kong', 'monty mole', 'shy guy', 'yoshi', 'hammer bro', 'koopa']
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
while True:
    inputs = input("Enter character name to simulate or 'done' to end: ")
    inputs = inputs.lower()
    if inputs == 'done':
        break
    elif inputs in char_list:
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
        rounds = input("Input number of games to simulate (10-20): ")
        rounds = int(rounds)
        turns = input("Input number of turns to simulate (10-20): ")
        turns = int(turns)
        total = []
        if(turns > 20) or (turns < 10):
            print("number of turns not in allowed range")
            continue
        if(rounds > 20) or (rounds < 10):
            print("number of games not in allowed range")
            continue
        curChar = characters.get(inputs)
        for y in range(rounds):
            dist = 0
            for x in range(turns):
                dist += random.choice(curChar)
            total.append(int(dist))
        print("Distance traveled in each round: ", str(total)[1:-1])
        print("Average distance: ", (sum(total)/rounds))
    else:
        print("Not a valid character in Super Mario Party")