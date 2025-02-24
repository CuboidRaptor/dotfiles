-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- leader key is set in options.lua
local map = vim.keymap.set
local telescope = require("telescope.builtin")

map("n", "<Home>", "^", { remap = true, desc = "Go home, after indents" })
map("i", "<Home>", "<Esc>^i", { remap = true, desc = "Go home, after indents" })
map("v", "<Home>", "^", { remap = true, desc = "Go home, after indents" })

-- space key inserts space in normal mode
map("n", " ", "a <Esc>", { remap = true, desc = "Insert Space" })

-- allow Esc in terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { remap = true, desc = "Escape in Terminal Mode" })

-- code runner!
map("n", "<F5>", "<Cmd>w<CR><Cmd>RunCode<CR>i", { remap = true, desc = "Run Code" })
map("i", "<F5>", "<Esc><Cmd>w<CR><Cmd>RunCode<CR>i", { remap = true, desc = "Run Code" })
map("t", "<F5>", "<Esc><C-w><C-k><Cmd>w<CR><Cmd>RunCode<CR>i", { remap = true, desc = "Run Code" })
-- allow reruns directly from terminal

map("i", "<Leader>h", "#!/usr/bin/env ", { remap = true, desc = "Env Shebang" })
map("n", "<Leader>h", "a#!/usr/bin/env ", { remap = true, desc = "Env Shebang and Insert" })

map("n", "<Leader>w", "<Cmd>SudaWrite", { remap = true, desc = "Save with Sudo" })

-- Enter in normal mode now just inserts a newline on the next line without leaving normal
map("n", "<CR>", "o<Esc>", { remap = true, desc = "Insert Newline" })

map("n", "<Leader>z", "@z", { remap = true, desc = "Send Z Macro" })

map("n", "<Leader>b", "0d^i<BS>", { remap = true, desc = "Append current line to last one and insert" })

-- Telescope bindings
map("n", "fb", function() telescope.buffers({sort_mru=true, path_display={"filename_first", "truncate"}}) end, { remap = true, desc = "Telescope Buffers" })
map("n", "fg", function() telescope.git_files({path_display={"filename_first", "truncate"}}) end, { remap = true, desc = "Telescope Git Repo Files" })
map("n", "ff", function() telescope.find_files({path_display={"filename_first", "truncate"}}) end, { remap = true, desc = "Telescope Current Directory" })
map("n", "ft", telescope.treesitter, { remap = true, desc = "Telescope Treesitter" })
