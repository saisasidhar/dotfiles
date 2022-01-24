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
    - name: sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --skip-chsh --keep-zshrc
    - user: {{ salt["environ.get"]("USER") }}
    - timeout: 240

oh-my-zsh-postinstall-clean:
  cmd.run:
    - name: rm {{ salt["environ.get"]("HOME") }}/.zshrc
    - user: {{ salt["environ.get"]("USER") }}
    - quite: True

{{ symlinkfile(sls~'-zshrc', slspath~'/.zshrc', '.zshrc') }}
{{ symlinkfile(sls~'-zshenv', slspath~'/.zshenv', '.zshenv') }}
{{ symlinkfile(sls~'-theme', slspath~'/.oh-my-zsh/custom/themes/ohmytheme.zsh-theme', '.oh-my-zsh/custom/themes/ohmytheme.zsh-theme') }}
