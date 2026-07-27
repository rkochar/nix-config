local host = vim.fn.hostname()

vim.lsp.config("nixd", {
    cmd = { "nixd" },
    filetypes = { "nix" },
    settings = {
        nixd = {
            formatting = {
                command = { "alejandra" },
            },
            nixpkgs = {
                expr = "import (builtins.getFlake (toString ./.)).inputs.nixpkgs { }",
            },
            options = {
                nixos = {
                    expr = string.format('(builtins.getFlake (toString ./.)).nixosConfigurations.%s.options', host)
                },
                home_manager = {
                    expr = '(builtins.getFlake (toString ./.)).homeConfigurations."rkochar".options',
                },
            },
        },
    },
})

vim.lsp.enable("nixd")
