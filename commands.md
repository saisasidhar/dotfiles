## Stow

~~~sh
# before
# install wget git zsh stow
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --skip-chsh --keep-zshrc
rm ~/.zshrc

# stow
cd dotfiles
stow --ignore init.sls git tmux vim zsh

# after
git clone https://github.com/VundleVim/Vundle.vim vim/.vim/bundle/Vundle.vim
~~~


## SaltStack

~~~
USER=test HOME=/home/test salt-call --log-level info --file-root . --local state.apply
~~~
