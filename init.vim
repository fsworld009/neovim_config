let g:vimrc_path = $MYVIMRC
let g:vimrc_path = substitute(g:vimrc_path, "init.vim", "", "")

let g:dir_separator = ""
if has('win32')
  let g:dir_separator = "\\"
elseif has('mac')
  if exists('*MacSetFont')
    call MacSetFont("Monaco", 14)
  endif
  let g:dir_separator = "/"
elseif has('unix')
  let g:dir_separator = "/"
endif



let s:script_files = ["plugin.vim","general.vim","keymap.vim"]
for script_file in s:script_files
  execute "source " . g:vimrc_path . script_file
endfor
