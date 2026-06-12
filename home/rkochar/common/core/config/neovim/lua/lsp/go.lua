vim.lsp.config("gopls", {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
})

vim.lsp.enable("gopls")
