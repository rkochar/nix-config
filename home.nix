{ pkgs, ... }:
let 
  shellAliases = {
    cat = "bat";
    lsal = "ls -Al";
    vim = "nvim";
  };
in {
  home = {
    username = "rkochar";
    homeDirectory = "/home/rkochar";
    packages = with pkgs; [
      dust
      eza
      file
      sysz

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.bat = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
  };

  # https://pickard.cc/posts/git-identity-home-manager/
  programs.git = {
    enable = true;
    extraConfig = {
      user.useConfigOnly = true;
      user.name = "Rahul Kochar";
      user.email = "rkochar9@gmail.com";

      init.defaultBranch = "master";
      commit.gpgsign = true;
      };
  };

  programs.gpg = {
    enable = true;
  };

  # https://mynixos.com/home-manager/options/services.gpg-agent
  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    enableScDaemon = false;
    enableSshSupport = true;
    verbose = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  programs.jujutsu = {
    enable = true;
    ediff = false;
    settings.git = {
      push-new-bookmarks = true;
    };
    settings.user = {
      name = "Rahul Kochar";
      email = "rkochar9@gmail.com";
    };
    settings.signing = {
      backend = "gpg";
      behavior = "force";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter-parsers.nix
      papercolor-theme-slim
    ];
    extraLuaConfig = ''
      vim.opt.number = true
      vim.cmd('colorscheme PaperColorSlim')
    '';
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = shellAliases;
  };
}
