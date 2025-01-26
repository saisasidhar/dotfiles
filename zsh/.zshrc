# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ohmytheme"

plugins=(git fzf docker z virtualenv copyfile)

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
alias docpurdangim="docker rmi $(docker images -f "dangling=true" -q)"
alias cdw="cd /mnt/c/Users/"
alias gr='cd $(git rev-parse --show-toplevel)'

# ls octal
function lso() { ls -alG "$@" | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(" %0o ",k);print}'; }

# fzf
export FZF_DEFAULT_COMMAND='find . ! -path "*git*"'
export FZF_CTRL_T_COMMAND="find . -type f"
export FZF_CTRL_R_OPTS="--border sharp --reverse --info hidden"
export FZF_CTRL_T_OPTS="--border sharp --info hidden --preview 'cat {} | head -n 50'"
export FZF_ALT_C_OPTS="--border sharp --info hidden --preview 'tree -C {} | head -n 50'"
export FZF_COMPLETION_TRIGGER="^"
zle -N fzf-cd-widget
bindkey -M emacs '\C-o' fzf-cd-widget
bindkey -M vicmd '\C-o' fzf-cd-widget
bindkey -M viins '\C-o' fzf-cd-widget
bindkey -rM emacs '\ec'
bindkey -rM vicmd '\ec'
bindkey -rM viins '\ec'


# Python development customizations:
_python_module_completion() {
     # override if the command is `python -m`
    if [[ "${words[1]}" == "python" && "${words[2]}" == "-m" ]]; then
        local modules
        # find python modules, replacing / with .
        modules=($(find . -type f -name "*.py" ! -name "__init__.py" | sed 's|^\./||;s|/|.|g;s|\.py$||'))
        # Provide jsut local modules as completion options
        compadd -W "" -- "${modules[@]}"
    else
        # fallback
        _python
    fi
}

# register completion for python
compdef _python_module_completion python

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

function vcd() {
    builtin cd "$@"
    venvctl
}

