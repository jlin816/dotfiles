set nocompatible              " be iMproved, required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'mhartington/oceanic-next'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-surround'
Plugin 'craigemery/vim-autotag'
Plugin 'w0rp/ale'

" Copy paste keymappings
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set number
set history=1000
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
set t_Co=256
colorscheme OceanicNext
set background=dark
let g:airline_theme='oceanicnext'
set mouse=a

" Open NERDTree using Shift Tab
map <S-Tab> :NERDTreeToggle<CR>

" Shift between tabs using Shift Right, Shift Left
map <S-Right> :tabn<CR>
map <S-Left>  :tabp<CR>

" Easier split nav
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Real tabs for makefiles
autocmd FileType make setlocal noexpandtab
" HTML formatting
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
" Recognize .md as markdown files (mainly for vim-instant-markdown plugin)
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Weird backspace key issue
set backspace=indent,eol,start

" jk
inoremap jk <Esc>
