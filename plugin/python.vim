let g:neomake_python_makers = ['python']
call dein#add('hdima/python-syntax')
call dein#add('zchee/deoplete-jedi', {
  \'hook_add':"let g:deoplete#sources.python = g:deoplete#sources._ + ['jedi']",
  \'on_ft': 'python'
  \})
