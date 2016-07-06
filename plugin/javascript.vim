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

function! s:parse_line(line, root, namespace_to_heading_map)
  let parse_index=0
  let heading_object = s:Tree.new()
  let parse_namespace=''
  for parse in split(a:line,'\t')
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
    let append_to = a:root
  else
    let namespace = parse_namespace . '.' . heading_object.word
    
    "if parent node(s) are not created yet (i.e. they are not tagged individually), create them with lnum=(this node).lnum
    let parent_namespace = parse_namespace
    let no_node_namespaces=[]
    while !has_key(a:namespace_to_heading_map, parent_namespace)
      let split_parent_namespace = substitute(parent_namespace,'\.[^\.]*$','','')
      let split_child_namespace = substitute(parent_namespace,split_parent_namespace . '\.','','')
      let no_node_namespaces = [split_child_namespace] + no_node_namespaces
      let reach_root = parent_namespace==split_parent_namespace
      if has_key(a:namespace_to_heading_map, split_parent_namespace) || reach_root
        let create_parent_namespace = split_parent_namespace
        for create_child_namespace in no_node_namespaces
          let new_node = s:Tree.new()
          let new_node.lnum = heading_object.lnum
          let new_node.word = create_child_namespace
          "object is definitely a variable
          let new_node.type = 'variable'
          if reach_root
            let create_append_to = a:root
          else
            let create_append_to = a:namespace_to_heading_map[create_parent_namespace]
          endif
          call s:Tree.append_child(create_append_to, new_node)
          if reach_root
            let create_parent_namespace = create_child_namespace
          else
            let create_parent_namespace = create_parent_namespace . '.' . create_child_namespace
          endif
          "second parent node and beyond won't be on the root
          let reach_root=0
          let a:namespace_to_heading_map[create_parent_namespace] = new_node
        endfor
      endif
      let parent_namespace = split_parent_namespace
    endwhile
    
    let append_to = a:namespace_to_heading_map[parse_namespace]
  endif
  if has_key(a:namespace_to_heading_map, namespace)
    "if there is already a heading object for this namespace (i.e. child is seen before this node), merge properties
    let temp_heading_object = heading_object
    let heading_object = a:namespace_to_heading_map[namespace]
    let heading_object.lnum = temp_heading_object.lnum
    let heading_object.type = temp_heading_object.type
  else
    let a:namespace_to_heading_map[namespace] = heading_object
    call s:Tree.append_child(append_to, heading_object)
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
    call s:parse_line(line, root, namespace_to_heading_map)
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

