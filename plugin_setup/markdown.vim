"call dein#add('kmanalo/vim-flavored-markdown') "not working in neovim
augroup markdown_augroup
  autocmd BufNewFile,BufRead *.md,*.MD,*.markdown setlocal filetype=markdown
  autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 wrap
augroup end
