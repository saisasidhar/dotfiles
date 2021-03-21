{% from "macros.jinja" import symlinkfile with context -%}

tmux:
  pkg.installed

{{ symlinkfile(sls~'-conf', slspath~'/tmux.conf', '.tmux.conf') }}
