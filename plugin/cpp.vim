let g:neomake_cpp_enabled_makers = ['clang']

call dein#add('zchee/deoplete-clang')

if has('win32')
  let g:deoplete#sources#clang#libclang_path = 'C:\Program Files\LLVM\lib\libclang.lib'
  let g:deoplete#sources#clang#clang_header = 'C:\Program Files\LLVM\lib\clang\3.8.1'
end
