"============= Plugins =============
call plug#begin(stdpath('config') . '/plugins')

Plug 'vim-airline/vim-airline'                  "Useless x1
Plug 'ryanoasis/vim-devicons'                   "Useless x2
Plug 'vim-airline/vim-airline-themes'           "Useless x3
Plug 'tpope/vim-commentary'                     "Very self-explanatory
Plug 'sheerun/vim-polyglot'                     "Syntax

call plug#end()

"============= Keys =============
let mapleader=","
"============= Indentation =============
set secure exrc

"tabulation settings
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent

"============= Appearance =============
set number
set relativenumber
syntax on
