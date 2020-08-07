#### MACROS ####

# size of squares in grid
WIDTH = 20
HEIGHT = 20
MARGIN = 3

# All the possible colors of nodes
SEEKER =        (0,0,200)       # Dark Blue
PATH =          (79,148,205)    # Light Blue
INTERESTING =   (25,255,25)     # Green
INSPECTED =     (230,40,40)     # Red
OBSTACLE =      (0,0,0)         # Black
BACKGROUND =    (25,25,35)      # Light Grey
EMPTY =         (240,240,255)   # Off White
TARGET =        (148,0,212)     # Magenta

# functions for pygame initialization
def get_total_pixel_width(squares_x):
    return (MARGIN + WIDTH) * squares_x + MARGIN

def get_total_pixel_height(squares_y):
    return (MARGIN + HEIGHT) * squares_y + MARGIN

def is_needed(color):
    needed_colors = [
        SEEKER,
        TARGET
    ]
    if color in needed_colors:
        return True
    return False