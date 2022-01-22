import os
layouts = ['us', 'latam']

HOME_DIR = os.getenv("HOME")

def swap_layout():
    with open(f'{HOME_DIR}/.config/awesome/keyboard.kbfile', 'r') as f:
        kbmap = f.read().replace("\n", "")
    
    layouts.append(kbmap)
    del layouts[layouts.index(kbmap)]
    with open(f"{HOME_DIR}/.config/awesome/keyboard.kbfile", "w") as f:
        f.write(layouts[0])
   
    os.system(f"""setxkbmap {layouts[0]}; dunstify "new keyboard map: {layouts[0]}" """)
    print(layouts)
if __name__ == "__main__":
    swap_layout()
