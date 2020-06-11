import pygame

# importing our files
import grid
import astar
from macros import *

main_grid = grid.Grid()
main_grid.create_maze()

path = astar.astar_search(main_grid)

# initializes all imported pygame modules
pygame.init()

# Set the size of the screen
total_height = get_total_pixel_height(main_grid.num_of_rows)
total_width = get_total_pixel_width(main_grid.num_of_cols)
WINDOW_SIZE = (total_width, total_height)
screen = pygame.display.set_mode(WINDOW_SIZE)

# Create a title for our window
pygame.display.set_caption("A* Pathfinder")

# This clock manages how fast the screen updates
clock = pygame.time.Clock()

# loop until the user clicks the close button
done = False
start = False

# ==== MAIN GAME LOOP ====
while not done:
    # ---- Main event loop ----
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            done = True
        if event.type == pygame.MOUSEBUTTONDOWN:
            start = True

    if start:
        if path:
            node_coor, color = path.popleft()
            main_grid.set_color(node_coor, color)

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

    # Updates the whole screen with what we've drawn.
    pygame.display.flip()

    # set framerate of our game
    clock.tick(100)

pygame.quit()


