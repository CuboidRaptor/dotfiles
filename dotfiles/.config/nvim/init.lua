-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("colorizer").setup({
    "html",
    "css",
    "javascript"
})

-- setup guess-indent.nvim
require("guess-indent").setup({})

-- indentation settings
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4 -- default tab width for new files

-- rose pine colorscheme
require("rose-pine").setup({
    variant="main",
    dark_variant="main"
})
vim.cmd.colorscheme "rose-pine"

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
