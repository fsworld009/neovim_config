call dein#add('mxw/vim-jsx')
augroup jsx_augroup
  autocmd FileType javascript.jsx setlocal shiftwidth=2 tabstop=2
augroup end

call dein#config('deoplete-ternjs', {'hook_add':"let g:deoplete#sources['javascript.jsx'] = g:deoplete#sources._ + ['ternjs']"})
