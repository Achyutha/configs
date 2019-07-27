# Initializes the default editor.
function editor_conf() {
    if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='vim'
    else
        export EDITOR='nano'
    fi
}

# Initializes the Environment variables.
function init() {
    export LANG=en_US.UTF-8
    export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
    export LDFLAGS="-L/usr/local/opt/libffi/lib"
    export PATH="$PATH:`pwd`/development/flutter/bin"
    export FZF_BASE="/usr/local/bin/fzf"

    #Custom colors for MAN pages etc.
    export LESS_TERMCAP_mb=$'\e[1;32m'
    export LESS_TERMCAP_md=$'\e[1;32m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_se=$'\e[0m'
    export LESS_TERMCAP_so=$'\e[01;33m'
    export LESS_TERMCAP_ue=$'\e[0m'
    export LESS_TERMCAP_us=$'\e[1;4;31m'
}

unsetopt histverify
editor_conf
init
