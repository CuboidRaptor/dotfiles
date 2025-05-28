#!/usr/bin/env python3

import tkinter as tk
import random
import copy

COLORS = [
    ("#f38ba8", "Red"),
    ("#fab387", "Orange"),
    ("#f9e2af", "Yellow"),
    ("#a6e3a1", "Green"),
    ("#89b4fa", "Blue"),
    ("#cba6f7", "Purple"),
]
ROWS = 2
COLS = 3
FONTNAME = "Ubuntu"
TEXTCOLOR = "#cdd6f4"
SURFACE0 = "#313244"

def rcindex(r: int, c: int) -> int:
    # based on a row/col number, generate a unique index
    global COLS
    return r * COLS + c

def clicked(color: str) -> None:
    # clicked event handler
    global COLORS
    global root, colors_testing, status
    if color != colors_testing[0][0]:
        status.configure(text="incorrect")
        colors_testing = copy.deepcopy(COLORS)

    else:
        del colors_testing[0]
        status.configure(text="correct")

        if colors_testing == []:
            print("finished, exiting...")
            root.destroy()

if __name__ == "__main__":
    colors_testing = copy.deepcopy(COLORS)
    # make extra shuffled lists for the stroop effect to take place
    colors2 = random.sample(COLORS, len(COLORS))
    colors3 = random.sample(COLORS, len(COLORS))

    root = tk.Tk()
    root.geometry("400x300+50+50")
    root.wm_attributes("-type", "splash")
    root.wm_attributes("-topmost", True)
    root.configure(background=SURFACE0)

    top_text = tk.Label(root, text="touch grass", font=(FONTNAME, 24), fg=TEXTCOLOR, bg=SURFACE0)
    top_text.pack()

    button_frame = tk.Frame(root, bg=SURFACE0)
    button_frame.pack()

    # make all ze buttons
    for r in range(0, ROWS):
        for c in range(0, COLS):
            ind = rcindex(r, c)
            b = tk.Button(
                button_frame,
                text=colors2[ind][1],
                font=(FONTNAME, 14),
                fg=colors3[ind][0],
                bg="#11111b",
                highlightthickness=0,
                borderwidth=0,
                command=(lambda x=colors3[ind][0]: clicked(x))
            )
            b.configure(state="normal", relief="raised", bg="#11111b")
            b.grid(row=r+1, column=c+1)

    status = tk.Label(root, font=(FONTNAME, 14), fg=TEXTCOLOR, bg=SURFACE0)
    status.pack()

    root.mainloop()
