"fallback when colorscheme is not available
highlight Normal guibg=black guifg=white

"force English
set langmenu=en_US
let $LANG = 'en_US'
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim

" General settings
set backspace=2                        "enable backspace key
set tabstop=4 shiftwidth=4 expandtab   "insert 4 spaces for a tab, display tab characters as 4 spaces
let mapleader = ","                    "change leader key to ','
syntax on
set number
set hlsearch
set nowrap                               "no auto word wrapping

"spell check
set spelllang=en

" UTF-8
set encoding=utf-8
setglobal fileencoding=utf-8
setglobal nobomb

"folding settings http://smartic.us/2009/04/06/code-folding-in-vim/
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1

"temp files location
"execute "set backupdir=" .  g:vimrc_path . "vimfiles" . g:dir_separator . "backup" . g:dir_separator
"execute "set directory=" .  g:vimrc_path . "vimfiles" . g:dir_separator . "swap"   . g:dir_separator
"execute "set undodir="   .  g:vimrc_path . "vimfiles" . g:dir_separator . "undo"   . g:dir_separator

autocmd FileType vim setlocal shiftwidth=2 tabstop=2

"session: save window size and position
set sessionoptions+=resize,winpos
