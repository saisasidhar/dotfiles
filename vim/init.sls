{% from "macros.jinja" import symlinkfile with context -%}
{% from "macros.jinja" import cleandir with context -%}

vim:
  pkg.installed

{{ cleandir(sls~'-clean', '.vim') }}

{{ symlinkfile(sls~'-vimrc', slspath~'/vimrc', '.vim/vimrc') }}
{{ symlinkfile(sls~'-after-python', slspath~'/after/ftplugin/python.vim', '.vim/after/ftplugin/python.vim') }}

vim-vundle:
  git.cloned:
    - name: https://github.com/VundleVim/Vundle.vim
    - target: {{ salt["environ.get"]("HOME") }}/.vim/bundle/Vundle.vim
    - user: {{ salt["environ.get"]("USER") }}

vim-vundle-install:
  cmd.run:
    - name: vim +PluginInstall +bdelete +qall > /dev/null
    - user: {{ salt["environ.get"]("USER") }}
    - quite: True
    - timeout: 240
