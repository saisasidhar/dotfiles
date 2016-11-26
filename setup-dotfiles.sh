#!/bin/bash
#==============================================================================
#			   _______   ____  _______   ___________  __ _____   ___ 
#			  / __/ _ | /  _/ / __/ _ | / __/  _/ _ \/ // / _ | / _ \
#			 _\ \/ __ |_/ /  _\ \/ __ |_\ \_/ // // / _  / __ |/ , _/
#			/___/_/ |_/___/ /___/_/ |_/___/___/____/_//_/_/ |_/_/|_| 
#                                                        
#==============================================================================

GR='\033[0;32m'
OR='\033[0;33m'
NC='\033[0m'

dir=~/dotfiles
bdir=~/backup_dotfiles
vdir=~/.vim/bundle/vundle
i3dir=~/.i3
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

    echo -e "${GR}done. I think.${NC}"
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
