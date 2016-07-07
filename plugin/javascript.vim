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
let s:Util  = unite#sources#outline#import('Util')
let s:Process = unite#util#get_vital().import('Process')

function! s:execute_jsctags(context) abort
  " Write the current content of the buffer to a temporary file.
  let input = join(a:context.lines[1:], "\<NL>")
  let input = s:Process.iconv(input, &encoding, &termencoding)
  let temp_file = tempname()
  if unite#util#is_sudo() ||
        \ writefile(split(input, "\<NL>"), temp_file) == -1
    call unite#util#print_message(
          \ "[unite-outline] Couldn't make a temporary file at " . temp_file)
    return []
  endif
  " NOTE: If the auto-update is enabled, the buffer may have been changed
  " since the last write. Because the user expects the headings to be
  " extracted from the buffer which he/she is watching now, we need to process
  " the buffer's content not its file's content.

  let filetype = a:context.buffer.filetype
  " Assemble the command-line.
  "let lang_info = s:Ctags.lang_info[filetype]
  "let opts  = ' -f - --excmd=number --fields=afiKmsSzt --sort=no --append=no'
  "let opts .= " --language-force=\"" . lang_info.name . "\" "
  "let opts .= lang_info.ctags_options
  let opts = ' -f - '

  let path = s:Util.Path.normalize(temp_file)
  let path = s:Util.String.shellescape(path)

  let cmdline = 'jsctags.cmd' . opts . path
  let g:cmdline = cmdline

  " Execute the Ctags.
  let ctags_out = unite#util#system(cmdline)
  let status = unite#util#get_last_status()
  if status != 0
    call unite#print_message(
          \ "[unite-outline] ctags failed with status " . status . ".")
    return []
  endif

  " Delete the used temporary file.
  if delete(temp_file) != 0
    call unite#print_error(
          \ "unite-outline: Couldn't delete a temporary file: " . temp_file)
  endif

  let ctags_out = substitute(ctags_out, '\n$','','')
  let tag_lines = split(ctags_out, "\<NL>")
  try
    " Convert tag lines into tag objects.
    "let tags = map(tag_lines, 's:create_tag(v:val, lang_info)')
    "call filter(tags, '!empty(v:val)')
    "return tags
    return tag_lines
  catch
    " The first line of the output often contains a hint of an error.
    throw tag_lines[0]
  endtry
endfunction

function! s:set_word_by_type(heading_object)
  if a:heading_object.type == 'function'
    let a:heading_object.word = a:heading_object.namespace_key . ' ()'
  else
    let a:heading_object.word = a:heading_object.namespace_key
  endif
endfunction


function! s:parse_line(line, root, namespace_to_heading_map)
  let parse_index=0
  let heading_object = s:Tree.new()
  let parse_namespace=''
  let g:parse = split(a:line,'\t')
  for parse in split(a:line,'\t')
    if parse_index==0
      let heading_object.namespace_key = parse
    elseif parse =~ '^lineno:'
      let heading_object.lnum = str2nr(substitute(parse,'lineno:','',''))
    elseif parse =~ '^namespace:'
      let parse_namespace = substitute(parse,'namespace:','','')
    elseif parse == 'v'
      let heading_object.type = 'variable'
    elseif parse == 'f'
      let heading_object.type = 'function'
    endif
    let parse_index = parse_index+1
  endfor
  
  if parse_namespace == ''
    let namespace = heading_object.namespace_key
    let append_to = a:root
  else
    let namespace = parse_namespace . '.' . heading_object.namespace_key
    
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
          let new_node.namespace_key = create_child_namespace
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
    if has_key(temp_heading_object, 'lnum')
        let heading_object.lnum = temp_heading_object.lnum
    endif
    if has_key(temp_heading_object, 'type')
      let heading_object.type = temp_heading_object.type
    endif
    call s:set_word_by_type(heading_object)
  else
    call s:set_word_by_type(heading_object)
    let a:namespace_to_heading_map[namespace] = heading_object
    call s:Tree.append_child(append_to, heading_object)
  endif


endfunction

function! s:extract_headings(context)
  let l:path = a:context.buffer.path
  let l:jsctags_output_list = s:execute_jsctags(a:context)
  let g:jsctags_output_list = l:jsctags_output_list


  let root = s:Tree.new()
  
  let namespace_to_heading_map={}
  for line in l:jsctags_output_list
    call s:parse_line(line, root, namespace_to_heading_map)
  endfor
  return root
  "return headings
endfunction


function! s:unite_source_outline_setup()
  let g:unite_source_outline_info = get(g:, 'unite_source_outline_info', {})
  let g:unite_source_outline_info.javascript = {
    \'extract_headings' : function('s:extract_headings'),
    \'highlight_rules' : [{
    \ 'name' : 'variable',
    \ 'pattern': '/[^\(\)]\+/'
    \ },{ 'name'     : 'function',
     \ 'pattern' : '/\S\+\s\(\)/'},
    \{ 'name'     : 'generic',
     \ 'pattern' : '/aaa/'},
     \{'name': 'id','pattern':'/\s*prototype$/'}
     \]
    \}
    
  let g:unite_source_outline_highlight = {
		      \ 'comment' : 'Comment',
		      \ 'expanded': 'Constant',
		      \ 'function': 'Function',
              \ 'variable': 'Identifier',
		      \ 'id'      : 'Special',
		      \ 'macro'   : 'Macro',
		      \ 'method'  : 'Function',
              \ 'generic' : 'Normal',
		      \ 'normal'  : 'Normal',
		      \ 'package' : 'Normal',
		      \ 'special' : 'Macro',
		      \ 'type'    : 'Type',
		      \ 'level_1' : 'Type',
		      \ 'level_2' : 'PreProc',
		      \ 'level_3' : 'Identifier',
		      \ 'level_4' : 'Constant',
		      \ 'level_5' : 'Special',
		      \ 'level_6' : 'Normal',
		      \ 'parameter_list': 'Normal',
\ }
endfunction




call dein#config('unite-outline',{'hook_add':function('s:unite_source_outline_setup')})

