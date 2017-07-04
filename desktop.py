import colorsys
import random
import time
import subprocess
import math

from ewmh import EWMH
from razer.client import DeviceManager

# Create a DeviceManager. This is used to get specific devices
device_manager = DeviceManager()
ewmh = EWMH()


print("Found {} Razer devices".format(len(device_manager.devices)))
print()

# Disable daemon effect syncing.
# Without this, the daemon will try to set the lighting effect to every device.
device_manager.sync_effects = False

def random_color():
    rgb = colorsys.hsv_to_rgb(random.uniform(0, 1), random.uniform(0.5, 1), 1)
    return tuple(map(lambda x: int(256 * x), rgb))

keys = {
    'a': [3, 2, random_color()],
    'b': [4, 7, random_color()],
    'c': [4, 5, random_color()],
    'd': [3, 4, random_color()],
    'e': [2, 4, random_color()],
    'f': [3, 5, random_color()],
    'g': [3, 6, random_color()],
    'h': [3, 7, random_color()],
    'i': [2, 9, random_color()],
    'j': [3, 8, random_color()],
    'k': [3, 9, random_color()],
    'l': [3, 10, random_color()],
    'm': [4, 9, random_color()],
    'n': [4, 8, random_color()],
    'o': [2, 10, random_color()],
    'p': [2, 11, random_color()],
    'q': [2, 2, random_color()],
    'r': [2, 5, random_color()],
    's': [3, 3, random_color()],
    't': [2, 6, random_color()],
    'u': [2, 8, random_color()],
    'v': [4, 6, random_color()],
    'w': [2, 3, random_color()],
    'x': [4, 4, random_color()],
    'y': [2, 7, random_color()],
    'z': [4, 3, random_color()],
}


# Set random colors for each zone of each device
for device in device_manager.devices:
    c = (255, 255, 255)
    b = (100, 100, 100)
    green = (0, 255, 0)
    yellow = (100, 100, 0)
    red = (255, 0, 0)
    a = random_color()

    rows, cols = device.fx.advanced.rows, device.fx.advanced.cols

    charge_flash = True
    while True:
        for row in range(rows):
            for col in range(cols):
                device.fx.advanced.matrix[row, col] = b

        for x in range(0, ewmh.getNumberOfDesktops()):
            device.fx.advanced.matrix[1, 2+x] = c
        device.fx.advanced.matrix[1, 2+ewmh.getCurrentDesktop()] = a

        bat = int(int(subprocess.getoutput(
            "less /sys/class/power_supply/BAT0/capacity"))/10)

        status = subprocess.getoutput(
            "less /sys/class/power_supply/BAT0/status")

        charge_flash = not charge_flash

        for i in range(device.fx.advanced.cols):
            if i <= bat:
                color = yellow
                if bat >= 7:
                    color = green
                elif bat < 4:
                    color = red
                device.fx.advanced.matrix[0, 1+i] = color
            elif i == bat+1 and status == "Charging" and charge_flash:
                device.fx.advanced.matrix[0, 1+i] = b
            else:
                device.fx.advanced.matrix[0, i] = (0,0,0)


        name = subprocess.getoutput(
            "bspc query -D -d ^{} --names".format(
                1+ewmh.getCurrentDesktop()))
        name = name.lower()
        #for x in keys:
            #device.fx.advanced.matrix[keys[x][0], keys[x][1]] = b

        for x in name:
            device.fx.advanced.matrix[keys[x][0], keys[x][1]] = keys[x][2]

        device.fx.advanced.draw()
        time.sleep(0.5)
