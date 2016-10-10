augroup typescript_augroup
  autocmd FileType typescript setlocal shiftwidth=4 tabstop=4
augroup end

function! s:yats_setup()
    execute 'set runtimepath+=' . g:plugin_base_path . 'repos' . g:dir_separator . 'github.com' . g:dir_separator . 'HerringtonDarkholme' . g:dir_separator . 'yats.vim' . g:dir_separator
endfunction 

call dein#add('HerringtonDarkholme/yats.vim',{
  \'hook_add':function('s:yats_setup')
  \})


"https://github.com/neomake/neomake/issues/
"https://github.com/neomake/neomake/issues/288
let g:neomake_typescript_tsc_maker = {
\ 'args': [
\ '-p', 'tsconfig.json', '--noEmit'
\ ],
\ 'append_file': 0
\ }
let g:neomake_typescript_enabled_makers = ['tsc']


if has('win32')
  let g:neomake_typescript_tsc_exe =  'tsc.cmd'
endif


call dein#add('mhartington/deoplete-typescript', {
  \'hook_source':"let g:deoplete#sources.typescript = g:deoplete#sources._ + ['typescript']",
  \'on_ft': 'typescript'
  \})

