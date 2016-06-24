let g:vimrc_path = $MYVIMRC
let g:vimrc_path = substitute(g:vimrc_path, "init.vim", "", "")

let s:script_files = ["general.vim","keymap.vim"]
for script_file in s:script_files
  execute "source " . g:vimrc_path . script_file
endfor
