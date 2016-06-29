call dein#add('hail2u/vim-css3-syntax',{'on_ft':['css']})
call dein#add('ap/vim-css-color',{'on_ft':['css']})
call dein#add('KabbAmine/vCoolor.vim',{'on_ft':['css']})
call dein#add('mtscout6/vim-tagbar-css',{'on_ft':['css']})

let g:neomake_css_enabled_makers = ['stylelint']
if has('win32')
  let g:neomake_css_stylelint_exe =  'stylelint.cmd'
endif

autocmd FileType css setlocal iskeyword+=- omnifunc=csscomplete#CompleteCSS