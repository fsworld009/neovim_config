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
    let l:path = a:context.buffer.path
    let l:jsctags_output = system('jsctags ' . l:path . ' -f')
    "remove trailing \n
    let l:jsctags_output = substitute(l:jsctags_output,'\n$','','')
    let l:jsctags_output_list = split(l:jsctags_output,'\n')
    let headings=[]
    for line in l:jsctags_output_list
      let parse_index=0
      let heading_object = {
      \'word':'',
      \'level':1,
      \'type':'variable'
      \}
      for parse in split(line,'\t')
        if parse_index==0
          let heading_object.word = parse
        elseif parse =~ '^lineno:'
          let heading_object.lnum = str2nr(substitute(parse,'lineno:','',''))
        endif
        let parse_index = parse_index+1
      endfor
      let headings = headings + [heading_object]
    endfor
    let g:headings = headings
    return headings
  endfunction
endfunction




#call dein#config('unite-outline',{'hook_add':function('s:unite_source_outline_setup')})

