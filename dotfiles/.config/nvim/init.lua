-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- automatically set indentation size
require("guess-indent").setup()

-- code runner plugin!
require("code_runner").setup({
    filetype = {
        java = {
            "cd $dir &&",
            "javac $fileName &&",
            "java $fileNameWithoutExt",
            "rm $fileNameWithoutExt"
        }
    }
})

-- rose pine colorscheme
require("rose-pine").setup({
    variant="main",
    dark_variant="main"
})
vim.cmd.colorscheme "rose-pine"

-- vim explode and annoys me with swap file messages
vim.cmd("set shortmess+=A")

vim.cmd([[set timeoutlen=420]])

vim.opt.smarttab = true
vim.opt.expandtab = true

-- me like mouse
vim.opt.mouse = 'a'

-- keep this many lines above and below when scrolling
vim.opt.scrolloff = 3

-- don't autoformat files
vim.g.autoformat = false

-- don't sync to system clipbaord unless I do explicitly with "+
vim.opt.clipboard = ""