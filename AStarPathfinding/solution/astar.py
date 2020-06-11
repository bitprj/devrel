import heapq
import math
import collections
import random

import grid
from macros import *

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
        neighbor_node.checked = True # Using this to check if recalculating A* is necessary
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


def reconstruct_path(node):
    path = collections.deque([])
    # This will stop at the seeker because
    # the seeker has no predecessor
    while node.predecessor:
        path.appendleft((node.coordinates, PATH))
        node = node.predecessor
    
    return path


def astar_search(main_grid):

    astar_pathing = collections.deque([])

    # First lets get our seeker and target so we know
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

