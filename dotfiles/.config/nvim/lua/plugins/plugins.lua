return {
    {
        "rmagatti/auto-session",
        lazy = false,

        opts = {
            -- log_level = 'debug',
        }
    },
    {
        "Saghen/blink.cmp",
        tag = "v1.3.1", -- super-tab lazyvim currently causes issues, check LazyVim/LazyVim issue #6185
        opts = {
            completion = {
                list = {
                    max_items = 1
                },
                documentation = {
                    window = {
                        max_height = 8
                    }
                }
            },
            keymap = {
                preset = "super-tab"
            },
        }
    },
    {
        "akinsho/bufferline.nvim",
        enabled = false
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
    {
        "norcalli/nvim-colorizer.lua"
    },
    {
        "NMAC427/guess-indent.nvim"
    },
    {
        "folke/noice.nvim",
        opts = {
            lsp = {
                signature = {
                    enabled = false
                }
            }
        }
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                jsonls = {},
                html = {},
                cssls = {},
                lua_ls = {},
                bashls = {
                    mason = false
                },
                clangd = {
                    mason = false
                },
                nil_ls = {
                    mason = false
                }
            }
        }
    },
    {
        "Vimjas/vim-python-pep8-indent"
    },
    {
        "gbprod/stay-in-place.nvim",
        config = function()
            require("stay-in-place").setup({})
        end
    },
    {
        "lambdalisue/vim-suda"
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            indent = {
                enable = false
            }
        }
    }
}
