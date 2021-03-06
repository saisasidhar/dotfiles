" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off        " For vundle


" Vundle stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-eunuch'

call vundle#end()

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
set relativenumber
set nu rnu
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
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣


" Key combos
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-o> :NERDTreeToggle<CR> " Toggles nerd tree for ctrl-o
map <C-i> :set list!<CR> " Toggles invisible chars
map <C-p> :set paste!<CR> " Toggles paste
cnoremap <expr> %% expand('%:h').'/'
nnoremap ; :
