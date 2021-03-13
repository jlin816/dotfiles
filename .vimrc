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
Plugin 'w0rp/ale'
Plugin 'kaicataldo/material.vim'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'davidhalter/jedi-vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'VonHeikemen/midnight-owl.vim'
Plugin 'preservim/nerdcommenter'

" Copy paste keymappings
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
set number
set history=1000
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set fileformat=unix
set t_Co=256
" colorscheme OceanicNext
colorscheme midnight-owl
set background=dark
let g:airline_theme='oceanicnext'
set mouse=a

" Open NERDTree using Shift Tab
map <S-Tab> :NERDTreeToggle<CR>

" Shift between tabs using Shift Right, Shift Left
map <S-Right> :tabn<CR>
map <S-Left>  :tabp<CR>

" Easier split nav
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

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

" Color shit
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" vim-latex-live-preview setup
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'open -a Preview'

" Ale lag
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" Disable parentheses matching depends on system. This way we should address all cases (?)
" set noshowmatch

" NoMatchParen " This doesnt work as it belongs to a plugin, which is only loaded _after_ all files are.
" Trying disable MatchParen after loading all plugins
"
" function! g:FuckThatMatchParen ()
"    if exists(":NoMatchParen")
"        :NoMatchParen
"    endif
" endfunction
" augroup plugin_initialize
"    autocmd!
"    autocmd VimEnter * call FuckThatMatchParen()
" augroup END

" Always just save lol
command WQ wq
command Wq wq
command W w
command Q q
