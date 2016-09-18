let g:neomake_vim_makers = ['vint']
call dein#add('Shougo/neco-vim',{
  \'hook_add': "let g:deoplete#sources.vim = g:deoplete#sources._ + ['vim']",
  \'on_ft': 'vim',
  \})

