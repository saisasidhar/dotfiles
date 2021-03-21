# salt-call --file-root . --local state.apply
base:
  '*':
    - git
    - vim
    - tmux
    - apps
