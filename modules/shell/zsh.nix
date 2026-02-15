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

            # https://github.com/jeffreytse/zsh-vi-mode/issues/24#issuecomment-783981662
            zvm_after_init() {
                source "$(fzf-share)/key-bindings.zsh"
                    source "$(fzf-share)/completion.zsh"
            }

            # TODO: look into toggling -tf and -td
            # Call fzf with opinionated env var https://github.com/junegunn/fzf/pull/3618
            # can not use programs.fzf.opts because it is not global https://discourse.nixos.org/t/fzf-defaultoptions-not-applied-in-home-manager/59502
            function f {
                fzf_default_command_string="fd --strip-cwd-prefix --follow --hidden --walker-skip ${walkerskip} --color=always"
                    fzf_default_opts_string="--ansi --cycle --multi --smart-case \
                    --preview '~/nix-config/fzf-preview.bash {}' \
                    --bind 'focus:transform-header:file --brief {}' \
                    --prompt 'All> ' \
                    --header 'CTRL-D: Directories / CTRL-F: Files'
                    --bind 'ctrl-d:change-prompt(Directories> )+reload(''${fzf_default_command_string} -td)' \
                    --bind 'ctrl-f:change-prompt(Files> )+reload(''${fzf_default_command_string} -tf)'"

                    FZF_DEFAULT_COMMAND="''${fzf_default_command_string}" FZF_DEFAULT_OPTS="''${fzf_default_opts_string}" command fzf "$@"
            }

            export FZF_CTRL_T_OPTS="
                --walker-skip ${walkerskip} \
                --preview 'bat -n --color=always {}'  \
                --bind 'ctrl-/:change-preview-window(down|hidden|)'"

            # TODO: default_opts uses fzf-preview.
            # CTRL-Y to copy the command into clipboard using pbcopy
            # export FZF_CTRL_R_OPTS="  \
            #   --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'  \  # TODO: nix does not have pbopy?
            #   --color header:italic  \
            #   --header 'Press CTRL-Y to copy command into clipboard'"

            # Print tree structure in the preview window
            export FZF_ALT_C_OPTS="
                --walker-skip ${walkerskip} \
                --preview 'eza --only-dirs --follow-symlinks --show-symlinks --color=always --tree {}'"

            # escape sequence https://discourse.nixos.org/t/need-help-understanding-how-to-escape-special-characters-in-the-list-of-str-type/11389/2
            function rfv {
            FZF_DEFAULT_OPTS="" FZF_DEFAULT_COMMAND="" rg --color=always --line-number --no-heading --smart-case "''${''\*:-}" |
                fzf --ansi \
                --color "hl:-1:underline,hl+:-1:underline:reverse" \
                --delimiter : \
                --walker-skip ${walkerskip} \
                --preview 'bat --color=always {1} --highlight-line {2}' \
                --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
                --bind 'enter:become($EDITOR {1} +{2})'
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
