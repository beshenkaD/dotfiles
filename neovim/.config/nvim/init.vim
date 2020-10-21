"============= Plugins =============
call plug#begin(stdpath('config') . '/plugins')
Plug 'neovim/nvim-lspconfig'                    "Language server support
Plug 'arcticicestudio/nord-vim'                 "Cool colorscheme
Plug 'calebsmith/vim-lambdify'                  "Nice lambdas
Plug 'nvim-lua/completion-nvim'                 "Very self-explanatory
Plug 'scrooloose/nerdtree'                      "Plugin for noobs
Plug 'vim-airline/vim-airline'                  "Useless x1
Plug 'ryanoasis/vim-devicons'                   "Useless x2
Plug 'vim-airline/vim-airline-themes'           "Useless x3
Plug 'tpope/vim-commentary'                     "Very self-explanatory
Plug 'sheerun/vim-polyglot'                     "Syntax
Plug 'junegunn/fzf.vim'                         "Fuzzy finder
Plug 'yggdroot/indentline'                      "Cool indent line
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

"============= Keys =============
"Leader key
let mapleader=","
"FZF
nnoremap <c-p> :Files<cr>

"============= Indentation =============
set secure exrc

"tabulation settings
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent

"Indent line 
let g:indentLine_color_term = 4
let g:indentLine_char = ''
let g:indentLine_enabled = 0


"============= Useless appearance =============
set number
set relativenumber

"Airline Setup
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"It's from airline
let g:airline_theme='nord'

"Syntax 

"Colorscheme
syntax on
set background=dark
colorscheme nord

"============= Neovim LSP =============
set hidden

" Clangd
lua require'nvim_lsp'.clangd.setup{on_attach=require'completion'.on_attach}
" Rust-analyzer
lua require'nvim_lsp'.rust_analyzer.setup{on_attach=require'completion'.on_attach}
" Haskell
lua require'nvim_lsp'.hls.setup{on_attach=require'completion'.on_attach}
" Go
lua require'nvim_lsp'.gopls.setup{on_attach=require'completion'.on_attach}

" Autocomplete

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

"GoTo code navigation. Daddy Dijkstra will be very angry!
nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nmap <silent> gy <cmd>lua vim.lsp.buf.declaration()<CR>
nmap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nmap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>

"Documentation
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
"Symbol renaming
nmap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

":Format command
function Format()
  if (&filetype == "haskell")
    %!brittany
  else
    lua vim.lsp.buf.formatting()
  endif
endfunction

command! -nargs=0 Format :call Format()
"AutoFix on current line
nmap <leader>qf  <cmd>lua vim.lsp.buf.code_action()<CR>
