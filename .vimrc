set nocompatible              " be iMproved, required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'mhartington/oceanic-next'
Plugin 'rking/ag.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-surround'
Plugin 'kaicataldo/material.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leafgarland/typescript-vim'
Plugin 'VonHeikemen/midnight-owl.vim'
Plugin 'preservim/nerdcommenter'
Plugin 'dense-analysis/ale'
Plugin 'github/copilot.vim'

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

" Folds
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" pdb shortcut
map ,p oimport pdb; pdb.set_trace()<ESC>:w<cr>

" Config for fzf
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" {{
    " Show error if ag is unavailable and should be installed
    function! AgMissingStatus()
        if !executable('ag')
            return '[missing ag]'
        endif
        return ''
    endfunction

    if !executable('ag')
        let $FZF_DEFAULT_COMMAND='find .'
    else
        " Configure ag
        function! s:update_fzf_with_wildignore()
            let s:fzf_ignore_options = ' '.join(map(split(&wildignore, ','), '"--ignore \"" . v:val . "\""'))
            if executable('ag')
                let $FZF_DEFAULT_COMMAND='ag --hidden ' . s:fzf_ignore_options . ' -g ""'
            endif
        endfunction

        augroup ConfigureFzf
            autocmd!
            " Configure fzf after wildignore is set later in vimrc
            autocmd VimEnter * call s:update_fzf_with_wildignore()
        augroup END

        " Call Ag relative to repository root
        command! -bang -nargs=* Ag
            \ call fzf#vim#ag(<q-args>, '--hidden ' . s:fzf_ignore_options, fzf#vim#with_preview({
            \     'dir': b:repo_file_search_root
            \ }), <bang>0)

        " Using grep for visual mode selection
        function! s:GrepVisual(type)
            " Save the contents of the unnamed register
            let l:save_tmp = @@

            " Copy visual selection into unnamed_register
            if a:type ==# 'v'
                normal! `<v`>y
            elseif a:type ==# 'char'
                normal! `[v`]y
            else
                return
            endif

            execute 'Ag ' @@

            " Restore the unnamed register
            let @@ = l:save_tmp
        endfunction
    endif

    function! s:smarter_fuzzy_file_search()
        execute 'Files ' . b:repo_file_search_root
    endfunction

    " Helpers for using &wildignore with fzf
    let s:fzf_ignore_options = ''

    " We want to use gutentags for tag generation
    let g:fzf_tags_command = ''

    " Bindings: search file names
    nnoremap <C-P> :call <SID>smarter_fuzzy_file_search()<CR>
    nnoremap <Leader>p :Buffers<CR>
    nnoremap <Leader>ph :Files<CR>
    nnoremap <Leader>h :History<CR>
    nnoremap <Leader>gf :call fzf#vim#files(b:repo_file_search_root, fzf#vim#with_preview({
        \ 'options': '--query ' . shellescape(expand('<cfile>'))}))<CR>

    " Bindings: search tags
    nnoremap <Leader>t :Tags<CR>
    nnoremap <Leader>gt :execute 'Tags ' . expand('<cword>')<CR>

    " Bindings: search lines in open buffers
    nnoremap <Leader>l :Lines<CR>
    nnoremap <Leader>gl :call fzf#vim#lines(expand('<cword>'))<CR>

    " Bindings: search lines in files with ag
    nnoremap <Leader>a :Ag<CR>
    vnoremap <Leader>a :<C-U>call <SID>GrepVisual(visualmode())<CR>
    nnoremap <Leader>ga :execute 'Ag ' . expand('<cword>')<CR>

    " Use Vim colors for fzf
    let g:fzf_layout = {
        \ 'window': 'new'
        \ }
" }}
let g:fzf_layout = { 'down': '25%' }
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
let g:fzf_preview_window = 'right:60%'
nnoremap <c-p> :FZF<cr>
fun! s:fzf_root()
	let path = finddir(".git", expand("%:p:h").";")
	return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
endfun

nnoremap <silent> <Leader>ff :exe 'Files ' . <SID>fzf_root()<CR>

" Indent vertical indicators
Plugin 'Yggdroot/indentLine'

" Auto-wrap arguments
Plugin 'FooSoft/vim-argwrap'
noremap <silent> gw :ArgWrap<CR>

" Better indenting for python
Plugin 'Vimjas/vim-python-pep8-indent'
