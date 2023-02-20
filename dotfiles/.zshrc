#######################################################################
# SHORTCUTS
#######################################################################

# ccat <file>   Cat a colorized file
# cless <file>  Less a colorized file
# <alt-left>    Move to previous dir
# <alt-right>   Undo previous dir
# <alt-up>      Move to parent dir

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME='mh'

plugins=(git docker docker-compose vi-mode colorize dirhistory)

fpath=($HOME/.zsh/completions $fpath)

# Avoid closing window with ctlr+d
set -o ignoreeof

# Load configurations
for f in $HOME/.zsh/config*; do
    source $f;
done

source $ZSH/oh-my-zsh.sh

# Allow multiple terminal sessions to all append to one zsh command history
setopt APPEND_HISTORY

# Do not enter command lines into the history list if they are duplicates of
# the previous event
setopt HIST_IGNORE_DUPS

# If the internal history needs to be trimmed to add the current command line,
# setting this option will cause the oldest history event that has a duplicate
# to be lost before losing a unique event
setopt HIST_EXPIRE_DUPS_FIRST

# enable vi-mode
bindkey -v
# Fix delete key for vi mode
bindkey -a '^[[3~' delete-char

# Load personal aliases
for f in $HOME/.zsh/aliases*; do
    source $f;
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
