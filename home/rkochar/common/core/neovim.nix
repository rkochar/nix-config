{
    config,
    pkgs,
    home,
    ...
}:
{
    programs.neovim = {
        enable = true;
        vimAlias = true;
        defaultEditor = true;
        extraLuaConfig = builtins.readFile ./config/neovim/init.lua;
        plugins = with pkgs.vimPlugins; [
            nvim-lspconfig
            nvim-treesitter-textobjects
            nvim-treesitter.withAllGrammars
            nvim-treesitter-context

            gitsigns-nvim
            # windline-nvim  # not yet in nixpkgs
            rainbow-delimiters-nvim

            oil-nvim
            neo-tree-nvim

            tokyonight-nvim
            papercolor-theme-slim
            onedark-nvim
        ];
    };

    home.file.".config/nvim/lua".source = ./config/neovim/lua;
}
