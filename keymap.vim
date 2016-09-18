" abbreviated motion keys for split moving
nnoremap <C-Left> <C-w><Left>
nnoremap <C-Right> <C-w><Right>
nnoremap <C-Up> <C-w><Up>
nnoremap <C-Down> <C-w><Down>
nnoremap <C-h> <C-w><Left>
nnoremap <C-l> <C-w><Right>
nnoremap <C-k> <C-w><Up>
nnoremap <C-j> <C-w><Down>
nnoremap <D-Left> <C-w><Left>
nnoremap <D-Right> <C-w><Right>
nnoremap <D-Up> <C-w><Up>
nnoremap <D-Down> <C-w><Down>

" abbreviated motion keys for tab moving
nnoremap ]t gt
nnoremap [t gT
nnoremap ]T :tabs<CR>
nnoremap [T :tabclose<CR>

" abbreviated motion keys for tab moving
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>
nnoremap ]B :buffers<CR>
nnoremap [B :bd<CR>
" abbreviated motion keys for quickfix moving
nnoremap ]c :cnext<CR>
nnoremap [c :cprevious<CR>
nnoremap ]C :copen<CR>
nnoremap [C :cclose<CR>
" abbreviated motion keys for location list moving
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>
nnoremap ]L :lopen<CR>
nnoremap [L :lclose<CR>

" abbreviated motion keys for tags stack moving
nnoremap ]\ <C-]>
nnoremap [\ <C-t>
vnoremap ]\ <C-]>

" abbreviated motion keys for jumplist
nnoremap ]j <C-i>
nnoremap [j <C-o>

"close buffers/kill buffers
nnoremap [q :close<CR>

"remove highlight
nnoremap [h :noh<CR>

"edit .vimrc
nnoremap <leader>ve :e $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

nnoremap <leader>S :set spell!<CR>

"Find and Replace (substitute)
nnoremap <leader>fr :%s///gcI

"dein.vim install and refresh
nnoremap <leader>di :call dein#install()
nnoremap <leader>dr :call dein#recache_runtimepath()
nnoremap <leader>dc :call dein#check_lazy_plugins()
nnoremap <leader>du :call dein#update()

"Unite
nnoremap <leader>uu :Unite -buffer-name=Unite source -start-insert<CR>
nnoremap <leader>uf :Unite -buffer-name=files -start-insert file_rec/async<cr>
nnoremap <leader>ug :Unite -buffer-name=grep -start-insert grep:.<cr>
nnoremap <leader>uc :Unite -buffer-name=command -start-insert command<cr>
nnoremap <leader>uy :Unite -buffer-name=yank\ history -quick-match history/yank<cr>
nnoremap <leader>ub :Unite -buffer-name=buffer buffer<cr>
nnoremap <leader>ut :Unite -buffer-name=tab -quick-match tab<cr>
nnoremap <leader>ur :Unite -buffer-name=register -quick-match register<cr>
nnoremap <leader>u<leader> :Unite -buffer-name=mapping -start-insert mapping<cr>
nnoremap <leader>u\ :Unite -buffer-name=tags -start-insert tag<cr>
nnoremap <leader>um :Unite -buffer-name=mark -quick-match mark<cr>
nnoremap <leader>ul :Unite -buffer-name=location -start-insert locationlist<cr>
nnoremap <leader>uq :Unite -buffer-name=quickfix -start-insert qf<cr>
nnoremap <leader>u/ :Unite -buffer-name=search\ history -quick-match history/search<cr>
nnoremap <leader>u: :Unite -buffer-name=command\ history -quick-match history/command<cr>
nnoremap <leader>uj :Unite -buffer-name=jumplist -quick-match jump<cr>
nnoremap <leader>uo :Unite -buffer-name=outline -start-insert outline<cr>
"nnoremap <leader>u- :Unite -buffer-name=bookmark -quick-match bookmark<cr>

"Editor commands
nnoremap <leader>ef :NERDTreeToggle<CR>
nnoremap <leader>en :NumbersToggle<CR>
nnoremap <leader>et :TagbarToggle<CR>
"nnoremap <leader>eg :GoldenViewResize<CR>

"Undo Tree
nnoremap <leader>eu :UndotreeToggle<CR>

"EasyMotion key bindings
  nmap <Plug>(easymotion-prefix)s <Plug>(easymotion-s2)
  nmap <Plug>(easymotion-prefix)<Down> <Plug>(easymotion-j)
  nmap <Plug>(easymotion-prefix)<Up> <Plug>(easymotion-k)
  nmap <Plug>(easymotion-prefix)/   <Plug>(easymotion-sn)
  nmap <Plug>(easymotion-prefix). <Plug>(easymotion-repeat)
  
"Surround plugin command remaps (all commands begin with <leader>s, it just makes more sense to me)
  "cs ysiw ds yss (V)S
  nmap <leader>sc cs
  nmap <leader>sd ds
  nmap <leader>sw ysiw
  nmap <leader>sW ysiW
  nmap <leader>ss yss
  vmap <leader>s S
  
"Copy between register " (default register) and * (Windows clipboard)
  nnoremap <leader>>> :let @*=@"<CR>
  nnoremap <leader><< :let @"=@*<CR>
  
"Fugitive
  nnoremap <leader>gs :Gstatus<CR>
  nnoremap <leader>gd :Gdiff<CR>
  nnoremap <leader>gc :Gcommit<CR>
  nnoremap <leader>gl :Gitv<CR>
  nnoremap <leader>gg :Git 
  nnoremap <leader>g! :Git! 
  nnoremap <leader>g> :diffget 2<CR>
  nnoremap <leader>g< :diffget 3<CR>
  
"Tern
  nnoremap <leader>td :TernDef<CR>
  
"Autocomplete movement by Arrows
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<Tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<C-d>"


"Spell/Thesaurus/Dictionary from Normal mode
let g:lexical#spell_key = '<leader>zs'
let g:lexical#thesaurus_key = '<leader>zt'
let g:lexical#dictionary_key = '<leader>zk'

"Session
nnoremap <leader>SS :SaveSession<CR>
nnoremap <leader>SO :OpenSession! default<CR>

"UltiSnips key change (<Tab> is conflicted with autocomplete menu tab s-tab setting)
let g:UltiSnipsExpandTrigger ="<c-tab>"
let g:UltiSnipsListSnippets ="<c-y><tab>"
"let g:UltiSnipsJumpForwardTrigger ="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"