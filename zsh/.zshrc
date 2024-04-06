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

plugins=(git virtualenv)

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8
original_vim=$(which vim)
alias ovim="$original_vim"
alias vim="nvim"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

