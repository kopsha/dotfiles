export PATH=$HOME/.local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gnzh-venv"

unsetopt AUTO_CD
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

plugins=(git virtualenv zsh-nvm)

source $ZSH/oh-my-zsh.sh
case $OSTYPE in
    linux*)
        source /usr/share/fzf/shell/key-bindings.zsh
	;;
    darwin*)
        source <(fzf --zsh)
	;;
    *)
        printf "The $OSTYPE is not supported.\n"
	;;
esac

# User configuration
export LANG=en_US.UTF-8
alias vim="nvim"
export EDITOR="nvim"


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

