[[ $- != *i* ]] && return

# Enable colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Helpful short aliases, for every day use.
alias c="clear"
alias x="exit"
alias ll="ls -lh"
alias la="ls -lah"
alias rm="trash-put"
alias lg="lazygit"
alias xc="xclip -selection clipboard"
alias diff="colordiff"

# Source aliases for tmux and bash config files
alias ts="tmux source-file '$HOME/.tmux.conf'"
alias bs="source '$HOME/.bashrc'"

# Enable git branch command and use it in PS1
source /usr/share/git/git-prompt.sh

# Can't use current_branch variable in PS1 since it calculated only once when bash shell is opened.
# It won't be calculated again when you switch folders where its state/value will change.
PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\W\[\e[0m\]:\[\e[91m\]$(__git_ps1 "(%s)")\[\e[0m\]\$ '

export PATH="$HOME/.local/share/nvim/mason/packages/jdtls/bin:$PATH"

