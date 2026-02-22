{ config, lib, system, pkgs, stable, vars, ...}:

# TODO: bring all zsh config here.
let
    shellAliases = {
        cat = "bat";
        ls = "eza";  # Note: alt-c does not use this (fzf)
        tree = "eza --follow-symlinks --show-symlinks --color=always --tree";
        treed = "eza --only-dirs --follow-symlinks --show-symlinks --color=always --tree";
        lsal = "ls -Al";
        fv = "fzf --bind 'enter:become($EDITOR {})'";
        fva ="fzf --print0 | xargs -0 -o $EDITOR";
        jjl = "jj log -r ::@";
    };
    walkerskip = ".git,node_modules,target,.jj,result,*.lock,bazel-out";
    home = config.users.users.${vars.user}.home;
in
rec {
    programs.zsh = {
        enable = true;
        enableCompletion = true;
# https://github.com/rkochar/zsh-vim-mode?tab=readme-ov-file#installation
# order plugins to avoid conflict but https://github.com/zsh-users/zsh-syntax-highlighting?tab=readme-ov-file#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
        syntaxHighlighting.enable = true;
        shellAliases = shellAliases;
        histSize = 10000;
        interactiveShellInit = "";
        shellInit = ''
            # source ~/.p10k.zsh  # https://discourse.nixos.org/t/how-to-use-powerlevel10k-prompt-with-zsh/41519/13

            # TODO: environment variables. sessionVariables appears not to be an option anymore.
            # source a file with exports?
            export NIX_CONFIG_PATH="~/nix-config/config"

            # https://github.com/jeffreytse/zsh-vi-mode/issues/24#issuecomment-783981662
            zvm_after_init() {
                source "$(fzf-share)/key-bindings.zsh"
                source "$(fzf-share)/completion.zsh"
            }
        '';
  # plugins = [
  #     {
  #         name = "zsh-autosuggestions";
  #         src = pkgs.fetchFromGitHub {
  #             owner = "zsh-users";
  #             repo = "zsh-autosuggestions";
  #             rev = "v0.7.1";
  #             sha256 = "vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
  #         };
  #     }
  #     {
  #         name = "vi-mode";
  #         src = pkgs.zsh-vi-mode;
  #         file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
  #     }
  #     {
  #         name = "zsh-async";
  #         file = "async.zsh";
  #         src = pkgs.fetchFromGitHub {
  #             owner = "mafredri";
  #             repo = "zsh-async";
  #             rev = "v1.8.6";
  #             sha256 = "sha256-Js/9vGGAEqcPmQSsumzLfkfwljaFWHJ9sMWOgWDi0NI=";
  #         };
  #     }
  #     {
  #         name = "powerlevel10k";
  #         src = pkgs.zsh-powerlevel10k;
  #         file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  #     }
  #     {
  #         name = "zsh-nix-shell";
  #         file = "nix-shell.plugin.zsh";
  #         src = pkgs.fetchFromGitHub {
  #             owner = "chisui";
  #             repo = "zsh-nix-shell";
  #             rev = "v0.8.0";
  #             sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
  #         };
  #     }
  # ];
  };

    systemd.tmpfiles.rules = [
      "L+ ${home}/.zshrc - - - - /etc/zshrc"
    ];

    users.users.${vars.user} = {
        packages = with pkgs; [
            ripgrep
            eza
            fd
        ];
        shell = pkgs.zsh;
    };
}
