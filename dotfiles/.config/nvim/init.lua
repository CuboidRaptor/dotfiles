-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- line cursor in normal mode
-- vim.opt.guicursor = "a:ver95"

-- mini surround
require("mini.surround").setup()

-- nord colourscheme
require("rose-pine").setup({
    variant="main",
    dark_variant="main"
})
vim.cmd.colorscheme "rose-pine"

-- vim explode and annoys me with swap file messages
vim.cmd("set shortmess+=A")

-- python auto-indent settings
vim.g["python_indent"] = { 
    disable_parentheses_indenting = false,
    closed_paren_align_last_line = false,
    searchpair_timeout = 150,
    continue = "shiftwidth()",
    open_paren = "shiftwidth()",
    nested_paren = "shiftwidth()"
}

vim.cmd([[set timeoutlen=420]])
