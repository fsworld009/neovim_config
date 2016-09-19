"empty dein
let g:vimrc_path = $MYVIMRC
let g:vimrc_path = substitute(g:vimrc_path, 'init.vim', '', '')

let g:dir_separator = ''
if has('win32')
  let g:dir_separator = '\\'
elseif has('mac')
  if exists('*MacSetFont')
    call MacSetFont('Monaco', 13)
  endif
  let g:dir_separator = '/'
elseif has('unix')
  let g:dir_separator = '/'
endif


let s:plugin_base_path = substitute($MYVIMRC, 'nvim' .g:dir_separator . 'init.vim', 'nvim_plugin' . g:dir_separator, '')
let g:plugin_base_path = s:plugin_base_path
let s:dein_base_path = s:plugin_base_path . 'repos' . g:dir_separator . 'github.com' . g:dir_separator . 'Shougo' . g:dir_separator . 'dein.vim'

execute 'set runtimepath^=' . s:dein_base_path

call dein#begin(s:plugin_base_path)

call dein#end()