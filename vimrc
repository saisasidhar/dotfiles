" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off        " For vundle


" Vundle stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'VundleVim/Vundle.vim'


" Formatting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax enable
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent


" UI UX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set numberwidth=4
set ignorecase
set smartcase
set incsearch
set hlsearch
set mouse=a
set noerrorbells
set vb t_vb=
set laststatus=2
set updatetime=1618 "Phi. GR. Sweet spot. 'cause 4 sec is too long


" Fix for fat butter fingers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:command WQ wq
:command Wq wq
:command W w
:command Q q
:command Q1 q!

" Key combos
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-o> :NERDTreeToggle<CR> " Toggles nerd tree for ctrl-o

" Themes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set background=black
"colorscheme solarized
