{% from "macros.jinja" import symlinkfile with context -%}
{% from "macros.jinja" import cleandir with context -%}

zsh:
  pkg.installed

oh-my-zsh-clean:
  cmd.run:
    - name: rm -rf {{ salt["environ.get"]("HOME") }}/.oh-my-zsh
    - user: {{ salt["environ.get"]("USER") }}
    - quite: True

oh-my-zsh-install:
  cmd.run:
    - name: sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    - user: {{ salt["environ.get"]("USER") }}
    - quite: True
    - timeout: 240

{{ symlinkfile(sls~'-zshrc', slspath~'/zshrc', '.zshrc') }}
{{ symlinkfile(sls~'-theme', slspath~'/ohmytheme.zsh-theme', '.oh-my-zsh/custom/themes/ohmytheme.zsh-theme') }}
