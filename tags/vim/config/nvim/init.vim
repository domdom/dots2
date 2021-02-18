if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim'
Plug 'mhinz/vim-signify'

call plug#end()
" =======================================
" Plugin Config
" =======================================
" =======================================
" Basic Setup
" =======================================
set encoding=utf-8

" =======================================
" Keyboard mappings
" =======================================
let mapleader = " "
let g:mapleader = " "

" Edit and source vimrc
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

" Previous buffer and next buffer
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>

" =======================================
" Display
" =======================================
set linespace=3
set ruler
set title
set cmdheight=1
set showtabline=2
set nowrap

set cursorline

set list listchars=tab:»·,trail:·

set wildignore+=*.o
set ttyfast

" =======================================
" Theme
" =======================================
syntax enable
if exists('+termguicolors')
    set termguicolors
endif

" colorscheme one
set background=light

" =======================================
" Airline
" =======================================
set laststatus=2

" =======================================
" Scrolling
" =======================================
set scrolloff=8
set sidescrolloff=0
set sidescroll=1
set backspace=indent,eol,start " Allow backspecing over everything in insert mode

" =======================================
" Tabbing
" =======================================
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab " Smart tabbing
set autoindent

" =======================================
" History Length
" =======================================
set history=10000

" =======================================
" Files
" =======================================
if !isdirectory($HOME."/.cache/vim/undodir")
    call mkdir($HOME."/.cache/vim/undodir", "p")
endif
set undodir=~/.cache/vim/undodir
set undofile
set directory=/tmp//

" =======================================
" TagBar
" =======================================
nmap <F8> :TagbarToggle<CR>

" =======================================
" FZF Fuzzy finder
" =======================================
nmap <C-p> :Fzfiles<CR>
nmap <C-g> :Rg<CR>
nmap <C-e> :Buffers<CR>

nmap <C-f> :Blines<CR>

command! -bang -nargs=* FzFind
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

" Perform rg <cword> where cword is the word under the cursor. Fzf search the results
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(expand('<cword>')), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

command! -bang -nargs=* Fzfiles
            \ call fzf#vim#files(
            \   <q-args>,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%', '?'),
            \   <bang>0)

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" =======================================
" Searching
" =======================================
set showcmd
set incsearch
set ignorecase " Don't search by case
set hlsearch

" =======================================
" Various
" =======================================
set mousehide     " Hide the mouse
set hidden        " Hide hidden files
set nospell
set number        " Show line numbers
set numberwidth=1 " Line number width
set mouse=a
set nostartofline " Does not move cursor to start of line when switching buffers
set noerrorbells  " No beeps.

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Disable the bell sound
set visualbell
set t_vb=


" System Clipboard
" =======================================
set clipboard^=unnamed,unnamedplus
vmap <LeftRelease> "*ygv

nnoremap <silent> glk :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gld :call LanguageClient#textDocument_definition()<CR>
" =======================================
" Autocmd
" =======================================

if has("autocmd")
    " Have Vim jump to the last position when
    " reopening a file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif

    " Custom file type to test language server
    au BufNewFile,BufRead *.dom set filetype=dom

    " .def files are often cpp files in clang
    au BufNewFile,BufRead *.{def,inc} set filetype=cpp
    " For llvm and clang files we want to have tab size of 2 spaces
    au BufWinEnter */{clang,llvm}/*
                \ setlocal tabstop=2      |
                \ setlocal shiftwidth=2   |
                \ setlocal softtabstop=2

    au BufWinEnter */gcc/*
                \ setlocal tabstop=8      |
                \ setlocal shiftwidth=8   |
                \ setlocal softtabstop=8

    " Jenkins -> groovy
    au BufRead,BufNewFile *.jenkins set filetype=groovy

    " Don't auto-add comments on newline
    au BufRead,BufNewFile * set formatoptions-=cro

    au BufNewFile,BufReadPost */bugs/* let b:tagbar_ignore = 1

    " Allow clipboard to persist after vim closes
    au VimLeave * call system("to_clipboard", getreg('+'))

    autocmd FileType json setlocal shiftwidth=2 tabstop=2

    au VimEnter * echo '>^.^<'
endif

hi default CocErrorUnderline    cterm=underline gui=undercurl guisp=#ff0000
hi default CocWarningUnderline  cterm=underline gui=undercurl guisp=#ff922b
hi default CocInfoUnderline     cterm=underline gui=undercurl guisp=#fab005
hi default CocHintUnderline     cterm=underline gui=undercurl guisp=#15aabf
hi default link CocErrorHighlight   CocErrorUnderline
hi default link CocWarningHighlight CocWarningUnderline
hi default link CocInfoHighlight    CocInfoUnderline
hi default link CocHintHighlight    CocHintUnderline
