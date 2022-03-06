# Oh my own theme (modifications)

# Based on elessar theme
# https://github.com/fjpalacios/elessar-theme 

# Which is again based on Gitster theme
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme

local ret_status="%(?:%{$fg_bold[green]%}➜  :%{$fg_bold[red]%}➜  )% %{$reset_color%}"

function get_pwd(){
  git_root=$PWD
  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done
  if [[ $git_root = / ]]; then
    unset git_root
    prompt_short_dir=%~
  else
    parent=${git_root%\/*}
    prompt_short_dir=${PWD#$parent/}
  fi
  echo $prompt_short_dir
}

function get_git_status() {
  if [[ -n $(git rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
    local git_status="$(git_prompt_status)"
    if [[ -n $git_status ]]; then
      git_status="($git_status%{$reset_color%}) "
    fi
    echo $git_status
  fi
}

function get_ssh_status() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "%{$fg[blue]%}Ξ %{$reset_color%}"
  fi
}

function get_jobs_status() {
  if [[ $(jobs -l | wc -l) -gt 0 ]]; then
    echo "%{$fg[cyan]%}⚙ %{$reset_color%}"
  fi
}

function get_root_status() {
  if [[ $UID -eq 0 ]]; then
    echo "%{$fg[yellow]%}⚡ %{$reset_color%}"
  fi
}

function get_venv_status() {
  if [[ "$(virtualenv_prompt_info)" ]]; then
    echo "%{$fg[cyan]%}४ %{$reset_color%}"
  fi
}

PROMPT='$(get_root_status)$(get_ssh_status)$(get_jobs_status)$(get_venv_status)%{$fg[white]%}$(get_pwd) %{$reset_color%}$(git_prompt_info)$(get_git_status)$ret_status'

# Git info
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}⎇ "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓%{$reset_color%}"

# Git status
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[magenta]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}>%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}=%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}?%{$reset_color%}"
