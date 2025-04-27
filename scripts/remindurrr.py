#!/usr/bin/env python3

import tkinter as tk
from tkinter import ttk

root = tk.Tk()
root.geometry("400x200+50+50")
root.wm_attributes("-type", "splash")
root.wm_attributes("-topmost", True)

top_text = ttk.Label(root, text="touch grass", font=("DejaVu Sans", 18))
top_text.pack()

root.mainloop()
