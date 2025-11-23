export PATH=$HOME/.local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export ARCHFLAGS="-arch $(uname -m)"

ZSH_THEME="robbyrussell"

CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"

HIST_STAMPS="yyyy-mm-dd"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

plugins=(git virtualenv)
source $ZSH/oh-my-zsh.sh

# setup fzf
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

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi

####
# MacOS iterm2 stuff
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

