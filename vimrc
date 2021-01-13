syntax on

set noerrorbells		    " Don't make any noises.
set tabstop=4 softtabstop=4	" Use 4 spaces for tabs,
set shiftwidth=4		    " Again, shift stuff but 4 spaces when using tab.
set expandtab			    " Convert a tab to spaces.
set smartindent			    " Try to indent for you, as much as Vim can.
set number relativenumber   " Enable sidebar numbers.
set smartcase			    " Do case sensitive searching until I put in a letter.
set noswapfile			    " Don't create vim.swp files all over the place.
set nobackup			    " Don't need backup, because we'll make our own.
set undodir=~/.vim/undodir	" Tell Vim where to save the undo directory.
set undofile			    " Create an undofile for every file we open/create.
set incsearch			    " While you search you get results.

call plug#begin('~/.vim/plugged')

Plug 'jremmen/vim-ripgrep'  " Very fast grep.
Plug 'vim-utils/vim-man'    " Read man pages using Vim.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}    "Autocomplete for loads of languages.
Plug 'mbbill/undotree'      " Make undoing stuff easier.
Plug 'https://github.com/kien/ctrlp.vim.git'    " Nice file finding.

call plug#end()

set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " "         " Sets the leader (command key) to spacebar.
let g:netrw_browse_split=2  " Make the sidebar 2 across
let g:netrw_winsize = 25    " Sidebar window should be 25%.

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
