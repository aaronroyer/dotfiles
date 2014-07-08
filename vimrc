set nocompatible  " no compatibility with classic vi (required for Vundle)
filetype off      " required for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'wincent/command-t'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
Plugin 'bling/vim-airline'

call vundle#end()          "required for Vundle
filetype plugin indent on  " load file type plugins + indentation

syntax on
set encoding=utf-8
set showcmd " display incomplete commands

set noswapfile " do not create swap files

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

""" Key bindings
let mapleader=","
" Switch between files quickly (<C-^> usually does this)
nnoremap <leader><leader> <C-^>
" Experiment with a couple alternative ways to leave insert mode
" http://danielmiessler.com/study/vim/
inoremap jk <ESC>
inoremap jj <ESC>
" Easier split navigations - http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Whitespace
set nowrap " don't wrap lines
set tabstop=2 shiftwidth=2 " a tab is two spaces
set expandtab " use spaces, not tabs
set backspace=indent,eol,start " backspace through everything in insert mode

""" Searching
set hlsearch " highlight matches
set incsearch " incremental searching
set ignorecase " searches are case insensitive
set smartcase  " ...unless they contain at least one capital letter

""" UI
" set cmdheight=2

let g:airline_powerline_fonts = 1
set laststatus=2 " Always show status bar

set list
set listchars=tab:>-,trail:·,extends:❯,precedes:❮ " show tabs and trailing
set number " turn on line numbers
set ruler " Always show current positions along the bottom
set scrolloff=5 " some context around current line always on screen

" set wildmode=longest,list
" set wildmenu

""" UI - colors
let base16colorspace=256
syntax enable
"set background=dark
"colorscheme solarized
colorscheme base16-railscasts
set background=dark
