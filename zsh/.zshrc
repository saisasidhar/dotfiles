# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ohmytheme"

plugins=(git fzf docker z virtualenv)

# history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export GPG_TTY=$(tty)

alias bat="batcat"

alias fixtty='reset; stty sane; tput rs1; clear; echo -e "\033c"'
# docker purge dangling images
alias docpurdangim="docker rmi $(docker images -f "dangling=true" -q)"
# for WSL
alias mnt="cd /mnt/c/Users/"
# golang interpreter
alias yaegi='rlwrap yaegi'
# quickly change to gitroot
alias gr='cd $(git rev-parse --show-toplevel)'

# ls octal
lso() { ls -alG "$@" | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(" %0o ",k);print}'; }

function venvctl() {
    # https://stackoverflow.com/a/50830617
    if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
        if [[ -d ./venv ]] ; then
            source ./venv/bin/activate
        fi
    else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing else deactivate
        parentdir="$(dirname "$VIRTUAL_ENV")"
        if [[ "$PWD"/ != "$parentdir"/* ]] ; then
            deactivate
        fi
    fi
}

function cd() {
    builtin cd "$@"
    venvctl
}
