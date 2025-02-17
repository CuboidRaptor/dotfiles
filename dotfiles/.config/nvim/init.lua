-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("colorizer").setup({
  "html",
  "css",
  "javascript",
})

-- harpoon setup
local harpoon = require("harpoon")
harpoon:setup()

-- setup guess-indent.nvim
require("guess-indent").setup({})

-- indentation settings
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4 -- default tab width for new files

-- rose pine colorscheme
require("rose-pine").setup({
  variant = "main",
  dark_variant = "main",
})
vim.cmd.colorscheme("rose-pine")
