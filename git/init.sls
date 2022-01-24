{% from "macros.jinja" import symlinkfile with context -%}

git:
  pkg.installed

{{ symlinkfile(sls~'-gitconfig', slspath~'/.gitconfig', '.gitconfig') }}
{{ symlinkfile(sls~'-gitignore-global', slspath~'/.gitignore_global', '.gitignore_global') }}
