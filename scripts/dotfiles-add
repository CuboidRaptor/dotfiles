#!/usr/bin/env python3
# only works for linux, and files in home directory of current user
# dotfiles repo must also be in /home/$USER/dotfiles

import sys
import getpass
import shutil
import os
import re

tgt_file = os.path.abspath(sys.argv[1])
strip_user = re.compile(r".*" + getpass.getuser() + r"/(.*)")
stripped_path = strip_user.match(tgt_file).group(1)

dotfiles_dir = f"/home/{getpass.getuser()}/dotfiles/dotfiles/" # change for different dotfile repo location

try:
    os.mkdir(dotfiles_dir)

except FileExistsError:
    print("DEBUG: dotfiles/dotfiles/ exists")

os.makedirs(os.path.dirname(dotfiles_dir + stripped_path), exist_ok=True)

shutil.move(tgt_file, dotfiles_dir + stripped_path)

os.symlink(dotfiles_dir + stripped_path, tgt_file)

print(f"DEBUG: Moved/symlinked to/from {dotfiles_dir + stripped_path}")
print("Done!")
