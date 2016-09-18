let g:neomake_vim_makers = ['vint']
call dein#add('Shougo/neco-vim',{
  \'hook_source': "let g:deoplete#sources.vim = g:deoplete#sources._ + ['vim']",
  \'on_ft': 'vim',
  \})

augroup vim_augroup
  autocmd FileType vim setlocal shiftwidth=2 tabstop=2
augroup end
