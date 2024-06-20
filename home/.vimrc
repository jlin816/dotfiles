set nocompatible              " be iMproved, required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Themes
Plugin 'mhartington/oceanic-next'
Plugin 'VonHeikemen/midnight-owl.vim'
Plugin 'ayu-theme/ayu-vim'
" Core
" Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'github/copilot.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Utils
Plugin 'tpope/vim-surround'
Plugin 'FooSoft/vim-argwrap'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'nvim-treesitter/nvim-treesitter-context'
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
Plugin 'DingDean/wgsl.vim'
" LSP
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Core
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color shit for midnight-owl
" For vim > 8
if (has("termguicolors"))
 set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

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
" Enable mouse
set mouse=a
" Highlight and incrementally show %s results
set hlsearch incsearch
" Case-insensitive search
set ignorecase smartcase
" Speedups on SSH
set ttyfast
set lazyredraw
" Keep undo history after file close
set undofile

" Easier split nav
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

" Weird backspace key issue
set backspace=indent,eol,start

" jk
inoremap jk <Esc>

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
autocmd BufWritePre * %s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" scrooloose/nerdtree
" Open NERDTree using Shift Tab
map <S-Tab> :NERDTreeToggle<CR>

" FooSoft/vim-argwrap
noremap <silent> gw :ArgWrap<CR>

" junegunn/fzf
" junegunn/fzf.vim
" nnoremap <C-P> :FZF<CR>
" let g:fzf_layout = {'down': '40%'}
let g:fzf_layout = {'window': 'new', 'down': '40%'}
let g:fzf_preview_window = ['right:hidden', 'ctrl-/']
let $FZF_DEFAULT_COMMAND="rg --files --hidden -g '!{.git,node_modules,__pycache__}'"
nnoremap <C-P> :Files<cr>
nnoremap <C-F> :Rg<cr>

" dense-analysis/ale - unused
let g:ale_linters = {'python': ['ruff']}
let b:ale_fixers = ['isort', 'pycln', 'remove_trailing_lines', 'trim-whitespace']
let g:ale_python_ruff_options = '--preview --ignore E111,E114,E731,E402'
" Avoid slow search for virtual envs.
let g:ale_use_global_executables = 1
let g:ale_virtualenv_dir_names=[]
" Disable automatic linting.
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_virtualtext_cursor=0

" prabirshrestha/vim-lsp
let g:lsp_diagnostics_enabled = 0
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <Leader>gd <plug>(lsp-definition)
    nmap <buffer> <Leader>gr <plug>(lsp-references)
    nmap <buffer> <Leader>gi <plug>(lsp-implementation)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Makefiles
autocmd FileType make setlocal noexpandtab

" Recognize .md as markdown files (mainly for vim-instant-markdown plugin)
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" vim-latex-live-preview setup
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'open -a Preview'

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
autocmd FileType python setlocal ts=2 sw=2 sts=2
autocmd FileType python setlocal tw=79
autocmd FileType python call PythonSyntax()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Utils
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Shortcuts
" Space as leader key.
map <Space> <nop>
let mapleader = " "
" cd to directory of current file and print
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" find and replace
nnoremap <leader>s :%s//g<left><left>
vnoremap <leader>s :s//g<left><left>
" easy vimrc editing
nnoremap <leader>c :source ~/.vimrc<cr>:doautoall FileType<cr>
nnoremap <leader>C :tabedit ~/.vimrc<cr>

" Leave insert mode with ctrl-c and ctrl-v
inoremap <c-c> <esc>
inoremap <c-v> <esc>
vnoremap <c-c> <esc>
vnoremap <c-v> <esc>

" Don't convert to lowercase by accident.
vnoremap u <nop>
vnoremap <c-u> u

" Hide highlights.
nnoremap <silent> <c-c> :noh<cr>

""""""
" Project-specific indentation
au BufRead,BufNewFile,BufEnter */dialop/* setlocal ts=4 sts=4 sw=4
au BufRead,BufNewFile,BufEnter */*vid*/* setlocal ts=4 sts=4 sw=4

" Override indentLine and show special characters in markdown
let g:vim_json_syntax_conceal = 0
" let g:vim_markdown_conceal = 0
" let g:vim_markdown_conceal_code_blocks = 0
let g:indentLine_concealcursor = "nc"

" Remove trailing whitespace in Python
autocmd BufWritePre *.py %s/\s\+$//e


