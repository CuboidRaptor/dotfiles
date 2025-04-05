return {
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
    }
}
