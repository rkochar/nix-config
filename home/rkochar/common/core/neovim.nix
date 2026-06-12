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
    coop = pkgs.vimUtils.buildVimPlugin {
        name = "coop";
        src = pkgs.fetchFromGitHub {
            owner = "gregorias";
            repo = "coop.nvim";
            rev = "b156e541316aee14be4ae64c93ed8bddb6d03bc1";
            hash = "sha256-S6iGmdakI714Im0tetgfASbe0K4/olYsjj26+WP+rSU=";
        };
    };
    coerce = pkgs.vimUtils.buildVimPlugin {
        name = "coerce";
        src = pkgs.fetchFromGitHub {
            owner = "gregorias";
            repo = "coerce.nvim";
            tag = "v5.0.0";
            hash = "sha256-7PTBXcIXefNChRHLtIMCmEzQ1PttmqRqYMJvta+1eGA=";
        };
    };
in
{
    programs.neovim = {
        enable = true;
        vimAlias = true;
        defaultEditor = true;
        extraLuaConfig = builtins.readFile ./config/neovim/init.lua;
        # waylandSupport = true;
        withRuby = false;
        withPython3 = false;
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
            nvim-web-devicons

            # Filesystem
            oil-nvim
            neo-tree-nvim  # TODO: configure

            # Movement
            nvim-surround
            multiple-cursors
            nvim-spider  # optimize web
            dial-nvim  # improved <c-a> and <c-x>
            coerce  # requires coop

            # Theme
            tokyonight-nvim
            papercolor-theme-slim
            onedark-nvim

            # utilities (generic)
            which-key-nvim
            coop  # needed by coerce
            fzf-lua
        ];
    };

    home.file.".config/nvim/lua".source = ./config/neovim/lua;
}
