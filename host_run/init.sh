#!/bin/zsh

HOME=/home/kamay
SHELL=/bin/zsh
TERM=xterm-256color
USER=kamay
LOGNAME=kamay
PATH=$HOME/kde/src/kdesrc-build:$HOME/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/bin
PROFILEHOME=

ZSH_DISABLE_COMPFIX="true"
export ZSH_DISABLE_COMPFIX="true"
source ~/.zshrc

exec /bin/zsh
