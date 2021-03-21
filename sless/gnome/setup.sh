#!/bin/bash

cp media-keys-keybindings.dconf.bak mkk.dconf.bak
sed -i -e "s/CHANGEME/$username/g" mkk.dconf.bak

dconf load /org/gnome/desktop/wm/keybindings/ < wm-keybindings.dconf.bak
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < mkk.dconf.bak

rm $dir/gnome/mkk.dconf.bak
