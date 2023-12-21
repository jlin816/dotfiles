set nocompatible              " be iMproved, required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Themes
Plugin 'mhartington/oceanic-next'
Plugin 'VonHeikemen/midnight-owl.vim'
Plugin 'oxfist/night-owl.nvim'
Plugin 'ayu-theme/ayu-vim'
" Core
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'github/copilot.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Utils
Plugin 'tpope/vim-surround'
"" Commenting shortcuts
Plugin 'preservim/nerdcommenter'
"" Indent vertical indicators
Plugin 'Yggdroot/indentLine'
" Filetypes
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leafgarland/typescript-vim'
Plugin 'ap/vim-css-color'
Plugin 'Vimjas/vim-python-pep8-indent'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Core
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
let ayucolor="dark"
colorscheme ayu
set background=dark
let g:airline_theme='oceanicnext'
set mouse=a

" Easier split nav
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

" Weird backspace key issue
set backspace=indent,eol,start

" jk
inoremap jk <Esc>

" Color shit
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Always just save lol
command WQ wq
command Wq wq
command W w
command Q q

" Folds
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" pdb shortcut
map ,p oimport pdb; pdb.set_trace()<ESC>:w<cr>

" Look for tags recursively
set tags=tags;/

" Remove trailing whitespace on save for most file types.
let allowTrailingSpaces = ['snippets']
autocmd BufWritePre * if index(allowTrailingSpaces, &ft) < 0 | %s/\s\+$//e


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" scrooloose/nerdtree
" Open NERDTree using Shift Tab
map <S-Tab> :NERDTreeToggle<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Makefiles
autocmd FileType make setlocal noexpandtab

" HTML
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2

" Recognize .md as markdown files (mainly for vim-instant-markdown plugin)
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" vim-latex-live-preview setup
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'open -a Preview'

" Ale lag
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0


" Indenting for python
function! PythonSyntax()
  syntax match MyPythonSelf "\<self\>\.\?"
  syntax match MyPythonLibrary "\<np\.\|\<tf\.\|\<scipy\.\<os\."
  syntax match MyPythonKwarg "\((\| \)\@<=\<[A-Za-z0-9_]\+\>="
  syntax match MyPythonNumber "\<[0-9.]\+\>\.\?"
  hi MyPythonSelf    cterm=none ctermfg=gray ctermbg=none
  hi MyPythonLibrary cterm=none ctermfg=gray ctermbg=none
  hi MyPythonKwarg   cterm=none ctermfg=magenta ctermbg=none
  hi MyPythonNumber  cterm=none ctermfg=red ctermbg=none
endfunction
"autocmd FileType python setlocal ts=2 sw=2 sts=2
autocmd FileType python setlocal ts=4 sw=4 sts=4
autocmd FileType python setlocal tw=79
autocmd FileType python call PythonSyntax()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Utils
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Shortcuts
" cd to directory of current file and print
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
