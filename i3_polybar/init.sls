{% from "macros.jinja" import symlinkfile with context -%}
{% from "macros.jinja" import cleandir with context -%}

{% if grains['osfullname'] == 'Ubuntu' %}
speedricer:
  pkgrepo.managed:
    - name: ppa:kgilmer/speed-ricer
    - dist: {{grains['lsb_distrib_codename']}}
    - file: /etc/apt/sources.list.d/speericer.list
    - keyid: bda0e4ba891b327bb00df1e076458020c35556dc
    - keyserver: keyserver.ubuntu.com
{% endif %}

{{sls}}-packages:
  pkg.installed:
    - pkgs:
      - i3-gaps
      - i3lock
      - i3status
      - polybar


{{ cleandir(sls~'-i3', '.config/i3') }}
{{ cleandir(sls~'-polybar', '.config/polybar') }}

{{ symlinkfile(sls~'-i3conf', slspath~'/i3/config', '.config/i3/config') }}
{{ symlinkfile(sls~'-i3status', slspath~'/i3/i3status.conf', '.config/i3/i3status.conf') }}

{{ symlinkfile(sls~'-pb', slspath~'/polybar/config', '.config/polybar/config') }}
{{ symlinkfile(sls~'-pblaunch', slspath~'/polybar/launch.sh', '.config/polybar/polybar_launch.sh') }}
