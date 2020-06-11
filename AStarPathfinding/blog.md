<p style="color: red; font-weight: bold">>>>>>  gd2md-html alert:  ERRORs: 0; WARNINGs: 1; ALERTS: 11.</p>
<ul style="color: red; font-weight: bold"><li>See top comment block for details on ERRORs and WARNINGs. <li>In the converted Markdown or HTML, search for inline alerts that start with >>>>>  gd2md-html alert:  for specific instances that need correction.</ul>

<p style="color: red; font-weight: bold">Links to alert messages:</p><a href="#gdcalert1">alert1</a>
<a href="#gdcalert2">alert2</a>
<a href="#gdcalert3">alert3</a>
<a href="#gdcalert4">alert4</a>
<a href="#gdcalert5">alert5</a>
<a href="#gdcalert6">alert6</a>
<a href="#gdcalert7">alert7</a>
<a href="#gdcalert8">alert8</a>
<a href="#gdcalert9">alert9</a>
<a href="#gdcalert10">alert10</a>
<a href="#gdcalert11">alert11</a>

<p style="color: red; font-weight: bold">>>>>> PLEASE check and correct alert issues and delete this message and the inline alerts.<hr></p>


**Introduction to AI with A* Pathfinding**

In real life and in games we often want to find the shortest path between point A and point B. Suppose you are developing a game and you have enemies that will charge the player. You don’t want those enemies to move around aimlessly until they happen to encounter the player, you want them to lock onto the player and get to them ASAP. Similarly if you are using Google Maps you want to get to your destination as fast as you can rather than requesting a scenic route. Thankfully, computer scientists have invented algorithmic was of solving this problem and one of those solutions is A*.

A* (pronounced A-star) is an extension of another well known algorithm, Dijkstra’s algorithm for shortest path. The main difference between these two algorithms and what pushes A* into artificial intelligence is that A* can make decisions based on the information it has on its environment. Specifically, A* knows where its target is located. As opposed to Dijkstra’s which attempts to find the shortest distance to every location.

Pathfinding algorithms have to know which node in the graph they want to explore next. The way A* figures this out is by minimizing the function,

_f(n) = g(n) + h(n)_

where _n_ is the next node on the path, _g(n)_ is the distance you have traveled to get to _n_ from the start, and _h(n)_ is how far you estimate _n_ is from your target. This _h(n)_ is also called the heuristic function. For those unfamiliar, a heuristic is like an educated guess that does not outright obtain the goal but can help you get there. For A*, this heuristic is typically the shortest possible distance between the location you are at and your goal.

Now, this heuristic function will change depending on the environment you place the algorithm in. Let’s say you want to find the shortest distance by car between Los Angeles and New York. one way to estimate how far they are is to use the straight line distance between them because a straight line between any two points is always the shortest distance. This would be 2,451 miles and that would be our guess for _h(n)_ at the start. The real distance by road would be 2,798 miles. This is longer than _h(n)_ because our heuristic is unaware of any obstacles between the two points and how and where the roads bend. (Yes,technically, the shortest straight line distance would be to bore through the ground to get to NYC because the Earth curves, but because this is impossible for a car then we’ll have to settle for 2,451 miles).

Having the heuristic take the straight line distance between two points is an example of an admissible heuristic. The heuristic function is said to be admissible if it never overestimates the cost of reaching the goal. This function needs to be admissible to guarantee an optimal solution. If we overestimate the cost to the goal then we might take a route that is longer than optimal if the optimal route is shorter than the heuristic because we are basing our assumption that a cost lower than the heuristic is infeasible.

We will be building our environment on a grid, so the calculations for _h(n)_ will be a little different as our environment has changed and straight line distances are no longer possible. The shortest possible distance between some nodes A and B in a grid is the difference between the number of rows they are apart plus the number of columns they are apart. This is assuming you are only allowed to travel to the node directly above, below, left, or right of you. Below you can see the calculations we have for _h(n)_. (Note that these calculations will be different if you allow for diagonal movement, as a diagonal move between adjacent squares would have a distance of square root of 2).


