from random import random, seed
from math import floor

FIELDS = ["AIRPORT", "SEATS", "OCCUPIED", "TIME"]
AIRPORTS = ["LAX", "JFK", "LAX", "YVR"] # Los Angeles (x2), New York, Vancouver
AIRPORT_AVGS = {"LAX": 0.82, "JFK": 0.83, "YVR": 0.82}
SEATS = [200, 250, 450]
TIMES = ["WEEKDAY", "REDEYE", "WEEKEND"]
TIMES_ORDERED = ["WEEKDAY", "REDEYE", "WEEKDAY", "REDEYE", "WEEKDAY", "REDEYE",
                 "WEEKDAY", "REDEYE", "WEEKDAY", "REDEYE", "WEEKDAY", "REDEYE",
                 "WEEKEND", "WEEKEND", "WEEKEND", "WEEKEND", "WEEKEND", "WEEKEND"]

def format_line_item(airport, seats, occupied, time):
    return "{},{},{},{}".format(airport, seats, occupied, time)

# adds trends to the data we should be able to find by analysis
def add_information(port, seats, occupied_percent, time):
    if time == "WEEKEND" and port == "YVR":
        occupied_percent += 0.05
    if time == "REDEYE" and port == "JFK":
        occupied_percent += 0.05
    if port == "LAX" and seats != 450:
        occupied_percent += 0.05

    # canadians use percentage instead of seat count
    occupied = occupied_percent if port == "YVR" else floor(seats * occupied_percent)

    return port, seats, occupied, time

def create_book(num_weeks, seed_val):
    seed(seed_val)
    lines = [",".join(FIELDS)]
    for port in AIRPORTS:
        occupied_avg = AIRPORT_AVGS[port]
        for week in range(num_weeks // len(AIRPORTS)):

            # this gives 6 weekday, 6 REDEYE, and 6 weekend flights
            i = 0
            for time in TIMES_ORDERED:
                seats = SEATS[i % len(SEATS)]
                occupied_del = random() / 10 - 0.05  # shift of up to 5% from the average
                occupied_percent = occupied_avg + occupied_del
                i += 1

                port, seats, occupied, time = add_information(port, seats, occupied_percent, time)
                lines.append(format_line_item(port, seats, occupied, time))

    return lines


def validate_lines(line_items):
    for line in line_items[1:]:
        line_arr = line.split(',')
        if line_arr[2] > line_arr[1]:
            print("ISSUE ON LINE:", line, line_arr[2], line_arr[1])
            return False

    return True


line_items = create_book(num_weeks=100, seed_val=1)
if not validate_lines(line_items):
    exit(1)

line_count = len(line_items)
# print(line_count)

line_items_chronological = [",".join(FIELDS)]
section_size = (line_count-1) // len(AIRPORTS)
for flight_index in range(1, section_size):
    for port_index in range(len(AIRPORTS)):
        line_items_chronological.append(line_items[flight_index + port_index * section_size])

[print(flight) for flight in line_items_chronological]
