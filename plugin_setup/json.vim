call dein#add('elzr/vim-json')

let g:vim_json_syntax_conceal = 0
let g:neomake_json_enabled_makers = ['jsonlint']
if has('win32')
  let g:neomake_json_jsonlint_exe = 'jsonlint.cmd'
endif
augroup json_augroup
  autocmd BufRead .tern-project,.stylelintrc setlocal filetype=json
  autocmd FileType json setlocal foldmethod=syntax shiftwidth=2 tabstop=2
augroup end
