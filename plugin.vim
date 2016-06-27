if &compatible
  set nocompatible
endif

let s:plugin_base_path = substitute($MYVIMRC, "nvim" .g:dir_separator . "init.vim", "nvim_plugin" . g:dir_separator, "")
let s:dein_base_path = s:plugin_base_path . "repos" . g:dir_separator . "github.com" . g:dir_separator . "Shougo" . g:dir_separator . "dein.vim" . g:dir_separator

execute "set runtimepath^=" . s:dein_base_path

call dein#begin(s:plugin_base_path)

call dein#add('Shougo/dein.vim')

call dein#add('fsworld009/obsidian2.vim')

"function! SetColorScheme()
"  echo 'inside'
"  colorscheme obsidian2
"endfunction
"call dein#set_hook('obsidian2.vim','post_add',function('SetColorScheme'))

call dein#add('Shougo/vimproc.vim', {
    \ 'build': {
    \     'windows': 'tools\\update-dll-mingw',
    \     'cygwin': 'make -f make_cygwin.mak',
    \     'mac': 'make -f make_mac.mak',
    \     'linux': 'make',
    \     'unix': 'gmake',
    \    },
    \ })

call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neoyank.vim')

call dein#end()


filetype plugin indent on

"call dein#install()
"autocmd VimEnter * call dein#call_hook('post_source')
