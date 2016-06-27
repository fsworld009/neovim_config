if &compatible
  set nocompatible
endif

let s:plugin_base_path = substitute($MYVIMRC, 'nvim' .g:dir_separator . 'init.vim', 'nvim_plugin' . g:dir_separator, '')
let s:dein_base_path = s:plugin_base_path . 'repos' . g:dir_separator . 'github.com' . g:dir_separator . 'Shougo' . g:dir_separator . 'dein.vim'

execute "set runtimepath^=" . s:dein_base_path

call dein#begin(s:plugin_base_path)

call dein#add('Shougo/dein.vim')

if has('win32')
  call dein#add('equalsraf/neovim-gui-shim')
endif

call dein#add('fsworld009/obsidian2.vim',{'hook_add':'silent! colorscheme obsidian2'})

call dein#add('Yggdroot/indentLine')

call dein#add('Shougo/vimproc.vim')
"call dein#add('Shougo/vimproc.vim', {
"    \ 'build': {
"    \     'windows': 'tools\\update-dll-mingw',
"    \     'cygwin': 'make -f make_cygwin.mak',
"    \     'mac': 'make -f make_mac.mak',
"    \     'linux': 'make',
"    \     'unix': 'gmake',
"    \    },
"    \ })

call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neoyank.vim')


"call dein#add('scrooloose/nerdtree',
"      \{'on_cmd': 'NERDTreeToggle'})

call dein#add('scrooloose/nerdtree')
"call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('majutsushi/tagbar')
call dein#add('b3niup/numbers.vim')

call dein#add('scrooloose/nerdcommenter')
call dein#add('tpope/vim-surround')

call dein#add('xolox/vim-misc')

function! s:vim_session_setup()
  if has('win32')
    let g:session_directory = $LOCALAPPDATA . '\nvim-data\sessions'
  endif
  let g:session_autosave = 'yes'
  let g:session_autoload = 'yes'
  let g:session_autosave_periodic = 10
endfunction
call dein#add('xolox/vim-session', {'hook_add': function('s:vim_session_setup')})

call dein#add('ternjs/tern_for_vim', {
			\ 'build': 'npm install',
			\ 'if': 'executable("npm")',
			\ 'on_ft': 'javascript'
\ })

function! s:vim_airline_setup()
  let g:airline_theme = 'powerlineish'
  let g:airline#extensions#branch#enabled=1
  let g:airline#extensions#tabline#enabled = 1
  set laststatus=2
endfunction
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes',{'hook_add': function('s:vim_airline_setup')})

call dein#add('mbbill/undotree')
call dein#add('Lokaltog/vim-easymotion')

"call dein#add('junegunn/rainbow_parentheses.vim')

call dein#end()

filetype plugin indent on

"call dein#install()
"autocmd VimEnter * call dein#call_hook('post_source')


let g:NERDTreeIndicatorMapCustom = {
  \ "Modified"  : "✹",
  \ "Staged"    : "✚",
  \ "Untracked" : "✭",
  \ "Renamed"   : "➜",
  \ "Unmerged"  : "═",
  \ "Deleted"   : "✖",
  \ "Dirty"     : "✗",
  \ "Clean"     : "✔︎",
  \ "Unknown"   : "?"
  \ }
"let g:rainbow#pairs = [['(', ')'], ['[', ']'],['{','}']]