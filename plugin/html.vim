call dein#add('mattn/emmet-vim',{'on_ft':['html','xml','xhtml']})
call dein#add('othree/html5.vim',{'on_ft':['html','xhtml']})
call dein#add('valloric/MatchTagAlways',{'on_ft':['html','xml','xhtml']})

autocmd FileType html,xhtml,xml setlocal shiftwidth=2 tabstop=2
autocmd FileType html,xhtml setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags