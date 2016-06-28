call dein#add('elzr/vim-json')

let g:vim_json_syntax_conceal = 0
autocmd FileType json setlocal foldmethod=syntax shiftwidth=2 tabstop=2