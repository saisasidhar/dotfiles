{% from "macros.jinja" import symlinkfile with context -%}

git:
  pkg.installed

{{ symlinkfile(sls~'-gitconfig', slspath~'/.gitconfig', '.gitconfig') }}
{{ symlinkfile(sls~'-gitignore-global', slspath~'/.gitignore_global', '.gitignore_global') }}

configure-gitignore-global:
  cmd.run:
    - name: git config --global core.excludesfile {{ salt["environ.get"]("HOME") }}/.gitignore_global > /dev/null
    - user: {{ salt["environ.get"]("USER") }}
    - quite: True
