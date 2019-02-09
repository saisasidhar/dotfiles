#!/bin/bash

GR='\033[0;32m'
OR='\033[0;33m'
NC='\033[0m'

username="$(whoami)"
dir=~/dotfiles
bdir=~/backup_dotfiles
vdir=~/.vim/bundle/vundle
i3dir=~/.i3
vscdir=~/.config/Code/User
files="vimrc tmux.conf session0.tmux.conf gitconfig i3/config i3/i3status.conf"

main() {

    mkdir -p $bdir
    mkdir -p $i3dir
    cd $dir

    echo -e "${OR}backing up old dotfiles (if any) to ${bdir}${NC}"
    for file in $files; do
        if [ -f ~/.$file ]; then 
            mv ~/.$file $bdir
        else
            echo -e "cannot find .$file to backup. skipping"
        fi
        ln -s $dir/$file ~/.$file
    done

    # Setup vundle for vim
    setup_vundle

    # Setup VS Code
    read -p "Setup VS Code (y/n)? " ans
    case "$ans" in
        y|Y ) setup_vscode;;
        * ) echo "Skipping VS code installation"
    esac
    
    # gnome customization
    read -p "Is this a gnome desktop environment (y/n)? " ans
    case "$ans" in
        y|Y ) setup_gnome;;
        * ) echo "Skipping gnome customization"
    esac

    echo -e "${GR}Done. I think.${NC}"
}

setup_gnome(){
    echo "Zenity will now be installed"
    sudo apt-get install zenity

    cp ${dir}/gnome/media-keys-keybindings.dconf.bak ${dir}/gnome/mkk.dconf.bak
    sed -i -e "s/CHANGEME/$username/g" ${dir}/gnome/mkk.dconf.bak

    dconf load /org/gnome/desktop/wm/keybindings/ < $dir/gnome/wm-keybindings.dconf.bak
    dconf load /org/gnome/settings-daemon/plugins/media-keys/ < $dir/gnome/mkk.dconf.bak

    rm $dir/gnome/mkk.dconf.bak

    echo -e "${OR}gnome shell must be restarted for the changes to take effect${NC}"
}

setup_vscode(){
    cp $dir/vscode/keybindings.json $vscdir
    cp $dir/vscode/settings.json $vscdir

    cat $dir/vscode/extensions.list | xargs -L 1 code --install-extension
}

setup_vundle(){
    if [ ! -d "$vdir" ]; then
        echo -e "${OR}bundle/vundle does not exist. cloning one${NC}"
        git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
    fi
    vim +PluginInstall +bdelete +qall

    echo -e "${OR}vim-plugin YouCompleteMe needs to be compiled manually${NC}"
}

read -p "Installed git, vim (y/n)? " ans
case "$ans" in 
    y|Y ) main;;
    n|N ) echo "Do that first and then run this script";;
    * ) echo "RTFQ";;
esac
