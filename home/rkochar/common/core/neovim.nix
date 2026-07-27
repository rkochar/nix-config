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
            nvim-treesitter-textobjects
            nvim-treesitter.withAllGrammars
            nvim-treesitter-context

            # lsp
            nvim-lspconfig
            lsp_signature-nvim  # function signatures
            blink-cmp  # completions
            blink-ripgrep-nvim
            blink-nerdfont-nvim
            friendly-snippets

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

            # utility (generic)
            which-key-nvim
            coop  # needed by coerce
            fzf-lua
            noice-nvim  # cmd ui  # needs nui
            ecolog-nvim  # env var
            colorful-menu-nvim  # menu box
            nui-nvim  # needed by noice
            nvim-notify
        ];
    };

    home.packages = with pkgs; [
        nixd
        starpls
        gopls
        basedpyright  # ty by astral-sh is in beta
    ];

    home.file = {
        # ".config/nvim/lua".source = ./config/neovim/lua;
        ".config/nvim/ftplugin/oil.lua".source = ./config/neovim/ftplugin/oil.lua;

        ".config/nvim/lua/decoration/init.lua".source = ./config/neovim/lua/decoration/init.lua;
        ".config/nvim/lua/decoration/gitsigns.lua".source = ./config/neovim/lua/decoration/gitsigns.lua;
        ".config/nvim/lua/decoration/web-devicons.lua".source = ./config/neovim/lua/decoration/web-devicons.lua;


        ".config/nvim/lua/filesystem/init.lua".source = ./config/neovim/lua/filesystem/init.lua;
        ".config/nvim/lua/filesystem/oil.lua".source = ./config/neovim/lua/filesystem/oil.lua;

        ".config/nvim/lua/lsp/init.lua".source = ./config/neovim/lua/lsp/init.lua;
        ".config/nvim/lua/lsp/bazel.lua".source = ./config/neovim/lua/lsp/bazel.lua;
        ".config/nvim/lua/lsp/blink.lua".source = ./config/neovim/lua/lsp/blink.lua;
        ".config/nvim/lua/lsp/go.lua".source = ./config/neovim/lua/lsp/go.lua;
        ".config/nvim/lua/lsp/nix.lua".source = ./config/neovim/lua/lsp/nix.lua;
        ".config/nvim/lua/lsp/python.lua".source = ./config/neovim/lua/lsp/python.lua;

        ".config/nvim/lua/movement/init.lua".source = ./config/neovim/lua/movement/init.lua;
        ".config/nvim/lua/movement/coerce.lua".source = ./config/neovim/lua/movement/coerce.lua;
        ".config/nvim/lua/movement/dial.lua".source = ./config/neovim/lua/movement/dial.lua;
        ".config/nvim/lua/movement/multiple-cursors.lua".source = ./config/neovim/lua/movement/multiple-cursors.lua;
        ".config/nvim/lua/movement/spider.lua".source = ./config/neovim/lua/movement/spider.lua;
        ".config/nvim/lua/movement/surround.lua".source = ./config/neovim/lua/movement/surround.lua;

        ".config/nvim/lua/theme/onedark.lua".source = ./config/neovim/lua/theme/onedark.lua;

        ".config/nvim/lua/treesitter/init.lua".source = ./config/neovim/lua/treesitter/init.lua;
        ".config/nvim/lua/treesitter/foldtext.lua".source = ./config/neovim/lua/treesitter/foldtext.lua;

        ".config/nvim/lua/utility/init.lua".source = ./config/neovim/lua/utility/init.lua;
        ".config/nvim/lua/utility/fzf.lua".source = ./config/neovim/lua/utility/fzf.lua;
        ".config/nvim/lua/utility/which-key.lua".source = ./config/neovim/lua/utility/which-key.lua;
        ".config/nvim/lua/utility/ecolog.lua".source = ./config/neovim/lua/utility/ecolog.lua;
        ".config/nvim/lua/utility/noice.lua".source = ./config/neovim/lua/utility/noice.lua;
        ".config/nvim/lua/utility/colorful-menu.lua".source = ./config/neovim/lua/utility/colorful-menu.lua;
        ".config/nvim/lua/utility/notify.lua".source = ./config/neovim/lua/utility/notify.lua;
    };
}
