#!/bin/bash
#==============================================================================
#
#   Sai Sasidhar Maddali <sai.sasidhar92@gmail.com>
#
#==============================================================================

dir=~/dotfiles
bdir=~/backup_dotfiles
vdir=~/.vim/bundle/vundle
files="vimrc tmux.conf session0.tmux.conf gitconfig"

main() {

    mkdir -p $bdir
    cd $dir

    echo -e "\033[32mbacking up old dotfiles to $bdir\033[0m"
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
}

setup_vundle(){

    if [ ! -d "$vdir" ]; then
        echo -e "\033[32mbundle/vundle does not exists. cloning one\033[0m"
        git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
    fi

    vim +PluginInstall +bdelete +qall
}

main
echo -e "\033[32mdone\033[0m"
