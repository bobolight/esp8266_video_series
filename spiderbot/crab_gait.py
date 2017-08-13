from math import sin, radians
from spiderbot_demo import *

def crab(delay=0.02, direction=1):
    # Wobbling knees
    theta = 0
    neutral(release=False)
    while True:
        group1_knees = 90 + int(sin(radians(theta)) * 30)
        group1_feet = 90 + int(sin(radians(theta+90)) * 30)
        group2_knees = 90 + int(sin(radians(theta + 180)) * 30)
        group2_feet = 90 + int(sin(radians(theta + 270)) * 30)

        for leg in (left_side[0], right_side[1], left_side[2]):
            leg.foot.position(group1_feet)
            leg.knee.position(group1_knees)

        for leg in (right_side[0], left_side[1], right_side[2]):
            leg.foot.position(group2_feet)
            leg.knee.position(group2_knees)

        sleep(delay)
        theta += direction
        if theta > 360:
            theta = 0
