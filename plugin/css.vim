call dein#add('hail2u/vim-css3-syntax',{'on_ft':['css']})
call dein#add('ap/vim-css-color',{'on_ft':['css']})
call dein#add('KabbAmine/vCoolor.vim',{'on_ft':['css']})
call dein#add('mtscout6/vim-tagbar-css',{'on_ft':['css']})

autocmd FileType css setlocal iskeyword+=- omnifunc=csscomplete#CompleteCSS