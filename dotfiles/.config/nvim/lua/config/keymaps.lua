-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

LEADER_1 = "," -- leader key go brrrr

vim.keymap.set("n", "<Home>", "^", { remap=true, desc="Go home, after indents" })
vim.keymap.set("i", "<Home>", "<Esc>^i", { remap=true, desc="Go home, after indents" })
vim.keymap.set("v", "<Home>", "^", { remap=true, desc="Go home, after indents" })

-- allow Esc in terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { remap=true, desc="Escape in Terminal Mode" })

-- code runner!
vim.keymap.set("n", "<F5>", ":w<CR>:RunCode<CR>i", { remap=true, desc="Run Code" })
vim.keymap.set("i", "<F5>", "<Esc>:w<CR>:RunCode<CR>i", { remap=true, desc="Run Code" })
vim.keymap.set("t", "<F5>", "<Esc><C-w><C-k>:w<CR>:RunCode<CR>i", { remap=true, desc="Run Code" })
    -- allow reruns directly from terminal

vim.keymap.set("i", LEADER_1 .. "h", "#!/usr/bin/env ", { remap=true, desc="Env Shebang" })
vim.keymap.set("n", LEADER_1 .. "h", "a#!/usr/bin/env ", { remap=true, desc="Env Shebang and Insert" })

vim.keymap.set("n", LEADER_1 .. "s", ":SudaWrite", { remap=true, desc="Save with Sudo" })

-- Enter in normal mode now just inserts a newline on the next line without leaving normal
vim.keymap.set("n", "<CR>", "o<Esc>", { remap=true, desc="Insert Newline" })
