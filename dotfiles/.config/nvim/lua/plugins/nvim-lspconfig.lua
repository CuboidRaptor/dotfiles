return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                jsonls = {},
                html = {},
                cssls = {},
                lua_ls = {},
                bashls = {},
                clangd = {
                    mason = false
                },
                nil_ls = {
                    mason = false
                }
            }
        }
    }
}
