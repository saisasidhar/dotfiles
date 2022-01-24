# salt-call --file-root . --local state.apply
base:
  '*':
    - apps
    - git
    - vim
    - tmux
    - zsh
