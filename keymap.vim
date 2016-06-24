" abbreviated motion keys for split moving
nnoremap <C-Left> <C-w><Left>
nnoremap <C-Right> <C-w><Right>
nnoremap <C-Up> <C-w><Up>
nnoremap <C-Down> <C-w><Down>
 
" abbreviated motion keys for tab moving
nnoremap ]t gt
nnoremap [t gT
nnoremap ]T :tabs<CR>
nnoremap [T :tabclose<CR>
 
" abbreviated motion keys for tab moving
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>
nnoremap ]B :buffers<CR>
" abbreviated motion keys for quickfix moving
nnoremap ]c :cnext<CR>
nnoremap [c :cprevious<CR>
nnoremap ]C :copen<CR>

" abbreviated motion keys for tags stack moving
nnoremap ]= <C-]>
nnoremap [= <C-t>

" abbreviated motion keys for jumplist
nnoremap ]j <C-i>
nnoremap [j <C-o>

"close buffers/kill buffers
nnoremap [d :bd 
nnoremap [D :bd<CR>
nnoremap [C :close<CR>

"remove highlight
nnoremap [h :noh<CR>

"edit .vimrc
nnoremap <leader>ve :e $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

nnoremap <leader>S :set spell!<CR>
  
"Find and Replace (substitute)
nnoremap <leader>fr :%s///gcI