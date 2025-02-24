-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- leader key is set in options.lua

vim.keymap.set("n", "<Home>", "^", { remap = true, desc = "Go home, after indents" })
vim.keymap.set("i", "<Home>", "<Esc>^i", { remap = true, desc = "Go home, after indents" })
vim.keymap.set("v", "<Home>", "^", { remap = true, desc = "Go home, after indents" })

-- space key inserts space in normal mode
vim.keymap.set("n", " ", "a <Esc>", { remap = true, desc = "Insert Space" })

-- allow Esc in terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { remap = true, desc = "Escape in Terminal Mode" })

vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { remap = true, desc = "Previous Buffer" })
vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { remap = true, desc = "Next Buffer" })

-- code runner!
vim.keymap.set("n", "<F5>", "<Cmd>w<CR><Cmd>RunCode<CR>i", { remap = true, desc = "Run Code" })
vim.keymap.set("i", "<F5>", "<Esc><Cmd>w<CR><Cmd>RunCode<CR>i", { remap = true, desc = "Run Code" })
vim.keymap.set("t", "<F5>", "<Esc><C-w><C-k><Cmd>w<CR><Cmd>RunCode<CR>i", { remap = true, desc = "Run Code" })
-- allow reruns directly from terminal

vim.keymap.set("i", "<Leader>h", "#!/usr/bin/env ", { remap = true, desc = "Env Shebang" })
vim.keymap.set("n", "<Leader>h", "a#!/usr/bin/env ", { remap = true, desc = "Env Shebang and Insert" })

vim.keymap.set("n", "<Leader>w", "<Cmd>SudaWrite", { remap = true, desc = "Save with Sudo" })

-- Enter in normal mode now just inserts a newline on the next line without leaving normal
vim.keymap.set("n", "<CR>", "o<Esc>", { remap = true, desc = "Insert Newline" })

vim.keymap.set("n", "<Leader>z", "@z", { remap = true, desc = "Send Z Macro" })

vim.keymap.set("n", "<Leader>b", "0d^i<BS>", { remap = true, desc = "Append current line to last one and insert" })

-- Telescope bindings
vim.keymap.set("n", "tb", "<Cmd>Telescope buffers<CR>", { remap = true, desc = "Telescope Buffers" })
vim.keymap.set("n", "tg", "<Cmd>Telescope git_files<CR>", { remap = true, desc = "Telescope Git Repo Files" })
vim.keymap.set("n", "tf", "<Cmd>Telescope find_files<CR>", { remap = true, desc = "Telescope Current Directory" })
vim.keymap.set("n", "tt", "<Cmd>Telescope treesitter<CR>", { remap = true, desc = "Telescope Treesitter" })
