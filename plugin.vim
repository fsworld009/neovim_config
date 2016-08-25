if &compatible
  set nocompatible
endif

let s:plugin_base_path = substitute($MYVIMRC, 'nvim' .g:dir_separator . 'init.vim', 'nvim_plugin' . g:dir_separator, '')
let s:dein_base_path = s:plugin_base_path . 'repos' . g:dir_separator . 'github.com' . g:dir_separator . 'Shougo' . g:dir_separator . 'dein.vim'

execute "set runtimepath^=" . s:dein_base_path

call dein#begin(s:plugin_base_path)
call dein#add('Shougo/dein.vim')

let s:script_files = [
  \ 'general.vim',
  \ 'cpp.vim',
  \ 'markdown.vim',
  \ 'html.vim',
  \ 'css.vim',
  \ 'javascript.vim',
  \ 'jsx.vim',
  \ 'json.vim'
  \]
  
for script_file in s:script_files
  execute "source " . g:vimrc_path . 'plugin' . g:dir_separator . script_file
endfor


call dein#end()

filetype plugin indent on

"call dein#install()
"autocmd VimEnter * call dein#call_hook('post_source')

