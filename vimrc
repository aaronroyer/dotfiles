set nocompatible  " no compatibility with classic vi (required for Vundle)

""" Vundle setup and plugin loading
filetype off " required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
Plugin 'gmarik/Vundle.vim' " let Vundle manage Vundle, required

"Plugin 'wincent/command-t'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
Plugin 'bling/vim-airline'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'fatih/vim-go'
Plugin 'tpope/vim-commentary'
Plugin 'terryma/vim-expand-region'

call vundle#end()          " required for Vundle
filetype plugin indent on  " load file type plugins + indentation

""" Basic configuration
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
" Search for tags with ctrlp
nnoremap <leader>t :CtrlPTag<cr>
" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
" Experiment with a couple alternative ways to leave insert mode
" http://danielmiessler.com/study/vim/
inoremap jk <ESC>
inoremap jj <ESC>
" Easier split navigations - http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Inserting newlines
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Open new splits on bottom
" set splitbelow

""" Whitespace
set nowrap " don't wrap lines
set tabstop=2 softtabstop=2 shiftwidth=2 " a tab is two spaces
set expandtab " use spaces, not tabs
set backspace=indent,eol,start " backspace through everything in insert mode

""" Searching
set hlsearch " highlight matches
set incsearch " incremental searching
set ignorecase " searches are case insensitive
set smartcase  " ...unless they contain at least one capital letter

""" UI
" set cmdheight=2

set laststatus=2 " Always show status bar

set list " show hidden characters
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮ " show tabs and trailing
set number " turn on line numbers
set ruler " Always show current positions along the bottom
set scrolloff=5 " some context around current line always on screen

" set wildmode=longest,list
" set wildmenu

""" UI - colors
let base16colorspace=256
syntax enable
set background=dark
"colorscheme solarized
colorscheme base16-railscasts

""" Plugin config
let g:airline_powerline_fonts = 1
let g:agprg="ag --column --smart-case"

""" Language-specific whitespace config (if autocmd is available)
" ts  - tabstop (number of columns for a tab)
" sw  - shiftwidth (number of columns for reindent operations, like << and >>)
" sts - softtabstop (should usually be set to equal softtabstop if expandtab)
" expandtab - insert spaces instead of tab characters
if has("autocmd")
  autocmd Filetype go setlocal ts=4 sw=4 sts=0 noexpandtab
endif

