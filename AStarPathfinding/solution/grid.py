from macros import *
import pygame
import random
import math


class Node:
    def __init__(self, coordinates, color=EMPTY):
        self.color = color
        self.coordinates = coordinates
        self.g_score = math.inf
        self.h_score = math.inf
        self.predecessor = None
        self.checked = False

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

    def reset(self):
        self.g_score = math.inf
        self.h_score = math.inf
        self.predecessor = None
        self.checked = False


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
        self.grid_data[self.seeker_coor[0]][self.seeker_coor[1]] = \
        Node(self.seeker_coor, SEEKER)
        self.grid_data[self.target_coor[0]][self.target_coor[1]] = \
        Node(self.target_coor, TARGET)

    # take mouse position and convert it to grid coordinates
    def convert_to_sq_coor(self, pos):
        col = pos[0] // (WIDTH + MARGIN)
        row = pos[1] // (HEIGHT + MARGIN)
        #make sure col and row arent out of bounds
        if col >= self.num_of_cols:
            col = self.num_of_cols - 1
        if row >= self.num_of_rows:
            row = self.num_of_rows - 1
        return (row, col)

    # Returns the node at the given grid coordinates
    def get_node(self, coordinates):
        row, col = coordinates
        return self.grid_data[row][col]

    # Sets the color of the node at the given grid coors
    def set_color(self, node_coor, color):
        node = self.get_node(node_coor)
        #don't draw over the seeker and target
        if is_needed(node.color):
            return
        node.color = color

    # creates a basic random maze in the grid
    def create_maze(self):
        for i in range(self.num_of_rows):
            for j in range(self.num_of_cols):
                rand_val = random.randint(1,10)
                if rand_val <= 3:
                    self.set_color((i,j), OBSTACLE)
