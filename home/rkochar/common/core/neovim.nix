{
    config,
    pkgs,
    home,
    ...
}:
let
    # not in nixpkgs
    multiple-cursors = pkgs.vimUtils.buildVimPlugin {
        name = "multiple-cursors";
        src = pkgs.fetchFromGitHub {
            owner = "brenton-leighton";
            repo = "multiple-cursors.nvim";
            rev = "eae76d4c5f7ede2d45746dc2affb5e7a139e4aa8";
            hash = "sha256-iLQT+M0wL/Bh0zzgLSozSRjsELzKochMlM6djUwg/og=";
        };
    };
in
{
    programs.neovim = {
        enable = true;
        vimAlias = true;
        defaultEditor = true;
        extraLuaConfig = builtins.readFile ./config/neovim/init.lua;
        plugins = with pkgs.vimPlugins; [
            # Treesitter
            nvim-lspconfig
            nvim-treesitter-textobjects
            nvim-treesitter.withAllGrammars
            nvim-treesitter-context

            # Decoration
            gitsigns-nvim
            # windline-nvim  # not in nixpkgs
            rainbow-delimiters-nvim

            # Filesystem
            oil-nvim
            neo-tree-nvim

            # Movement
            nvim-surround
            multiple-cursors
            nvim-spider

            # Theme
            tokyonight-nvim
            papercolor-theme-slim
            onedark-nvim
        ];
    };

    home.file.".config/nvim/lua".source = ./config/neovim/lua;
}
