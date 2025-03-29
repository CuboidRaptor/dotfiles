-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = "\\"

-- vim explodes and annoys me with swap file messages
vim.cmd("set shortmess+=A")

-- me like mouse
vim.opt.mouse = 'a'

-- keep this many lines above and below when scrolling
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 15

-- don't autoformat files
vim.g.autoformat = false

-- don't sync to system clipboard unless I do explicitly with "+
vim.cmd("set clipboard=")

-- set blinking insert cursor
vim.opt.guicursor = "i:ver100-blinkwait800-blinkon400-blinkoff200"

-- I'm slow
vim.opt.timeoutlen = 1500

-- Don't auto-add comments on new lines
vim.opt.formatoptions:remove({"c", "r", "o"})

-- indentation settings
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4 -- default tab width for new files
vim.opt.cindent = true -- fix ctrl+f reindent
vim.opt.cinkeys:remove { "0#" } -- fix comments being unindented

-- auto-session options
vim.opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
