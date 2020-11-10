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
set showmatch   " Show matching brackets.
set number  " Show line numbers
set relativenumber  " line numbers would be relative to currently selected line
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


" @@@ Key Mappings @@@
let mapleader = "\<Space>"
noremap <Leader>n :NERDTreeToggle<CR>
noremap <Leader>f :FZF<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
imap ;; <Esc>  " get out of insert mode



" @@@ Misc @@@
" Call the .vimrc.plug file (vim-plug is a vim plug-in manager)
if filereadable(expand("~/.vimrc.plug"))
 source ~/.vimrc.plug
endif

" set realtimepath
set rtp+=~/.fzf  " fzf integration for vim
