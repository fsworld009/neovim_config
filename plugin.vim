if &compatible
  set nocompatible
endif

let s:plugin_base_path = substitute($MYVIMRC, "nvim" .g:dir_separator . "init.vim", "nvim_plugin" . g:dir_separator, "")
let s:dein_base_path = s:plugin_base_path . "repos" . g:dir_separator . "github.com" . g:dir_separator . "Shougo" . g:dir_separator . "dein.vim" . g:dir_separator

execute "set runtimepath^=" . s:dein_base_path

call dein#begin(s:plugin_base_path)

call dein#add(s:dein_base_path)
"call dein#add('fsworld009/obsidian2.vim')

call dein#end()

filetype plugin indent on
