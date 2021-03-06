"unite-outline rule test
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

  if has('win32')
    let bin_name = 'jsctags.cmd'
  else
    let bin_name = 'jsctags'
  endif

  let cmdline = bin_name . opts . path
  "let g:cmdline = cmdline

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
  let a:heading_object.word = a:heading_object.namespace_key
  if a:heading_object.namespace_key != 'prototype' && a:heading_object.namespace_key != '__proto__' && a:heading_object.namespace_key != 'constructor'
    if !has_key(a:heading_object, "type")
      let type_prefix=''
    elseif a:heading_object.type == 'function'
      let type_prefix='()'
    else
      let type_prefix=''
    endif

    if has_key(a:heading_object, 'type_info')
      let a:heading_object.word .= ' ' . type_prefix . ':: ' . a:heading_object.type_info
    else
      let a:heading_object.word .= ' ' . type_prefix . ':: (' . a:heading_object.type . ')'
    endif
  endif
endfunction

function! s:append_parents(namespace_to_heading_map, parse_namespace, root, heading_object)
  let parent_namespace = a:parse_namespace
  let no_node_namespaces=[]
  "if parent node(s) are not created yet (i.e. they are not tagged individually), create them with lnum=(this node).lnum
  while !has_key(a:namespace_to_heading_map, parent_namespace)
    let split_parent_namespace = substitute(parent_namespace,'\.[^\.]*$','','')
    let split_child_namespace = substitute(parent_namespace,split_parent_namespace . '\.','','')
    let no_node_namespaces = [split_child_namespace] + no_node_namespaces
    let reach_root = parent_namespace==split_parent_namespace
    if has_key(a:namespace_to_heading_map, split_parent_namespace) || reach_root
      let create_parent_namespace = split_parent_namespace
      for create_child_namespace in no_node_namespaces
        let new_node = s:Tree.new()
        let new_node.lnum = a:heading_object.lnum
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
endfunction


function! s:parse_line(line, root, namespace_to_heading_map)
  let parse_index=0
  let heading_object = s:Tree.new()
  let parse_namespace=''
  "let g:parse = split(a:line,'\t')
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
    elseif parse =~ '^type:'
      let heading_object.type_info = substitute(parse,'type:','','')
    endif
    let parse_index = parse_index+1
  endfor

  if parse_namespace == ''
    let namespace = heading_object.namespace_key
    let append_to = a:root
  else
    let namespace = parse_namespace . '.' . heading_object.namespace_key
    call s:append_parents(a:namespace_to_heading_map, parse_namespace, a:root, heading_object)
    let append_to = a:namespace_to_heading_map[parse_namespace]
  endif

  if has_key(a:namespace_to_heading_map, namespace)
    "if there is already a heading object for this namespace (i.e. child is seen before this node), merge properties
    let temp_heading_object = heading_object
    let heading_object = a:namespace_to_heading_map[namespace]
    let keys=['type','lnum','type_info']
    for key in keys
      if has_key(temp_heading_object, key)
        let heading_object[key] = temp_heading_object[key]
      endif
    endfor
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
  "let g:jsctags_output_list = l:jsctags_output_list


  let root = s:Tree.new()

  let namespace_to_heading_map={}
  for line in l:jsctags_output_list
    call s:parse_line(line, root, namespace_to_heading_map)
  endfor
  return root
  "return headings
endfunction


function! s:unite_source_outline_setup()
  let s:Tree = unite#sources#outline#import('Tree')
  let s:Util  = unite#sources#outline#import('Util')
  let s:Process = unite#util#get_vital().import('Process')
  let g:unite_source_outline_info = get(g:, 'unite_source_outline_info', {})
  let g:unite_source_outline_info.javascript = {
    \'extract_headings' : function('s:extract_headings'),
    \'highlight_rules' : [
      \{'name': 'function',  'pattern' : '/[^: ]\+\s():/','highlight':'Function'},
      \{'name': 'variable',  'pattern' : '/[^: ()]\+\s:/','highlight':'Identifier'},
      \{'name': 'id',        'pattern':'/\s*\(prototype\)$/','highlight':'Special'},
      \{'name': 'id',        'pattern':'/\s*constructor$/','highlight':'Special'},
      \{'name': 'id',        'pattern':'/\s*__proto__$/','highlight':'Special'},
      \{'name': 'type',  'pattern' : '/:\s.\+$/','highlight':'Type'},
      \{'name': 'type',  'pattern' : '/: (variable)$/','highlight':'Type'},
      \{'name': 'type',  'pattern' : '/: (function)$/','highlight':'Type'}
    \],
    \}
endfunction

if g:Plugin_is_sourced('unite-outline')
  call dein#config('unite-outline',{'hook_add':function('s:unite_source_outline_setup')})
endif