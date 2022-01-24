base-packages:
  pkg.installed:
    - pkgs:
      - htop
      - bat
      - fzf
      - gdb
      - wget


{% if grains['osfullname'] == 'Ubuntu' %}
ubuntu-packages:
  pkg.installed:
    - pkgs:
      - exuberant-ctags
      - build-essential
      - fonts-font-awesome
{% else %}
other-packages: # Assuming Arch family
  pkg.installed:
    - pkgs:
      - ctags
      - base-devl
      - ttf-font-awesome
{% endif %}
