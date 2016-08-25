"call dein#add('kmanalo/vim-flavored-markdown') "not working in neovim
autocmd BufNewFile,BufRead *.md,*.MD,*.markdown setlocal filetype=markdown
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2