-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("colorizer").setup({
  "html",
  "css",
  "javascript",
})

-- setup guess-indent.nvim
require("guess-indent").setup({})

local telescope = require("telescope")
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "close",
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
        ["<C-l>"] = "select_default",
      }
    }
  }
})

require("lualine").setup({
  sections = {
    lualine_x = {
      {
        function()
          if vim.api.nvim_get_option_value("modified", {}) then
            return ""
          end
          return ""
        end,
        color = { fg = "#ff7c70" }
      }
    }
  }
})

-- indentation settings
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4 -- default tab width for new files

-- rose pine colorscheme
require("rose-pine").setup({
  variant = "main",
  dark_variant = "main",
})
vim.cmd.colorscheme "rose-pine"

-- vim explode and annoys me with swap file messages
-- vim.cmd("set shortmess+=A")

vim.cmd([[set timeoutlen=420]])

-- me like mouse
vim.opt.mouse = 'a'

-- keep this many lines above and below when scrolling
vim.opt.scrolloff = 3

-- don't autoformat files
vim.g.autoformat = false

-- don't sync to system clipboard unless I do explicitly with "+
vim.opt.clipboard = ""
