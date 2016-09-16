call dein#add('mxw/vim-jsx')

autocmd FileType javascript.jsx setlocal shiftwidth=2 tabstop=2

call dein#config('deoplete-ternjs', {'hook_add':"let g:deoplete#sources['javascript.jsx'] = g:deoplete#sources._ + ['ternjs']"})
