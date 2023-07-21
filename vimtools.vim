
" Bash
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

" Python
iabbrev ;bp; pathlib.Path(__file__).resolve().parent

" WIP
fun! ExtractFunction()
    norm ^
    let l:offset = col('.') - 1
    exe a:firstline . ',' . a:lastline . 's/\v {' . l:offset . '}/    /'
    exe a:firstline . "norm O\bdef tmp_func():\r    " . '"""<++>"""' . "\r"
    let l:end = a:lastline + 3
    exe a:firstline . ',' . l:end . ' d f'
    norm O    tmp_func()
    norm mm
endfun
