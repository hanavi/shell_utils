
fun! SplitPipes()
   s/ *| */ \\\r    | /g
   noh
endfun
nnoremap <leader>sp :call SplitPipes()<CR>

fun! UnsplitPipes() range
   exe a:firstline . ',' . a:lastline . 's/ \\\n *| \?/ | /'
   noh
endfun
vnoremap <leader>u :call UnsplitPipes()<CR>
