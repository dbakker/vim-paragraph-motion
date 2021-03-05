" Based on: http://stackoverflow.com/questions/1853025/make-and-ignore-lines-containing-only-whitespace

if exists("g:loaded_paragraphmotion") || &cp
  finish
endif
let g:loaded_paragraphmotion=1

function! ParagraphMove(delta, visual, count)
    normal m'
    if a:visual
        normal gv
    endif

    let i = 0
    if a:delta > 0
        normal! 0
        while i < a:count
            " First empty or whitespace-only line below a line that contains
            " non-whitespace characters.
            let pos1 = search('\m\S', 'W')
            let pos2 = search('\m^\s*$', 'W')
            if pos1 == 0 || pos2 == 0
                let pos = search('\m\%$', 'W')
            endif
            let i += 1
        endwhile
    elseif a:delta < 0
        normal! ^
        while i < a:count
            " First empty or whitespace-only line above a line that contains
            " non-whitespace characters.
            let pos1 = search('\m\S', 'bcW')
            let pos2 = search('\m^\s*$', 'bW')
            if pos1 == 0 || pos2 == 0
                let pos = search('\m\%^', 'bW')
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
