if has('win32')
  call dein#add('equalsraf/neovim-gui-shim')
endif

"call dein#add('fsworld009/obsidian2.vim',{'hook_add':'silent! colorscheme obsidian2'})
"call dein#add('freeo/vim-kalisi',{'hook_add':"set background=dark\nsilent! colorscheme kalisi"})
call dein#add('mhartington/oceanic-next',{'hook_add':"set background=dark\nsilent! colorscheme OceanicNext"})

call dein#add('tpope/vim-fugitive')
call dein#add('gregsexton/gitv')

call dein#add('Yggdroot/indentLine')
call dein#add('kshenoy/vim-signature')


call dein#add('Shougo/vimproc.vim')
"call dein#add('Shougo/vimproc.vim', {
"    \ 'build': {
"    \     'windows': 'tools\\update-dll-mingw',
"    \     'cygwin': 'make -f make_cygwin.mak',
"    \     'mac': 'make -f make_mac.mak',
"    \     'linux': 'make',
"    \     'unix': 'gmake',
"    \    },
"    \ })

function! s:unite_setup()
  let l:installed = dein#tap('unite.vim')
  if l:installed
    call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', 'node_modules/\|.DS_Store')
  endif
endfunction

call dein#add('Shougo/unite.vim', {'hook_add': function('s:unite_setup')})
call dein#add('Shougo/neoyank.vim')
call dein#add('tsukkee/unite-tag')
call dein#add('tacroe/unite-mark')
call dein#add('thinca/vim-unite-history')
call dein#add('sgur/unite-qf')
call dein#add('Shougo/unite-outline')


"call dein#add('scrooloose/nerdtree',
"      \{'on_cmd': 'NERDTreeToggle'})

call dein#add('scrooloose/nerdtree')
"call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('airblade/vim-rooter')
call dein#add('majutsushi/tagbar')
call dein#add('b3niup/numbers.vim')
"call dein#add('zhaocai/GoldenView.Vim')
call dein#add('justincampbell/vim-eighties')

call dein#add('scrooloose/nerdcommenter')
call dein#add('tpope/vim-surround')

call dein#add('xolox/vim-misc')

function! s:vim_session_setup()
  if has('win32')
    let g:session_directory = $LOCALAPPDATA . '\nvim-data\sessions'
  elseif has('mac')
    let g:session_directory = '~/.local/share/nvim/sessions/'
  endif
  let g:session_autosave = 'yes'
  let g:session_autoload = 'yes'
  let g:session_autosave_periodic = 10
endfunction
call dein#add('xolox/vim-session', {'hook_add': function('s:vim_session_setup')})


function! s:vim_airline_setup()
  "let g:airline_theme = 'powerlineish'
  "let g:airline_theme='kalisi'
  let g:airline_theme='oceanicnext'
  let g:airline#extensions#branch#enabled=1
  let g:airline#extensions#tabline#enabled = 1
  set laststatus=2
endfunction
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes',{'hook_add': function('s:vim_airline_setup')})

call dein#add('mbbill/undotree')
call dein#add('Lokaltog/vim-easymotion')

"call dein#add('junegunn/rainbow_parentheses.vim')

function! s:neomake_setup()
  autocmd! BufWritePost,BufEnter * Neomake
  let g:neomake_open_list = 0

  "let g:neomake_logfile='C:\error.log'
  let g:neomake_warning_sign = {
    \ 'text': 'W',
    \ 'texthl': 'WarningMsg',
    \ }

  let g:neomake_error_sign = {
    \ 'text': 'E',
    \ 'texthl': 'ErrorMsg',
    \ }
  "let g:neomake_vim_enabled_makers = ['vimlint']
endfunction

call dein#add('neomake/neomake',{'hook_add':function('s:neomake_setup')})
call dein#add('syngan/vim-vimlint')

"https://github.com/neomake/neomake/issues/296
augroup neomake
  au! BufEnter * call EnterNeomake()
  au! BufWritePost * call SaveNeomake()
augroup END
function! EnterNeomake()
  " don't show the location-list when entering a buffer
  let g:neomake_open_list=0
  exe 'Neomake'
endfunction
function! SaveNeomake()
  " show the loc-list after saving
  let g:neomake_open_list=2
  exe 'Neomake'
endfunction

" https://gregjs.com/vim/2016/configuring-the-deoplete-asynchronous-keyword-completion-plugin-with-tern-for-vim/
function! s:deoplete_setup()
  let g:deoplete#enable_at_startup = 1
  if !exists('g:deoplete#sources')
    let g:deoplete#sources = {
    \ '_' : ['buffer','member','tag','file','ultisnips']
    \}
  endif
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  "if !exists('g:deoplete#omni#input_patterns')
  "  let g:deoplete#omni#input_patterns = {}
  "endif
  " let g:deoplete#disable_auto_complete = 1
  "call deoplete#enable_logging("INFO", 'path\to\deoplete_log.txt')
endfunction

call dein#add('Shougo/deoplete.nvim',{'hook_add':function('s:deoplete_setup')})

call dein#add('ludovicchabant/vim-gutentags')

" let g:NERDTreeIndicatorMapCustom = {
"   \ "Modified"  : "?",
"   \ "Staged"    : "?",
"   \ "Untracked" : "?",
"   \ "Renamed"   : "?",
"   \ "Unmerged"  : "-",
"   \ "Deleted"   : "?",
"   \ "Dirty"     : "?",
"   \ "Clean"     : "??",
"   \ "Unknown"   : "?"
"   \ }
"let g:rainbow#pairs = [['(', ')'], ['[', ']'],['{','}']]

function! s:vim_easygrep_setup()
  let g:EasyGrepFilesToExclude = '.svn,.git,node_modules/*.*,tags,*.swp,*~'
endfunction


call dein#add('dkprice/vim-easygrep', {'hook_add':function('s:vim_easygrep_setup')})


" Spelling
call dein#add('reedes/vim-lexical')
let g:lexical#spelllang=['en']
let g:lexical#spellfile = [g:vimrc_path . 'spell\en.utf-8.add']
autocmd BufNewFile,BufRead * call lexical#init()

"CamelCaseMotion
function! s:CamelCaseMotion_setup()
  let l:installed = dein#tap('CamelCaseMotion')
  if l:installed
    call camelcasemotion#CreateMotionMappings('\')
  endif
endfunction

call dein#add('bkad/CamelCaseMotion',{'hook_add':function('s:CamelCaseMotion_setup')})

function! s:Ultisnips_setup()
  "execute "set runtimepath+=" . g:vimrc_path . 'UltiSnips' . g:dir_separator
  let g:UltiSnipsUsePythonVersion = 3
  let l:installed = dein#tap('deoplete.nvim')
  if l:installed
    call deoplete#custom#set('ultisnips', 'min_pattern_length', 1)
    call deoplete#custom#set('ultisnips', 'rank', 9999)
  endif
endfunction

call dein#add('SirVer/ultisnips',{'hook_add':function('s:Ultisnips_setup')})
call dein#add('honza/vim-snippets')
