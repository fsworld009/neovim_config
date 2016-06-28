if has('win32')
  call dein#add('equalsraf/neovim-gui-shim')
endif

"call dein#add('fsworld009/obsidian2.vim',{'hook_add':'silent! colorscheme obsidian2'})
call dein#add('freeo/vim-kalisi',{'hook_add':"set background=dark\nsilent! colorscheme kalisi"})

call dein#add('tpope/vim-fugitive')
call dein#add('gregsexton/gitv')

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
call dein#add('airblade/vim-rooter')
call dein#add('majutsushi/tagbar')
call dein#add('b3niup/numbers.vim')
"call dein#add('zhaocai/GoldenView.Vim')

call dein#add('scrooloose/nerdcommenter')
call dein#add('tpope/vim-surround')

call dein#add('xolox/vim-misc')

function! s:vim_session_setup()
  if has('win32')
    let g:session_directory = $LOCALAPPDATA . '\nvim-data\sessions'
  elseif has('mac')
    let g:session_directory = '~/.local/share/nvim/sessions/'
  endif
  let g:session_autosave = 'yes'
  let g:session_autoload = 'yes'
  let g:session_autosave_periodic = 10
endfunction
call dein#add('xolox/vim-session', {'hook_add': function('s:vim_session_setup')})


function! s:vim_airline_setup()
  "let g:airline_theme = 'powerlineish'
  let g:airline_theme='kalisi'
  let g:airline#extensions#branch#enabled=1
  let g:airline#extensions#tabline#enabled = 1
  set laststatus=2
endfunction
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes',{'hook_add': function('s:vim_airline_setup')})

call dein#add('mbbill/undotree')
call dein#add('Lokaltog/vim-easymotion')

"call dein#add('junegunn/rainbow_parentheses.vim')



" let g:NERDTreeIndicatorMapCustom = {
"   \ "Modified"  : "?",
"   \ "Staged"    : "?",
"   \ "Untracked" : "?",
"   \ "Renamed"   : "?",
"   \ "Unmerged"  : "-",
"   \ "Deleted"   : "?",
"   \ "Dirty"     : "?",
"   \ "Clean"     : "??",
"   \ "Unknown"   : "?"
"   \ }
"let g:rainbow#pairs = [['(', ')'], ['[', ']'],['{','}']]