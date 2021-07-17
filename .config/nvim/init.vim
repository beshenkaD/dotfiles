"============= Plugins =============
call plug#begin(stdpath('config') . '/plugins')

Plug 'vim-airline/vim-airline'                  "Useless x1
Plug 'ryanoasis/vim-devicons'                   "Useless x2
Plug 'vim-airline/vim-airline-themes'           "Useless x3
Plug 'tpope/vim-commentary'                     "Very self-explanatory
Plug 'sheerun/vim-polyglot'                     "Syntax

call plug#end()

set ignorecase
set smartcase
set lazyredraw

"============= Keys =============
let mapleader=","
"============= Indentation =============
set secure exrc

set tabstop=4
set shiftwidth=4
set cc=80
set smarttab
set expandtab
set smartindent

" Preferences for various file formats
autocmd FileType c setlocal noet ts=8 sw=8 tw=80
autocmd FileType h setlocal noet ts=8 sw=8 tw=80
autocmd FileType cpp setlocal noet ts=8 sw=8 tw=80
autocmd FileType go setlocal noet ts=4 sw=4
autocmd FileType sh setlocal noet ts=4 sw=4
autocmd FileType python setlocal et ts=4 sw=4
"============= Appearance =============
set number
set relativenumber
syntax enable