![img](https://docs.google.com/drawings/u/0/d/ssmKzSXXNNBIFWhrVtKbG-g/image?w=349&h=103&rev=124&ac=1&parent=1_J8qp3XpQ0Esn_vAEri3gepaMCQV7HtYJ_bASslH4_o)

In the image I am also representing black squares as obstacles that our algorithm cannot travel on. Notice the ‘3’ that I have colored orange. Even though it will take more than three units of movement to go from that square to the target because of the obstacle in the way, the heuristic still applies a guess of 3 because as stated before it is unaware of the obstacles.

Recall that A* will expand the nodes that have the lowest _f(n)_. So let’s examine a slightly different scenario with _f(n)_ and _g(n)_ provided as well. From here on out I’ll be referring to _f(n)_, _g(n)_, and _h(n)_ as the F score, G score, and H score respectively. The G score is presented in the top left of each square, H score is in the top right and the F score is in the center.

![img](https://docs.google.com/drawings/u/0/d/sdhYERalNniYtfnwb4t4V9w/image?w=272&h=265&rev=298&ac=1&parent=1_J8qp3XpQ0Esn_vAEri3gepaMCQV7HtYJ_bASslH4_o)

A* will not have all of this information presented to it from the start. We are able to initialize the H scores since we just have to calculate the grid distances from each square to the target. The G scores have to be calculated when the algorithm explores those nodes because we don’t know what obstacles are in the way so we can’t be certain what the cost will be to reach that square.

From the F scores we expect the algorithm to travel down the short path of 5s. Once it realizes that it cannot go further it’ll explore the 7s. We see that there are many 7s we could explore once we are done with the 5s so the way the algorithm breaks ties is by exploring the 7s that are furthest along the path i.e. it’ll check the ones closest to the wall first. Once the algorithm explores its first 9 it will continue along either the top or bottom to the right side, towards other 9s that are further from the start.

From the GIF below we see the algorithm does just that. The squares in red are those A* has chosen to inspect and the green squares are those that A* is aware of and has their F scores but has not inspected yet.

![img](https://lh3.googleusercontent.com/SRYkNQYomCxmAkTTHo5pGs_PtcWFs8B0HATL5qipNHdq6XwwmUaODdJuEUEArFSWtV1Wlzx2eFeZV7zYR8Y5Dr6tpNABvUadiqSLiU_Rfq7hVOEOLpnH2M4z0CVrlMiQ-8VhK20)


**Creating the environment**

Phew! Now that we have the explanation done, let’s see how we can implement this! First things first, we need to build the environment that will run A*. For this you will need the pygame package. To install simply type the below command in your terminal.


```
python3 -m pip install -U pygame --user
```


To check if the installation worked run one of their included examples:


```
python3 -m pygame.examples.aliens
```


This package will allow us to display the grid that we make. First let’s start by testing that everything works. We will create a small window in pygame with a grey background. Sounds simple enough. I won’t be explaining this code in detail as this is not a pygame tutorial and I believe the comments speak for themselves. I will be calling this file **main_loop.py**


```
import pygame

# initializes all imported pygame modules
pygame.init()

# Set the size of the screen (horizontal, vertical)
WINDOW_SIZE = (300, 150)
screen = pygame.display.set_mode(WINDOW_SIZE)

# Create a title for our window
pygame.display.set_caption("A* Pathfinder")

# This clock manages how fast the screen updates
clock = pygame.time.Clock()

# loop until the user clicks the close button
done = False

# ==== MAIN GAME LOOP ====
while not done:
    # ---- Main event loop ----
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done = True

    # Clears the screen and sets a background color
    # requires an RGB 3-tuple
    screen.fill((100,100,100))

    # ---- Draw the Grid Here ----

    # ----------------------------

    # Updates the whole screen with what we've drawn.
    pygame.display.flip()

    # set framerate of our game
    clock.tick(100)

pygame.quit()
```


As expected this code creates the small windows shown below with a grey background. Perfect!

![img](https://lh4.googleusercontent.com/i9MdP8eswGxx9MySKR8H9uopLoBzO8OHaG1TMGs7Me1AfTwzFYl98aZ8X1EOddZwDUmRo6X5TXDaRWjhtQmt5OyYnCOrbFfh1IT_dN38gv5PWNJNPNv2A0WwVQY-S6HnFzmb4vo)


We’re going to want more than this though, let’s try to print a grid to the screen. Think about what we want our grid to be. Typically, a grid looks like a 2-D matrix with some number of rows and some number of columns. We’ll want our grid to be filled with squares and maybe we want a small amount of space between the squares so we can easily define each square’s boundaries. So let’s start there first.

I will create a new file called **macros.py** which will be responsible for storing many of our constants. We want to be consistent with some declarations throughout all of our files so we will place those constants here. If we ever want to make a change to the sizes of our squares or anything else found in this file we won’t have to go searching across all of our files to make those changes. To include our macros in any file simply type `from macros import *` at the top of the file.


```
#### MACROS ####
WIDTH = 20
HEIGHT = 20
MARGIN = 3
```


We’ll also want to add how many pixels long our grid should be on either side so I will add two functions, one for the width and one for the height. We don’t currently know how many squares we will have so this will be the parameter of those functions.

The number of pixels required for the width would be the number of squares we have along the x-axis times the width of each square. Margins need to be placed between each square and on the border which means we will have _n+1_ margins to account for. The height function will look very similar and we will place both of these in **macros.py**


```
# functions for pygame initialization
def get_total_pixel_width(squares_x):
    return (MARGIN + WIDTH) * squares_x + MARGIN

def get_total_pixel_height(squares_y):
    return (MARGIN + HEIGHT) * squares_y + MARGIN
```


We want to build A* so we also want to think about the different types of nodes we will have. We have the start node or seeker node, the target node, a bunch of empty nodes that our algorithm can travel across, the path our algorithm took, and to make things interesting we’ll want to add obstacles on the map that we cannot travel through. We can represent all of these types of nodes by the color they appear when displayed. So we want to add RGB values for each of these types. We will need these values in multiple files so I’ll add these as macros in **macros.py** again. Here are the colors I have chosen to use.


```
SEEKER =        (0,0,200)       # Dark Blue
TARGET =        (148,0,212)     # Magenta
PATH =          (79,148,205)    # Light BLue
EMPTY =         (240,240,255)   # Off White
OBSTACLE =      (0,0,0)         # Black
BACKGROUND =    (25,25,35)      # Light Grey
```


Great! We have our macros set up, now we’ll work on constructing the grid class. Our grid is filled with nodes so we’ll also create a node class to go with our grid. Our nodes need to know where they are located (this will be stored as a tuple) and what type of node they. These types will be represented by the color of the node, by default, if not specified I will make the nodes empty. It would also be a good idea to check when two nodes are equal. This can simply be done by checking if the two nodes share the same coordinates. We will write out node class as such in **grid.py**


```
class Node:
    def __init__(self, coordinates, color=EMPTY):
        self.color = color
        self.coordinates = coordinates

    # define equality between two nodes
    def __eq__(self, other):
        return self.coordinates == other.coordinates
```


The grid will change depending on the number of rows and columns we want to have so we will make this a parameter for initialization. At any point we may want to see how many rows or columns our grid has so we will keep that value. And, obviously we also want to create the 2D array of nodes.

We also need to include the seeker and target in our initialization. I will set some default locations that vary depending on the size of the graph which can be edited manually in the code.


```
class Grid:
    def __init__(self, num_of_rows=15, num_of_cols=25):
        self.num_of_rows = num_of_rows
        self.num_of_cols = num_of_cols
        self.grid_data = [[Node((row,col)) for col in range(num_of_cols)] for row in range(num_of_rows)]
        alpha_x = .1 # needs to be between 0 and 1
        alpha_y = .1 # needs to be between 0 and 1
        self.seeker_coor = (
            int((num_of_rows - 1) * alpha_y), 
            int((num_of_cols - 1) * alpha_x))
        self.target_coor = (
            int(num_of_rows * (1-alpha_y)), 
            int( num_of_cols * (1-alpha_x)))
        self.grid_data[self.seeker_coor[0]][self.seeker_coor[1]] = 
        Node(self.seeker_coor, SEEKER)
        self.grid_data[self.target_coor[0]][self.target_coor[1]] = 
        Node(self.target_coor, TARGET)
```


While we’re creating this file we might as well add a couple of functions within the grid class that we will surely need. We will create two for now. One that allows us to fetch a node from the grid from its coordinates and another which lets us set a node's color from its coordinates.


```
    def get_node(self, coordinates):
        row, col = coordinates
        return self.grid_data[row][col]

    def set_color(self, node_coor, color):
        node = self.get_node(node_coor)
        #don't draw over the seeker and target
        if node.color == SEEKER or node.color == TARGET:
            return
        node.color = color
```


Fantastic! Let’s make a couple tweek to **main_loop.py** so we can display our new grid. At the top of the file we’ll want to initialize our grid. Next, we’ll have to make the size of the pygame window depend on how many squares we have in our grid and their sizes. Thankfully the legwork for that was completed in **macros.py** so we don’t have to do much there. The top of **main_loop.py** should look something like this now


```
import pygame

# importing our files
import grid
from macros import *

main_grid = grid.Grid()

# initializes all imported pygame modules
pygame.init()

# Set the size of the screen
total_height = get_total_pixel_height(main_grid.num_of_rows)
total_width = get_total_pixel_width(main_grid.num_of_cols)
WINDOW_SIZE = (total_width, total_height)
screen = pygame.display.set_mode(WINDOW_SIZE)
```


Alright now that we have that done we still need to draw each square of the grid in the window. Thankfully pygame contains a function that allows us to draw rectangles on the screen so this should be straightforward. If you noticed earlier, I added a small area within the main game loop dedicated to drawing the grid, we’ll write the below code there. We’ll need to cycle through all of the nodes in the grid with two for loops and fetch the nodes color. Then color in a square with that node’s color. (I’ve also added a small edit of changing the `screen.fill()` to fill in the background color we chose earlier).


```
   # Clears the screen and sets a background color
    # requires an RGB 3-tuple
    screen.fill(BACKGROUND)

    # ---- Draw the Grid Here ----
    for row in range(main_grid.num_of_rows):
        for col in range (main_grid.num_of_cols):
            node = main_grid.get_node((row,col))
            pygame.draw.rect(
                screen,
                node.color,
                [get_total_pixel_width(col),
                get_total_pixel_height(row),
                WIDTH,
                HEIGHT]
                )
    # ----------------------------
```


Our helper functions from **macros.py** happen to also get the start locations of any cell as the expression was the same, so we can just pop those in! I know I said this isn’t a tutorial on pygame but I think some explanation is needed for the list in the drawing function. The first two elements dictate the starting location of our square or rectangle. These two values create the top leftmost coordinate of the square. The third and fourth elements state how far down the width and height axes our squares extend.

Running **main_loop.py** now gets us our default grid!

![img](https://lh5.googleusercontent.com/Aq24f-ckTT5Yxwwdz_J-o2c7vlbzocqYcXB999fQymQBMrDdrwTv-a38BF6Oae-ovYcgwyDXfSKe51YyAXSNCCEvQsPiuQ1rDlbQpCVZryAOCl6dm3XHMzCB9EKTGigpQ8o4ytU)


We can finally see all of our beautiful squares! With our seeker node in the top left and our target at the bottom right.

**Adding Obstacles**

But running A* on this grid will not be interesting, the algorithm will basically make a beeline to the target and terminate. Let’s make it a little bit harder by creating a basic obstacle course for our algorithm to traverse.

We will accomplish this by adding a maze creation function in our grid class. I will create a very simple maze by iterating across every node in the grid and with a 30% change I’ll turn it into an obstacle. We will need to `import random` at the top of **grid.py** first though. I will place this function inside the grid class as so


```
    # creates a basic random maze
    def create_maze(self):
        for i in range(self.num_of_rows):
            for j in range(self.num_of_cols):
                rand_val = random.randint(1,10)
                if rand_val <= 3:
                    self.set_color((i,j), OBSTACLE)
```


We want to use the `set_color()` function we made earlier instead of setting the node color directly because we do not want to overwrite our seeker and target nodes.

Now all that’s left to do is add the single line `main_grid.create_maze()` in **main_loop.py** right under where we placed `main_grid = grid.Grid()`. When we run the file now we see this




![img](https://lh4.googleusercontent.com/B3P7lU_DJ7zFBFGsfNwVn5OdtUC-vz8BKKlwrLeY-EWfAjR74wNWzCX9IH1sXoIdRVvh_TwypEglN34UDs1PJXUTZXaxAjLnJRC5tFqti8elRZyyvzEK31-eVTVrz229KSYamBU)


This maze generation is not the most elegant and feel free to substitute your own if you’d like! If you are interested in creating your own, I’d recommend using recursive division or a depth first search based maze generator. I like how those look the best but there are many other methods to explore!

**Implementing A***

We have now created a fully functioning environment for our pathfinding algorithm. All that’s left is to construct A*.

We’ll have to first figure out which nodes we want to inspect. A* bases this guess on the lowest F score of a node it knows exists but has yet to inspect. We can store all of the nodes that we know exist in some data structure and then pull the node with the smallest F score from it (we’ll call this the current node). Then we’ll look through the neighbors of the current node to see which ones are new to us and add those into the data structure. If we can construct a shorter path to current’s neighbor from the current node than the previously known best path then we’ll want to make the current node its predecessor. Since a previously unexplored node would have an infinite G score since no route to it is known then when we first discover a node we have also found the best known path. So we can save ourselves a few lines of code and not create a distinction between known nodes and newly explored nodes. We will also still need to check if the node is already in our data structure either way.

The most efficient data structure for us to use here is a heap. We will be using a binary min heap because the node at the top of the heap will always have the lowest F score so we can pop it in _O(logn)_ time. Pushing to the heap will take the same time as well. 

Before working on the A* file we’ll have to make some edits to our Node class. Above, we described a few more fields that each node will need to have. Those being the G score, F score and predecessor. Since the F score is a function of the G score and H score then we’ll need to add the H score as well and additionally we’ll turn the F score into a get function instead of a field so we don’t have to remember recalculating it. One last thing we’ll need to add to the Node class are inequality comparisons. Our heap has no concept of how to sort our nodes so we’ll have to explain it by defining the `__lt__()` function (stands for ‘less than’) for our class. The ‘smaller’ node will be the one that has the lower F score but if there is a tie we will break that tie depending on which node has the higher G score. Our Node class should look something like this now (please note that you will have to `import math` to get infinity in python3.5 or higher)


```
class Node:
    def __init__(self, coordinates, color=EMPTY):
        self.color = color
        self.coordinates = coordinates
        self.g_score = math.inf
        self.h_score = math.inf
        self.predecessor = None

    # Since f is a function of g and h, we will call
    # a function to fetch the f score
    def get_f_score(self):
        return self.g_score + self.h_score

    # used to compare two nodes in the heap
    def __lt__(self, other):
        if self.get_f_score() == other.get_f_score():
            return self.g_score > other.g_score
        return self.get_f_score() < other.get_f_score()
    
    # define equality between two nodes
    def __eq__(self, other):
        return self.coordinates == other.coordinates
```


After all that we can start on the **astar.py** file. At this point I was planned on writing the pseudocode for A* first, but since it would look so close to Python, I’ll put the real code here. I also decided to `import heapq` for my heap but if you’d prefer to construct your own, feel free to!


```
def astar_search(main_grid):
    # First let's get our seeker and target so we know
    # where to begin and where we are going
    seeker_node = main_grid.get_node(main_grid.seeker_coor)
    target_node = main_grid.get_node(main_grid.target_coor)

    # set the h score of every node in the grid based
    # on the the best estimate that we can obtain
    init_h(main_grid, target_node)

    # we know the seeker is where we are starting
    # so the seeker's distance from start is zero
    seeker_node.g_score = 0

    # commonly referred to as the open set.
    # set of nodes that we want to explore
    nodes_of_interest = []
    heapq.heappush(nodes_of_interest, seeker_node)

    while nodes_of_interest: #while list is not empty

        #get node with lowest f score in nodes of interest
        curr_node = heapq.heappop(nodes_of_interest)
        if curr_node == target_node:
            # Yay we are done!
            return reconstruct_path(curr_node)

        neighbors_of_curr_node = get_neighbors(main_grid, curr_node)
        for neighbor in neighbors_of_curr_node:
            # The distance between any two adjacent nodes is always 1
            # in this grid, hence + 1. Otherwise the added value would be the 
            # weight of the edge between the current node and the neighbor
            temp_g = curr_node.g_score + 1

            # If the path from curr_node to this neighbor is better
            # than any previously know path, set curr_node as its 
            # predecessor and update its g_score
            if temp_g < neighbor.g_score:
                neighbor.predecessor = curr_node
                neighbor.g_score = temp_g

                if neighbor not in nodes_of_interest:
                    heapq.heappush(nodes_of_interest, neighbor)

    # No path found
    return []
```


You may have noticed that I have highlighted three functions in yellow (`init_h(), reconstruct_path(), `and` get_neighbors()`). We still need to construct these for our algorithm to work. 

The first function `init_h()` is relatively straightforward. All we want to do here is cycle through every node in the graph and set its H score. We will call a helper function to calculate what the H score should be. The H score calculation is as we described it above _all the way back_ in the beginning of this blog. If you don’t remember that’s fine. On a grid where no diagonal moves are allowed, the H score is the absolute difference between the row values of a node and the target plus the absolute difference between their column values. Hence, our `init_h()` and `calculate_h_score()` look like so


```
# calculating using the manhattan distances
def calculate_h_score(curr_node, target_node):
    curr_row, curr_col = curr_node.coordinates
    target_row, target_col = target_node.coordinates
    distance = abs(curr_row - target_row) + abs(curr_col - target_col)   
    return distance

def init_h(main_grid, target_node):
    for i in range(main_grid.num_of_rows):
        for j in range(main_grid.num_of_cols):
            node = main_grid.grid_data[i][j]
            node.h_score = calculate_h_score(node, target_node)
```


Next, we’ll work on `get_neighbors()`. This function should inspect the neighbor to the north, south, east, and west of the current node and for each of them, check if that node’s coordinates is within the bounds of the grid and if it’s an obstacle. If it’s out of bounds or an obstacle then do not include it as a neighbor to search. Please note that the top of the grid is at row 0. So you have to decrement the row to get the coordinates of the northern neighbor (or increment for southern).


```
# determines if it is possible to travel to this neighbor
def is_valid_neighbor(main_grid, neighbor_coor):

    n_row, n_col = neighbor_coor
    # check bounds of grid
    if n_row >= main_grid.num_of_rows or n_col >= main_grid.num_of_cols:
        return False
    if n_row < 0 or n_col < 0:
        return False

    neighbor_node = main_grid.get_node(neighbor_coor)
    if neighbor_node.color == OBSTACLE:
        return False

    return True


# finds the neighbors of the current_node and 
# stores them in a list to be returned
def get_neighbors(main_grid, curr_node):
    row, col = curr_node.coordinates
    neighbor_list = []

    possible_neighbors = [
        (row-1, col), #Northern
        (row+1, col), #Southern
        (row, col-1), #Eastern
        (row, col+1)  #Western
    ]
    
    for neighbor_coor in possible_neighbors:
        if is_valid_neighbor(main_grid, neighbor_coor):
            neighbor_node = main_grid.get_node(neighbor_coor)
            neighbor_list.append(neighbor_node)

    return neighbor_list
```


Finally, we come to `reconstruct_path()`. This function should return all nodes on the path A* has chosen. This is where the predecessor field comes in handy. We will simply follow the path backward from the target to the seeker via each node’s predecessor, appending all nodes we encounter to a queue. I have chosen to use `collections.deque` as my FIFO queue. (You can use a standard Python list later as well but later on I will want to get and remove the first element of the list. With the standard Python list, the way to do this is to do `list.pop(0)` but this runs in linear time because of the way it works. `Deque` contains the `popleft()` method which performs the same action but runs in constant time you will need to `import collections` for this)


```
def reconstruct_path(node):
    path = collections.deque([])
    # This will stop at the seeker because
    # the seeker has no predecessor
    while node.predecessor:
        path.appendleft((node.coordinates, PATH))
        node = node.predecessor
    
    return path
```


We could just do the recoloring on the spot in `reconstruct_path()` but we will not, to set up for later.

All that’s left to do to see our path is to add three lines in **main_loop.py** right under where we created the maze, like so


```
main_grid = grid.Grid()
main_grid.create_maze()

path = astar.astar_search(main_grid)
for node_coor, color in path:
    main_grid.set_color(node_coor, color)
```


Our `astar_search()` function will return the list of node coordinates and the color we should set them to so the above code just cycles through this list and calls the `set_color()` method.

When we run **main_loop.py** this time we get this output.

![img](https://lh5.googleusercontent.com/VBvarjIf-GHIzdpUOCFdaxapeS-EeJUJXFuhCkGU3r5dcDA_-xUPQWhOCnSFl3XIdUT4ymc9ZGH8aHrb-tl2WV7MeIbI-N20gQwYtLikZKqYeDPNaqg-EK13m8ToXOx1Z2tF9NI)


Awesome! We now see the optimal path!

If this is all you came here for then give yourself a pat on the back and go use your code for whatever you need! For those that want to stick around I’ll be adding just a little bit more code here so we can better see how A* performs and get the intuition behind the algorithm in our head.

**Visualizing Decisions**

Remember all those nodes we found interesting enough to add to our heap? What if we set a color to each of those interesting nodes and if that node was interesting enough for us to inspect, what if we recolored it to something else? And that’s exactly what I plan to do! 

Add two more colors in **macros.py**


```
INTERESTING =   (25,255,25)     # Green
INSPECTED =     (230,40,40)     # Red
```


A small change is needed in **grid.py** in the Node class. Add a boolean field called `checked`  with a default value of `False` in the class so the constructor looks as shown below. I’ll explain the importance of this field later


```
class Node:
    def __init__(self, coordinates, color=EMPTY):
        self.color = color
        self.coordinates = coordinates
        self.g_score = math.inf
        self.h_score = math.inf
        self.predecessor = None
        self.checked = False
```


Then we move back to **astar.py**. We’ll need to keep all the decisions made by A* in a list. We will use `collections.deque` again. All the way at the top of `astar_search()` write this line


```
    astar_pathing = collections.deque([])
```


We want to return all of the decisions made by A* along with the reconstructed path this time. So we’ll append these two lists together when we reach the target node. 


```
        curr_node = heapq.heappop(nodes_of_interest)
        if curr_node == target_node:
            # Yay we are done!
            return astar_pathing + reconstruct_path(curr_node)
```


Since the current node was just removed from the heap then we are also inspecting it. So we will append the current node’s coordinates to `astar_pathing` with the `INSPECTED` color and set the node’s `checked` state to `True`. We’ll place this code right before we get the current node’s neighbors.


```
        # colors A*'s decisions
        curr_node.checked = True
        astar_pathing.append((curr_node.coordinates, INSPECTED))

        neighbors_of_curr_node = get_neighbors(main_grid, curr_node)
```


When we add the interesting nodes to `astar_pathing` the use of the `checked` field comes in. We only want to color a node `INTERESTING` if it has not already been inspected. This is because inspecting a node is ‘stronger than’ the node just being found interesting. So we don’t want to constantly recolor nodes as interesting if we have already inspected them. We’ll want to mark nodes as interesting if they are a neighbor of the current node and haven’t already been `checked`.


```
        for neighbor in neighbors_of_curr_node:

            # colors A*'s decisions
            if not neighbor.checked:
                astar_pathing.append((neighbor.coordinates, INTERESTING))
```


Finally, even if we don’t find a path to our target, we still want to see what A* did so we’ll `return astar_pathing` upon failure.

Here is the entire code starting at the while loop of `astar_search()` which shows all the changes I just made to it.


```
    while nodes_of_interest: #while list is not empty

        #get node with lowest f score in nodes of interest
        curr_node = heapq.heappop(nodes_of_interest)
        if curr_node == target_node:
            # Yay we are done!
            return astar_pathing + reconstruct_path(curr_node)

        # colors A*'s decisions
        curr_node.checked = True
        astar_pathing.append((curr_node.coordinates, INSPECTED))

        neighbors_of_curr_node = get_neighbors(main_grid, curr_node)

        for neighbor in neighbors_of_curr_node:

            # colors A*'s decisions
            if not neighbor.checked:
                astar_pathing.append((neighbor.coordinates, INTERESTING))

            # The distance between any two adjacent nodes is always 1
            # in this grid, hence + 1. Otherwise the added value would be the 
            # weight of the edge between the current node and the neighbor
            temp_g = curr_node.g_score + 1

            # If the path from curr_node to this neighbor is better
            # than any previously know path, set curr_node as its 
            # predecessor and update its g_score
            if temp_g < neighbor.g_score:
                neighbor.predecessor = curr_node
                neighbor.g_score = temp_g

                if neighbor not in nodes_of_interest:
                    heapq.heappush(nodes_of_interest, neighbor)

    return astar_pathing
```


Run **main_loop.py** and let’s see what we get now,

![img](https://lh3.googleusercontent.com/-3oIR-fj933E_fr9mndTnJ0ZQ3mJ9pEj7FSsu7pNZb2YlgB-2VAbB8N_fe_Q0vSw5ZHK6tmHP_Dq9otqL0HbCxatmV21jHJDoUoxJTM9ATRjave2jhP09J_DvBtySO09CcsCIBw)


Looks good, just what we wanted! This information confirms what we already know. A* has knowledge of where the target is and attempts to rush towards it. At the beginning it got stuck at the wall below the seeker before realizing it needs to make a lot of eastward moves first. Once it has gone east far every decision puts it one step closer to the goal and makes a direct line to it.

Different pathfinding algorithms will still give you the optimal path but which and how many nodes were labelled interesting and inspected with change between algorithms. Colored those in will give an intuitive idea of how the algorithm performs.

We only obtain the final picture here though, let’s try to see the decisions step by step. We’ll also show the decisions only when we are ready.

This will only require a few changes in **main_loop.py**. We can move the code that sets the colors of A*’s pathing into the main game loop. The game loop runs a hundred times per second so instead of coloring all the squares at once before we begin pygame, we can change the color of one square each time the main game loop executes.

First, we’ll remove these two lines of code


```
for node_coor, color in path:
    main_grid.set_color(node_coor, color)
```


From **main_loop.py**. We’ll then add another boolean for when we want to start showing the pathing. We’ll just add this by our `done` variable and initialize it to `False`. 


```
# loop until the user clicks the close button
done = False
start = False
```


Let’s look at the events that pygame has. One event that it detects is a mouse button press. If you want to see what other event types pygame detects you can find the list [here](https://riptutorial.com/pygame/example/18046/event-loop). We can specify which mouse button, left, middle, or right but we won’t worry about that at the moment. All we need to do here now is add another conditional statement nested within the for loop that cycles through the events. This condition will set our `start` variable to `True`.


```
    # ---- Main event loop ----
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done = True
        if event.type == pygame.MOUSEBUTTONDOWN:
            start = True
```


Right under that, and before we fill the screen with our background color we’ll detect if we should start showing the path and if so, then we’ll remove and color the nodes found in `path` until it is empty.


```
    if start:
        if path:
            node_coor, color = path.popleft()
            main_grid.set_color(node_coor, color)
```


And that’s it! We’re officially done! Let’s see what we’ve made.

![img](https://lh6.googleusercontent.com/oKTPWxxkLtE54ouxtIhJoN26cNEpieU8P9-q9O8mhUX9ZqbhaA9_iKU6hgbmyNGjpc5o2oRu1aJ0OEIiLpU1pbni9G30XRzVOGrlLYIyP3yJYMmfSBpd4c99MdnHA9VKUknwXBE)


Impressive! Now we’re able to see all the decisions A* made trying to get to the target. The speed is tied to the framerate so if you want to slow it down, you can reduce the clock tick rate.

**Improvements and Extensions**

There are still several improvements that can be made but I’ll leave it here for now. If you are interested in working with this some more, I can suggest a few modifications you may pursue.



*   Creating a better maze generation algorithm or even several
*   Adding other pathfinding algorithms
*   Allow the user to draw obstacles themselves
*   Let the user move the seeker and target by dragging the mouse
*   Creating nodes that can be travelled on but have a higher cost than normal
*   Update only the changes made to the grid instead of redrawing the entire grid (use `pygame.display.update(...) `instead of `pygame.display.flip()`)

If you plan on making new algorithms then you can check one more off because by creating A* you just need to change one line to get Dijkstra’s! Dijktra’s algorithm makes decisions based on how far the nodes are from the start and doesn’t use a heuristic function. If the nodes it’s interested in, it chooses the ones closest to the start to inspect. Essentially, this means the F score would just be based on the G score. So if we edit `h_init()` to set every node’s H score to zero, then we coded Dijkstra’s algorithm! On the grid it would look like this.

![img](https://lh5.googleusercontent.com/NT0RqDSkNiPxVJp_udh_B1NCI7v9NT4l42W7NjsuS1ADLCjrwVT-0P-GfVs_Q0b8euzXFY_zm68ikUutiq0R4HbGrGuvVr3sdUoKblZstv9WLLHULkfzVMjD81rkFf4UWR84cHU)


One final thought. When explaining A* I stated that if you overestimate the heuristic function then it is no longer admissible and your algorithm may not return an optimal solution. Let’s see what happens if we make all the H scores infinity.


![img](https://lh6.googleusercontent.com/ZMjWafOWzadIOzqygr3GYHfST9JKGQfdhbeeNHCMQFlrdGbCnRg8h8eEGRurWd0T2OMGuLLxAusQsVuD3aoZ-TWeWjjm9gZV_ja-E2Ysz4_aYNpY3ttdJ_LUmY2yFUecNFv7Tmk)


Wow that’s bad!

Thanks for reading!