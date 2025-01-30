return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = {},
                ruff = {},
                jsonls = {},
                clangd = {},
                jdtls = {},
                nixd = {},
                html = {},
                cssls = {},
                ts_ls = {},
                lua_ls = {}
            }
        }
    }
}