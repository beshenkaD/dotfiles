"============= Plugins =============
call plug#begin(stdpath('config') . '/plugins')

Plug 'chrisbra/Colorizer'
Plug 'tpope/vim-commentary'                    

call plug#end()

set termguicolors
set ignorecase
set smartcase
set lazyredraw
set secure exrc

let g:colorizer_auto_filetype='*'

let mapleader="\\"

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

set number
set relativenumber
syntax enable
