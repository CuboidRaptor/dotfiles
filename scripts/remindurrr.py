#!/usr/bin/env python3

import tkinter as tk
import random
import copy

from tkinter import ttk

COLORS = [
    ("#f38ba8", "Red"),
    ("#fab387", "Orange"),
    ("#f9e2af", "Yellow"),
    ("#a6e3a1", "Green"),
    ("#89b4fa", "Blue"),
    ("#cba6f7", "Purple"),
]
colors_testing = copy.deepcopy(COLORS)
# make extra shuffled lists for the stroop effect to take place
COLORS2 = random.sample(COLORS, len(COLORS))
COLORS3 = random.sample(COLORS, len(COLORS))
ROWS = 2
COLS = 3
FONTNAME = "Ubuntu"

root = tk.Tk()
root.geometry("400x300+50+50")
root.wm_attributes("-type", "splash")
root.wm_attributes("-topmost", True)

top_text = tk.Label(root, text="touch grass", font=(FONTNAME, 24))
top_text.pack()

button_frame = tk.Frame(root)
button_frame.pack()

def rcindex(r: int, c: int) -> int:
    # based on a row/col number, generate a unique index
    global COLS
    return r * COLS + c

def clicked(color: str) -> None:
    # clicked event handler
    global COLORS
    global root, colors_testing
    if color != colors_testing[0][0]:
        print("invalid click, resetting...")
        print(COLORS, colors_testing)
        colors_testing = copy.deepcopy(COLORS)
        print(COLORS, colors_testing)

    else:
        del colors_testing[0]
        print("valid click")

        if colors_testing == []:
            print("finished, exiting...")
            root.destroy()

# make all ze buttons
for r in range(0, ROWS):
    for c in range(0, COLS):
        ind = rcindex(r, c)
        b = tk.Button(
            button_frame,
            text=COLORS2[ind][1],
            font=(FONTNAME, 14),
            fg=COLORS3[ind][0],
            bg="#11111b",
            command=(lambda x=COLORS3[ind][0]: clicked(x))
        )
        b.grid(row=r+1, column=c+1)

root.mainloop()
