call dein#add('mattn/emmet-vim',{'on_ft':['html','xml','xhtml','jsx']})
"call dein#add('othree/html5.vim')

function! s:MatchTagAlways_setup()
  let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'xhtml' : 1,
      \ 'xml' : 1,
      \ 'jinja' : 1,
      \ 'javascript.jsx': 1,
      \ 'typescript.tsx': 1
      \}
endfunction

call dein#add('valloric/MatchTagAlways',{
  \'on_ft':['html','xml','xhtml','jsx'],
  \'hook_source': function('s:MatchTagAlways_setup')
  \})

augroup html_augroup
  autocmd FileType html,xhtml,xml setlocal shiftwidth=2 tabstop=2
  autocmd FileType html,xhtml setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
