call dein#add('pangloss/vim-javascript',{
  \'on_ft':['jsx']
  \})

call dein#add('mxw/vim-jsx',{
  \'on_ft':['jsx']
  \})

autocmd FileType javascript.jsx setlocal shiftwidth=2 tabstop=2

call dein#config('deoplete-ternjs', {'hook_add':"let g:deoplete#sources['javascript.jsx'] = g:deoplete#sources._ + ['ternjs']"})
