#!/bin/bash

# fzf
# https;//junegunn.github.io/fzf/shell-integration/
# <c-t> file
# <c-r> history
# <alt-c> dir
# **<tab>

export FZF_COMPLETION_OPTS='--border --info=inline'

# Options for path completion (e.g. vim **<TAB>)
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'

# Options for directory completion (e.g. cd **<TAB>)
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'


# Advanced customization of fzf options via _fzf_comprun function
# - The first arguement to the function is the name of the command
# - You should make sure to pass the rest of the arguements ($@) to fzf.
_fzf_command() {
    local command=$1
    shift

    case "$command" in
        bat|batcat|cat|cd|cp|mv|ln|rm|nvim|vi|vim) fzf --preview '${NIX_CONFIG_PATH}/fzf-preview.bash {}' "$@" ;;
        export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
        ssh)          fzf --preview 'dig {}'                   "$@" ;;
        *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
    esac
}

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first arguement to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" --exclude ".jj" . "$1"
}

# to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" --exclude ".jj" . "$1"
}

# CTRL-Y to copy the command into clipboard using pbcopy
# TODO: nix does not have pbopy?
export FZF_CTRL_R_OPTS="
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
    --color header:italic
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_CTRL_T_OPTS="
    --walker-skip ${walkerskip}
    --preview 'bat -n --color=always {}'
    --header '<CTRL -> to change preview window location'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
    --walker-skip ${walkerskip} \
    --preview 'eza --only-dirs --follow-symlinks --show-symlinks --color=always --tree {}'"

export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --color=always ---exclude '.git' --exclude '.jj'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="-m --ansi"

function fzd {
    FIRST_ARG="$1"
    shift

    pushd $FIRST_ARG
    fzf "$@"
    popd
}


# TODO: look into toggling -tf and -td
# Call fzf with opinionated env var https://github.com/junegunn/fzf/pull/3618
# can not use programs.fzf.opts because it is not global https://discourse.nixos.org/t/fzf-defaultoptions-not-applied-in-home-manager/59502
function f {
    fzf_default_command_string="fd --strip-cwd-prefix --follow --hidden --walker-skip ${walkerskip} --color=always"
        fzf_default_opts_string="--ansi --cycle --multi --smart-case \
        --preview '${NIX_CONFIG_PATH}/fzf-preview.bash {}' \
        --bind 'focus:transform-header:file --brief {}' \
        --prompt 'All> ' \
        --header 'CTRL-D: Directories / CTRL-F: Files / CTRL-A: All'
        --bind 'ctrl-a:change-prompt(All> )+reload(''${fzf_default_command_string})' \
        --bind 'ctrl-d:change-prompt(Directories> )+reload(''${fzf_default_command_string} -td)' \
        --bind 'ctrl-f:change-prompt(Files> )+reload(''${fzf_default_command_string} -tf)' \
        --bind 'enter:become($EDITOR {1})'"

        FZF_DEFAULT_COMMAND="''${fzf_default_command_string}" FZF_DEFAULT_OPTS="''${fzf_default_opts_string}" command fzf "$@"
}

# search for string
# escape sequence https://discourse.nixos.org/t/need-help-understanding-how-to-escape-special-characters-in-the-list-of-str-type/11389/2
function s {
FZF_DEFAULT_OPTS="" FZF_DEFAULT_COMMAND="" rg --color=always --line-number --no-heading --smart-case -g '!**/p10k.zsh' "${*:-}" |
    fzf --ansi \
    --color "hl:-1:underline,hl+:-1:underline:reverse" \
    --delimiter : \
    --walker-skip ${walkerskip} \
    --preview 'bat --color=always {1} --highlight-line {2}' \
    --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
    --bind 'enter:become($EDITOR {1} +{2})'
}
