call dein#add('ianks/vim-tsx')

autocmd FileType typescript.tsx setlocal shiftwidth=2 tabstop=2

call dein#config('deoplete-typescript', {'hook_add':"let g:deoplete#sources['typescript.tsx'] = g:deoplete#sources._ + ['typescript']"})