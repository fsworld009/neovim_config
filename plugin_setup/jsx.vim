call dein#add('mxw/vim-jsx')
augroup jsx_augroup
  "autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  autocmd FileType javascript.jsx setlocal shiftwidth=2 tabstop=2
augroup end

"call dein#add('maxmellon/vim-jsx-pretty')
call dein#config('deoplete-ternjs', {'hook_add':"let g:deoplete#sources['javascript.jsx'] = g:deoplete#sources._ + ['ternjs']"})
