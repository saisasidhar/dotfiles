#!/bin/bash

GR='\033[0;32m'
OR='\033[0;33m'
NC='\033[0m'

username="$(whoami)"
dir=~/dotfiles
bdir=~/backup_dotfiles

# symlinks
i3dir=~/.config/i3
polybardir=~/.config/polybar
files="vimrc tmux.conf session0.tmux.conf gitconfig config/i3/config config/i3/i3status.conf config/polybar/config config/polybar/launch.sh"

vscdir=~/.config/Code/User
vdir=~/.vim/bundle/vundle

main() {
    # Backup and symlink configs
    setup_configs

    # Setup vundle for vim
    setup_vundle

    # Setup VS Code
    read -p "Setup VS Code (y/n)? " ans
    case "$ans" in
        y|Y ) setup_vscode;;
        * ) echo "Skipping VS code customization"
    esac

    # Install i3
    read -p "Install i3 (y/n)? " ans
    case "$ans" in
        y|Y ) setup_i3;;
        * ) echo "Skipping i3"
    esac
    
    # gnome customization
    read -p "Is this a gnome desktop environment (y/n)? " ans
    case "$ans" in
        y|Y ) setup_gnome;;
        * ) echo "Skipping gnome customization"
    esac
    
    # zsh customization
    read -p "Install zsh, oh-my-zsh, and custom theme ?" ans
    case "$ans" in
        y|Y ) setup_zsh;;
        * ) echo "Skipping zsh installation"
    esac

    echo -e "${GR}Done. I think.${NC}"
}

setup_configs() {
    mkdir -p $bdir
    mkdir -p $i3dir
    mkdir -p $polybardir
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
}

setup_gnome(){
    echo "Zenity will now be installed"
    sudo pacman -S zenity

    cp ${dir}/gnome/media-keys-keybindings.dconf.bak ${dir}/gnome/mkk.dconf.bak
    sed -i -e "s/CHANGEME/$username/g" ${dir}/gnome/mkk.dconf.bak

    dconf load /org/gnome/desktop/wm/keybindings/ < $dir/gnome/wm-keybindings.dconf.bak
    dconf load /org/gnome/settings-daemon/plugins/media-keys/ < $dir/gnome/mkk.dconf.bak

    rm $dir/gnome/mkk.dconf.bak

    echo -e "${OR}gnome shell must be restarted for the changes to take effect${NC}"
}

setup_vscode(){
    ln -s $dir/vscode/keybindings.json $vscdir/keybindings.json
    ln -s $dir/vscode/settings.json $vscdir/setting.json

    cat $dir/vscode/extensions.list | xargs -L 1 code --install-extension
}

setup_vundle(){
    if [ ! -d "$vdir" ]; then
        echo -e "${OR}bundle/vundle does not exist. cloning one${NC}"
        git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
    fi
    vim +PluginInstall +bdelete +qall
    echo -e "${GR}Finished setting up vundle"
}

setup_rofi_polybar(){
    sudo pacman -S rofi polybar ttf-font-awesome adobe-source-code-pro-fonts
    echo -e "${OR} dmenu and i3status is in the config, uncomment polybar/rofi to enable awesomeness${NC}"
}

setup_i3(){
    echo -e "Installing standard i3 tools"
    sudo pacman -S i3-gaps i3lock i3status dmenu
    
    read -p "Install uber-cool i3 customizations ?" ans
    case "$ans" in
        y|Y ) setup_rofi_polybar;;
        * ) echo "Skipping uber-cool i3 customizations"
    esac
    echo -e "${GR}Finished setting up i3"
}

setup_zsh(){
    zsh --version
    if [ $? -ne 0 ]; then
        sudo pacman -S zsh
    fi

    if [[ $SHELL == "/usr/bin/bash" ]]; then
        echo -e "shell is bash. Changing to zsh"
        chsh -s $(which zsh)
    else
        echo "zsh is already configured as current shell"
    fi

    echo -e "Installing oh-my-zsh"
    sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    ln -s $dir/zsh/ohmytheme.zsh-theme ~/.oh-my-zsh/custom/themes/ohmytheme.zsh-theme

    echo -e "${OR}Add ohmytheme to .zshrc${NC}"
}

read -p "Installed git, vim (y/n)? " ans
case "$ans" in 
    y|Y ) main;;
    n|N ) echo "Do that first and then run this script";;
    * ) echo "RTFQ";;
esac
