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

let s:Tree = unite#sources#outline#import('Tree')

function! s:create_heading_object(parent_heading_object)
  if !exist(a:parent_heading_object)
    return s:Tree.new()
  else
    let heading_object = {
    \'word':'',
    \'level': (a:parent_heading_object.level)+1,
    \'type':'variable'
    \}
    
    return heading_object
  endif
  
endfunction

function! s:extract_headings(context)
  let l:path = a:context.buffer.path
  let l:jsctags_output = system('jsctags ' . l:path . ' -f')

  let l:jsctags_output = substitute(l:jsctags_output,'\n$','','')
  let l:jsctags_output_list = split(l:jsctags_output,'\n')
  "let headings=[]
  
  let root = s:Tree.new()
  
  let namespace_to_heading_map={}
  for line in l:jsctags_output_list
    let parse_index=0
    let heading_object = s:Tree.new()
    let parse_namespace=''
    for parse in split(line,'\t')
      if parse_index==0
        let heading_object.word = parse
      elseif parse =~ '^lineno:'
        let heading_object.lnum = str2nr(substitute(parse,'lineno:','',''))
      elseif parse =~ '^namespace:'
        let parse_namespace = substitute(parse,'namespace:','','')
        let g:parse_namespace = parse_namespace
      endif
      let parse_index = parse_index+1
    endfor
    if parse_namespace == ''
      let namespace = heading_object.word
      let append_to = root
    else
      let namespace = parse_namespace . '.' . heading_object.word
      if has_key(namespace_to_heading_map, parse_namespace)
        let append_to = namespace_to_heading_map[parse_namespace]
      else
        "create parents first
      endif
    endif
    let namespace_to_heading_map[namespace] = heading_object
    "let headings = headings + [heading_object]
    call s:Tree.append_child(append_to, heading_object)
  endfor
  let g:namespace_to_heading_map = namespace_to_heading_map
  return root
  "return headings
endfunction


function! s:unite_source_outline_setup()
  let g:test = 1
  let g:unite_source_outline_info = get(g:, 'unite_source_outline_info', {})
  let g:unite_source_outline_info.javascript = {
    \'extract_headings' : function('s:extract_headings')
    \}
endfunction




call dein#config('unite-outline',{'hook_add':function('s:unite_source_outline_setup')})

