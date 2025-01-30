-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

leader_1 = "," -- leader key go brrrr

vim.keymap.set("n", "x", "\"_x", { remap=false, desc="Delete" }) -- the x key no longer goes to any register
vim.keymap.set("v", "x", "\"_x", { remap=false, desc="Delete" })

vim.keymap.set("n", "<C-a>", "gg_vG$", { remap=true, desc="Select All" })
vim.keymap.set("i", "<C-a>", "<Esc>gg_vG$", { remap=true, desc="Select All" })

vim.keymap.set("n", "<Home>", "^", { remap=true, desc="Go home, after indents" })
vim.keymap.set("i", "<Home>", "<Esc>^i", { remap=true, desc="Go home, after indents" })
vim.keymap.set("v", "<Home>", "^", { remap=true, desc="Go home, after indents" })

-- code runner!
vim.keymap.set("n", "<F5>", ":w<CR>:RunCode<CR>i", { remap=true, desc="Run Code" })
vim.keymap.set("i", "<F5>", "<Esc>:w<CR>:RunCode<CR>i", { remap=true, desc="Run Code" })

-- allow Esc in terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { remap=true, desc="Escape in Terminal Mode" })