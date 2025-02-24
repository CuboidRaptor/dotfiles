-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("colorizer").setup({
  "html",
  "css",
  "javascript",
})

-- setup guess-indent.nvim
require("guess-indent").setup({})

require("lualine").setup({
  sections = {
    lualine_x = {
      {
        function()
          if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modified") then
            return "‼️"
          end
          return ""
        end
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
vim.cmd.colorscheme("rose-pine")
