return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = {},
                ruff = {},
                jsonls = {},
                clangd = {
                    mason = false -- mason installation was bricked so just install `clang-tools`, `clang` and this works
                },
                jdtls = {},
                nixd = {
                    mason = false -- install `nixd` for this as I don't think mason has one
                },
                html = {},
                cssls = {},
                ts_ls = {},
                eslint = {},
                lua_ls = {},
                bashls = {}
            }
        }
    }
}