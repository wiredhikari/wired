import subprocess
from sys import argv
import re

OUTPUT_DEVICE = subprocess.check_output(['pactl', 'get-default-sink']).decode('utf-8').replace('\n', '')

for arg in argv:
    if arg == 'set':
        subprocess.run(f"pactl set-sink-volume {OUTPUT_DEVICE} {argv[argv.index(arg)+1]}", shell=True)

VOLUME = subprocess.check_output(['pactl', 'get-sink-volume', OUTPUT_DEVICE])
VOLUME_PERCENTAGE = re.findall(r'(\d+)\%', VOLUME.decode('utf-8'))[0]

def image():
    if int(VOLUME_PERCENTAGE) >= 100:
        return "red.png"

    elif 100 > int(VOLUME_PERCENTAGE) > 50:
        return "yellow.png"
    
    return "green.png"

bar = ''
for i in range(int(int(VOLUME_PERCENTAGE)/(int(VOLUME_PERCENTAGE)/5))):
    bar += ""
bar += ""

#subprocess.run(f'dunstify --icon="$HOME/.config/scripts/volume/doc/{image()}" -t 1000 "{bar} {VOLUME_PERCENTAGE}"', shell=True)
#print(f'dunstify --icon="$HOME/.config/scripts/volume/doc/{image()}" -t 1000 "{bar} {VOLUME_PERCENTAGE}"')
