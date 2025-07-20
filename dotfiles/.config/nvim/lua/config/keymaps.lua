-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- leader key is set in options.lua
local leader = "," -- set custom leader because I'm too lazy to deal with plugins
    -- overwriting my bindings
local map = vim.keymap.set
local telescope = require("telescope.builtin")

map("n", "<Home>", "^", { remap = true, desc = "Go home, after indents" })
map("i", "<Home>", "<Esc>^i", { remap = true, desc = "Go home, after indents" })
map("v", "<Home>", "^", { remap = true, desc = "Go home, after indents" })

-- space key inserts space in normal mode
map("n", " ", "a <Esc>", { remap = true, desc = "Insert Space" })

-- stay on current word when searching (but with ,s instead of *)
vim.keymap.set("n", ",s", function()
    vim.fn.setreg("/", [[\V\<]] .. vim.fn.escape(vim.fn.expand("<cword>"), [[/\]]) .. [[\>]])
    vim.fn.histadd("/", vim.fn.getreg("/"))
    vim.o.hlsearch = true
end)
vim.keymap.set("v", ",s", function()
    local old_reg = vim.fn.getreg('"')
    local old_regtype = vim.fn.getregtype("\'")
    vim.cmd([[noau normal! ""y]])
    vim.fn.setreg("/", [[\V]]
        .. vim.fn.substitute(vim.fn.escape(vim.fn.getreg('"'), [[/\]]), [[\_s\+]], [[\\_s\\+]], "g"))
    vim.fn.histadd("/", vim.fn.getreg("/"))
    vim.o.hlsearch = true
    vim.fn.setreg('"', old_reg, old_regtype)
end)

-- allow Esc in terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { remap = true, desc = "Escape in Terminal Mode" })

map("i", leader .. "h", "#!/usr/bin/env ", { remap = true, desc = "Env Shebang" })
map("n", leader .. "h", "a#!/usr/bin/env ", { remap = true, desc = "Env Shebang and Insert" })

map("n", leader .. "w", ":SudaWrite", { remap = true, desc = "Save with Sudo" })

-- Enter in normal mode now just inserts a newline on the next line without leaving normal
map("n", "<CR>", "o<Esc>", { remap = true, desc = "Insert Newline" })

map("n", leader .. "q", "@q", { remap = true, desc = "Send Q Macro" })

-- Telescope bindings
map("n", leader .. "b",
    function() telescope.buffers({ sort_mru = true, path_display = { "filename_first", "truncate" } }) end,
    { remap = true, desc = "Telescope Buffers" })
map("n", leader .. "g",
    function() telescope.git_files({ path_display = { "filename_first", "truncate" } }) end,
    { remap = true, desc = "Telescope Git Repo Files" })
map("n", leader .. "f",
    function() telescope.find_files({ path_display = { "filename_first", "truncate" } }) end,
    { remap = true, desc = "Telescope Current Directory" })
map("n", leader .. "t", telescope.treesitter, { remap = true, desc = "Telescope Treesitter" })
