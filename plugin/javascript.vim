call dein#add('ternjs/tern_for_vim', {
			\ 'build': 'npm install',
			\ 'if': 'executable("npm")',
			\ 'on_ft': 'javascript'
            \ })
            
call dein#add('othree/yajs.vim', {'on_ft': 'javascript'})

call dein#add('othree/javascript-libraries-syntax.vim', {
  \'hook_add': "let g:used_javascript_libs = 'lodash,jquery,react'"
  \})
