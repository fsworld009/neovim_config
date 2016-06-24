let s:vimrc_path = $MYVIMRC
let s:vimrc_path = substitute(s:vimrc_path, "init.vim", "", "")

let s:script_files = ["general.vim","keymap.vim"]
for script_file in s:script_files
  execute "source " . s:vimrc_path . script_file
endfor
