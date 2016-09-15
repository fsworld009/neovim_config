let g:neomake_cpp_enabled_makers = ['clang']

"call dein#add('zchee/deoplete-clang')
"call dein#add('justmao945/vim-clang')

if has('win32')
   let g:neomake_cpp_clang_maker = {
    \ 'args': ['--target=x86_64-w64-mingw32']
    \}
   let g:neomake_c_enabled_makers = ['clang']
   let g:neomake_c_clang_maker = {
   \ 'args': ['--target=x86_64-w64-mingw32']
   \}
   
  let g:deoplete#sources#clang#libclang_path = 'C:\LLVM\bin\libclang.dll'
  let g:deoplete#sources#clang#clang_header = 'C:\LLVM\lib\clang'
  let g:deoplete#sources#clang#flags = ['--target=x86_64-w64-mingw32']
  let g:deoplete#sources#clang#sort_algo = 'priority'
  let g:deoplete#sources#clang#std#cpp = 'c++11'
  
  let g:deoplete#sources.cpp = g:deoplete#sources._ + ['clang']
  let g:deoplete#sources.c = g:deoplete#sources._ + ['clang']
  
  "call deoplete#custom#set('buffer', 'rank', 9999)
  "call deoplete#custom#set('ultisnips', 'rank', 9999)
  
  "let g:clang_c_options = '--target=x86_64-w64-mingw32'
  "let g:clang_cpp_options = '--target=x86_64-w64-mingw32'
  "let g:clang_exec = 'C:\Progra~1\LLVM\bin\clang++.exe'
  
elseif has('mac')
  "let g:deoplete#sources#clang#flags = [
  "    \ "-cc1",
  "    \ "-triple", "x86_64-apple-macosx10.11.0",
  "    \ "-isysroot", "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk",
  "    \ "-fmax-type-align=16",
  "    \ ]
  "
  "Doesnot work with gcc?    
  "let g:clang_c_options = '-std=gnu11'
  "let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
end


