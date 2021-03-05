" Based on: http://stackoverflow.com/questions/1853025/make-and-ignore-lines-containing-only-whitespace

if exists("g:loaded_paragraphmotion") || &cp
  finish
endif
let g:loaded_paragraphmotion=1

function! ParagraphMove(delta, visual, count)
    normal! m'
    if a:visual
        normal! gv
    endif

    let i = 0
    if a:delta > 0
        " Forward paragraph motion.
        normal! 0
        while i < a:count
            " First empty or whitespace-only line below a line that contains
            " non-whitespace characters.
            if search('\m\S', 'W') == 0 || search('\m^\s*$', 'W') == 0
                call search('\m\%$', 'W')
                return
            endif
            let i += 1
        endwhile
    elseif a:delta < 0
        " Backward paragraph motion.
        normal! ^
        while i < a:count
            " First empty or whitespace-only line above a line that contains
            " non-whitespace characters.
            if search('\m\S', 'bcW') == 0 || search('\m^\s*$', 'bW') == 0
                call cursor(1, 1)
                return
            endif
            let i += 1
        endwhile
    endif
endfunction

nnoremap <unique> <silent> } :<C-U>call ParagraphMove( 1, 0, v:count1)<CR>
onoremap <unique> <silent> } :<C-U>call ParagraphMove( 1, 0, v:count1)<CR>
xnoremap <unique> <silent> } :<C-U>call ParagraphMove( 1, 1, v:count1)<CR>
nnoremap <unique> <silent> { :<C-U>call ParagraphMove(-1, 0, v:count1)<CR>
onoremap <unique> <silent> { :<C-U>call ParagraphMove(-1, 0, v:count1)<CR>
xnoremap <unique> <silent> { :<C-U>call ParagraphMove(-1, 1, v:count1)<CR>
