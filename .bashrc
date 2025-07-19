#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Custom aliases
alias c="clear"
alias la="ls -la"
alias x="exit"
alias rm="trash-put"

alias tsrc="tmux source-file '$HOME/.config/tmux/.tmux.conf'"
alias bsrc="source '$HOME/.bashrc'"

alias lg="lazygit"
