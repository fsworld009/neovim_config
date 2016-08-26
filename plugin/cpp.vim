let g:neomake_cpp_enabled_makers = ['clang']

call dein#add('zchee/deoplete-clang')

if has('win32')
  let g:neomake_cpp_clang_maker = {
    \ 'args': ['--target=x86_64-w64-mingw32']
    \}
  let g:deoplete#sources#clang#libclang_path = 'C:\Program Files\LLVM\bin\libclang.dll'
  let g:deoplete#sources#clang#clang_header = 'C:\Program Files\LLVM\lib\clang'
end

"call dein#add('justmao945/vim-clang')
"let g:clang_c_options = '-std=gnu11'
"let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'