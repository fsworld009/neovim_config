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




"unite-outlint rule test
function! s:unite_source_outline_setup()
  let g:test = 1
  let g:unite_source_outline_info = get(g:, 'unite_source_outline_info', {})
  let g:unite_source_outline_info.javascript = {}
    "\'heading' : 'heading'
    "\}
  function! g:unite_source_outline_info.javascript.create_heading(which, heading_line, matched_line, context)
  let g:output = {
  \ 'which':a:which,
  \ 'heading_line':a:heading_line,
  \ 'matched_line':a:matched_line,
  \ 'context':a:context
  \}
    return {
        \ 'word' : "heading2",
        \ 'level': 1,
        \ 'type' : 'generic',
        \ }
  endfunction
    
  function! g:unite_source_outline_info.javascript.extract_headings(context)
    return [{
        \ 'word' : "heading",
        \ 'level': 1,
        \ 'type' : 'function',
        \ 'lnum': 1
        \ },
        \{
        \ 'word' : "heading_v",
        \ 'level': 2,
        \ 'type' : 'variable',
        \ 'lnum': 2
        \ },
        \]
  endfunction
endfunction




"call dein#config('unite-outline',{'hook_add':function('s:unite_source_outline_setup')})

