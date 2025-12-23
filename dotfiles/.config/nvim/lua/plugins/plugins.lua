return {
    {
        "Saghen/blink.cmp",
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
    { "ellisonleao/gruvbox.nvim" },
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
