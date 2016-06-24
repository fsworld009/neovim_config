let s:vimrc_path = $MYVIMRC
let s:vimrc_path = substitute(s:vimrc_path, "init.vim", "", "")

let s:script_files = ["general.vim"]
for i in s:script_files
  execute "source " . s:vimrc_path . s:script_files[i]
endfor
