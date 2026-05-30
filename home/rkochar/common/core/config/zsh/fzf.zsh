export FZF_PREVIEW_PATH="${FLAKE}/home/rkochar/common/core/config/zsh/fzf-preview.zsh"
export WALKERSKIP='.git,node_modules,target,.jj,result,.venv,bazel-out,.bazel,*.lock'
export FZF_COMPLETION_OPTS='--border --info=inline'  # options to fzf
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'  # options for vim **<tab>
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'  # options for cd **<tab>

# https://github.com/jeffreytse/zsh-vi-mode/issues/24#issuecomment-783981662
zvm_after_init() {
    FZF_BINARY_NIX_STORE_PATH=$(readlink -f $(which fzf))
    FZF_NIX_STORE_PATH=${FZF_BINARY_NIX_STORE_PATH:h:h}
    source "${FZF_NIX_STORE_PATH}/share/fzf/key-bindings.zsh"
    source "${FZF_NIX_STORE_PATH}/share/fzf/completion.zsh"
}

_fzf_comprun() {
    local COMMAND=$1
    shift

    case "$COMMAND" in
        bat|batcat|cat|cd|cp|mv|ln|rm|nvim|vim|nano|vi|) fzf --preview "${FZF_PREVIEW_PATH} {}" "$@" ;;
        export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
        ssh)          fzf --preview 'dig {}'                   "$@" ;;
        *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
    esac
}

# use fd for listing path candidates
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" --exclude ".jj" . "$1"
}

# use fd for listing path candidates
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" --exclude ".jj" . "$1"
}

export FZF_CTRL_T_OPTS="
    --walker-skip ${WALKERSKIP} \
    --preview 'bat -n --color=always {}'  \
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
    --color header:italic  \
    --header 'Press CTRL-Y to copy command into clipboard' \
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'" # TODO: nix does not have pbopy?

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
    --walker-skip ${WALKERSKIP} \
    --preview 'eza --only-dirs --follow-symlinks --show-symlinks --color=always --tree {}'"

export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --color=always --exclude ".git" --exclude ".jj"'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_DEFAULT_OPTS="-m --ansi"

# fz -d will run fzf in that directory
function fzd {
    ALL_ARGS=("$@")
    FIRST_ARG="$1"
    SECOND_ARG="$2"
    REST_ARGS=("''${ALL_ARGS[@]:2}")

    if [[ $FIRST_ARG == "-d" ]]; then
        cd $SECOND_ARG && fzf $REST_ARGS
        cd - > /dev/null
    else
        fzf $ALL_ARGS
    fi
}

# TODO: look into toggling -tf and -td
# Call fzf with opinionated env var https://github.com/junegunn/fzf/pull/3618
# can not use programs.fzf.opts because it is not global https://discourse.nixos.org/t/fzf-defaultoptions-not-applied-in-home-manager/59502
function f {
    fzf_default_command_string="fd --strip-cwd-prefix --follow --hidden --exclude .git --exclude .jj --exclude result --color=always"
    fzf_default_opts_string="--ansi --cycle --multi --smart-case \
        --preview '${FZF_PREVIEW_PATH} {}' \
        --bind 'focus:transform-header:file --brief {}' \
        --prompt 'All> ' \
        --header 'CTRL-D: Directories / CTRL-F: Files / CTRL-A: All' \
        --bind 'ctrl-a:change-prompt(All> )+reload(''${fzf_default_command_string})' \
        --bind 'ctrl-d:change-prompt(Directories> )+reload(''${fzf_default_command_string} -td)' \
        --bind 'ctrl-f:change-prompt(Files> )+reload(''${fzf_default_command_string} -tf)' \
        --bind 'enter:become($EDITOR {1})'"
    }

# escape sequence https://discourse.nixos.org/t/need-help-understanding-how-to-escape-special-characters-in-the-list-of-str-type/11389/2
function s {
    FZF_DEFAULT_OPTS="" FZF_DEFAULT_COMMAND="" rg --color=always --line-number --no-heading --smart-case "''${''\*:-}" |
        fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become($EDITOR {1} +{2})'
}
