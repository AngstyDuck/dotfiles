" @@@ Default Vim @@@
" indentation options
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab  " For indents that consist of 4 space characters but are entered with the tab key
set autoindent  " yes

" search options
set hlsearch  " Highlight matching search patterns
set ignorecase  " Include matching uppercase words with lowercase search term
set smartcase  " Include only uppercase words with uppercase search term

" text rendering options
set encoding=utf-8
set wrap  " Enable line wrapping
syntax on  " Turn on syntax highlighting.
set linebreak  " Avoid wrapping a line in the middle of a word
set scrolloff=10  " Display x lines above/below the cursor when scrolling with a mouse.

" user interface options
set clipboard=unnamedplus  " use system clipboard when copy pasting
set showmatch   " Show matching brackets.
set number  " Show line numbers
" set relativenumber  " line numbers would be relative to currently selected line
set cursorline  " Highlight the line currently under cursor
set noerrorbells  " Disable beep on errors
set background=dark  " Use colors that suit a dark background
set title  " Set the window’s title, reflecting the file currently being edited
set ruler  " Always show current positions along the bottom
set bg=dark
set showcmd  " Shows what you are typing as a command

" performance
set lazyredraw  " Don’t update screen during macro and script execution

" misc
set nocompatible  " if you share your .vimrc with someone and they use -u flag to load your file, vim won't be configured the same as if the file were named .vimrc and located in your home directory
" src: https://stackoverflow.com/questions/5845557/in-a-vimrc-is-set-nocompatible-completely-useless
set magic  " ensure that in vim regex all chars except alphanumeric and _ have special meaning
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc  " functions and packages that refer to this var will ignore the following files


" @@@ NERDTree @@@
let NERDTreeShowHidden=1  " Let NERDTree show dotfiles in the side bar


" @@@ ack.vim @@@
" ref: https://www.freecodecamp.org/news/how-to-search-project-wide-vim-ripgrep-ack/
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1
" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1
" Don't jump to first match
cnoreabbrev Ack Ack!



" @@@ Key Mappings @@@
let mapleader = "\<Space>"
noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>f :FZF<CR>
nnoremap <Leader>a :Ack!<Space>
" extra options under ack
nnoremap <Leader>s :copen<CR>
nnoremap <Leader>d :cclose<CR>
"""
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
imap ;; <Esc>  " get out of insert mode

map <Leader>3 :call ConsoleLogGo()<CR><CR>
function! ConsoleLogGo()
  let trace = expand('fmt.Println("@@@ PING")')
  execute "normal o".trace
endfunction

map <Leader>2 :call ConsoleLogJs()<CR><CR>
function! ConsoleLogJs()
  let trace = expand("console.log('@@@ PING');")
  execute "normal o".trace
endfunction

map <Leader>1 :call InsertPDB()<CR><CR>
function! InsertPDB()
  let trace = expand("__import__('pdb').set_trace()")
  execute "normal o".trace
endfunction



" @@@ Misc @@@
" Call the .vimrc.plug file (vim-plug is a vim plug-in manager)
if filereadable(expand("~/.vimrc.plug"))
 source ~/.vimrc.plug
endif

" set realtimepath
set rtp+=~/.fzf  " fzf integration for vim

" for a fix for fzf
" ref: https://github.com/junegunn/fzf.vim/issues/642
set shell=/usr/local/bin/bash

" use 'darker' linter for files with .py suffix whenever we save file
set autoread
autocmd BufWritePost *.py silent :!darker %

" Default to not read-only in vimdiff
set noro

" bugfix for slow typescript regex is to disable old regex engine
" hence enabling new regex engine
" ref: https://jameschambers.co.uk/vim-typescript-slow
set re=0
