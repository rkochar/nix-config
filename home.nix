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
      asn
      btop
      delta
      dust
      eza
      fastfetchMinimal
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

  programs.fd = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # https://pickard.cc/posts/git-identity-home-manager/
  programs.git = {
    enable = true;
    extraConfig = {
      user = {
        useConfigOnly = true;
        name = "Rahul Kochar";
        email = "rkochar9@gmail.com";
      };
      commit.gpgsign = true;
      init.defaultBranch = "master";

      core = {
	pager = "delta";
      };

      interactive = {
	diffFilter = "delta --color-only";
      };

      delta = {
	pager = true;
	# dark = true;  # Should be auto-detected
	side-by-side = true;
	line-numbers = true;
	navigate = true;  # use n and N
      };

      merge = {
	conflictStyle = "zdiff3";
      };
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

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;  # https://github.com/rkochar/zsh-vim-mode?tab=readme-ov-file#installation  # order plugins to avoid conflict but https://github.com/zsh-users/zsh-syntax-highlighting?tab=readme-ov-file#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
    shellAliases = shellAliases;
    history.size = 10000;
    initContent = "source ~/.p10k.zsh";  # https://discourse.nixos.org/t/how-to-use-powerlevel10k-prompt-with-zsh/41519/13
    plugins = [
      {
  	name = "zsh-autosuggestions";
	src = pkgs.fetchFromGitHub {
	  owner = "zsh-users";
	  repo = "zsh-autosuggestions";
	  rev = "v0.7.1";
	  sha256 = "vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
	};
      }
      {
  	name = "zsh-vim-mode";
	src = pkgs.fetchFromGitHub {
	  owner = "rkochar";
	  repo = "zsh-vim-mode";
	  rev = "v0.0.1";
	  sha256 = "a+6EWMRY1c1HQpNtJf5InCzU7/RphZjimLdXIXbO6cQ=";
	};
      }
      {
        name = "powerlevel10k";
	src = pkgs.zsh-powerlevel10k;
	file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };
}
