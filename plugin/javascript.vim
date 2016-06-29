"call dein#add('ternjs/tern_for_vim', {
"			\ 'build': 'npm install',
"			\ 'if': 'executable("npm")',
"			\ 'on_ft': 'javascript'
"           \ })
            
call dein#add('othree/yajs.vim', {'on_ft': 'javascript'})

call dein#add('othree/javascript-libraries-syntax.vim', {
  \'hook_add': "let g:used_javascript_libs = 'lodash,jquery,react'"
  \})

let g:neomake_javascript_enabled_makers = ['eslint']
if has('win32')
  let g:neomake_javascript_eslint_exe =  'eslint.cmd'
endif


  "let g:neomake_javascript_eslint_exe =  'C:\neovim-qt\node_modules\.bin\eslint.cmd'
  "let g:neomake_javascript_eslint_maker = {
  "  \ 'args': ['--no-color', '--format', 'compact'],
  "  \ 'errorformat': '%f: line %l\, col %c\, %m'
  "  \ }
"call dein#add('benjie/neomake-local-eslint.vim')

"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

"tern
call dein#add('carlitux/deoplete-ternjs')
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1
"autocmd FileType javascript setlocal omnifunc=tern#Complete

let g:gutentags_ctags_executable_javascript = 'jsctags'