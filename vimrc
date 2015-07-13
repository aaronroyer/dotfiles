set nocompatible

filetype off " required for Vundle
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
call vundle#begin()
Plugin 'gmarik/Vundle.vim' " let Vundle manage Vundle, required

" General plugins
Plugin 'kien/ctrlp.vim'
Plugin 'jeetsukumaran/vim-buffergator', {'pinned': 1}
Plugin 'majutsushi/tagbar'
Plugin 'schickling/vim-bufonly'
Plugin 'chriskempson/base16-vim'
Plugin 'bling/vim-airline'
Plugin 'rking/ag.vim'
" Plugin 'scrooloose/nerdtree'
" Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'ervandew/supertab'
Plugin 'terryma/vim-expand-region'
" Plugin 'scrooloose/syntastic'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'jgdavey/tslime.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'editorconfig/editorconfig-vim'

" Language support plugins
Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'
Plugin 'fatih/vim-go'

" Tool/framework support plugins
Plugin 'tpope/vim-rails'
" Plugin 'tpope/vim-bundler'
Plugin 'thoughtbot/vim-rspec'

call vundle#end()

filetype plugin indent on  " load file type plugins + indentation

""" Basic configuration
set encoding=utf-8
set showcmd " display incomplete commands, for example y23dd before final d
set noswapfile " do not create swap files
syntax on " syntax highlighting on

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

""" Key bindings
" leave insert mode more easily
" http://danielmiessler.com/study/vim/
inoremap jk <ESC>
" inoremap jj <ESC>
" easier to reach leader
let mapleader=","
" Switch between files quickly (<C-^> usually does this)
nnoremap <leader><leader> <C-^>
" Search for tags with ctrlp
" nnoremap <leader>t :CtrlPTag<cr>
nnoremap <leader>c :CtrlPTag<cr>
" Search open buffers with ctrlp
nnoremap <leader>p :CtrlPBuffer<cr>
let g:buffergator_suppress_keymaps="1"
nnoremap <silent> <leader>b :BuffergatorToggle<cr>
" maybe easier way to turn off highlight after search
nnoremap <leader>h :nohl<CR>
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

" Easier split navigations - http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Rotate splits
map <leader>r <C-w>r
" Inserting newlines
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
" nnoremap ; : " use ; to start commands
" Custom functions
map <leader>n :call RenameFile()<cr>
" Clipboard
" map <leader>c "*y
" Misc
" TODO: make these use language-appropriate debug
map <leader>d obinding.pry<Esc>
map <leader>D Obinding.pry<Esc>

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

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
set ruler " always show current positions along the bottom
set scrolloff=5 " some context around current line always on screen

" Highlight the character of a line that goes over 100
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%101v', 100)

if has("wildmenu")
  set wildmenu " enhanced command completion
  set wildmode=longest,list,full
endif

""" UI - colors
let base16colorspace=256
colorscheme base16-default
set background=dark

""" Plugin config
let g:airline_powerline_fonts = 1

if !empty($TMUX)
  let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'
endif

if executable('ag')
  let g:agprg="ag --column --smart-case"
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

"   " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

"   " ag is fast enough that CtrlP doesn't need to cache
"   let g:ctrlp_use_caching = 0
endif

if executable('fzf')
  set rtp+=/usr/local/opt/fzf
endif

" nmap <Leader>g :TagbarOpenAutoClose<CR>
nmap <Leader>g :TagbarToggle<CR>

""" Language-specific whitespace config (if autocmd is available)
" ts  - tabstop (number of columns for a tab)
" sw  - shiftwidth (number of columns for reindent operations, like << and >>)
" sts - softtabstop (should usually be set to equal softtabstop if expandtab)
" expandtab - insert spaces instead of tab characters
if has("autocmd")
  autocmd Filetype go setlocal ts=4 sw=4 sts=0 noexpandtab
endif

"""Functions

" Rename current file - from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
