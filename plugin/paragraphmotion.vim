" Normally, the { and } motions only match completely empty lines.
" With this plugin, lines that only contain whitespace are also matched.
" URL: https://github.com/dbakker/vim-paragraph-motion
" License: BSD Zero Clause License (0BSD)

if exists('g:loaded_paragraphmotion') || &cp
    finish
endif
let g:loaded_paragraphmotion = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:ParagraphMove(delta, visual, count)
    normal! m'
    if a:visual
        normal! gv
    endif

    let i = 0
    if a:delta > 0  " Forward paragraph motion.
        normal! 0
        while i < a:count
            " First empty or whitespace-only line below a line that contains
            " non-whitespace characters.
            if search('\m[^[:space:]]', 'W') == 0 || search('\m^[[:space:]]*$', 'W') == 0
                call search('\m\%$', 'W')
                return
            endif
            let i += 1
        endwhile
    elseif a:delta < 0  " Backward paragraph motion.
        normal! ^
        while i < a:count
            " First empty or whitespace-only line above a line that contains
            " non-whitespace characters.
            if search('\m[^[:space:]]', 'bcW') == 0 || search('\m^[[:space:]]*$', 'bW') == 0
                call cursor(1, 1)
                return
            endif
            let i += 1
        endwhile
    endif
endfunction

nnoremap <unique> <silent> } :<C-U>call <SID>ParagraphMove( 1, 0, v:count1)<CR>
onoremap <unique> <silent> } :<C-U>call <SID>ParagraphMove( 1, 0, v:count1)<CR>
xnoremap <unique> <silent> } :<C-U>call <SID>ParagraphMove( 1, 1, v:count1)<CR>
nnoremap <unique> <silent> { :<C-U>call <SID>ParagraphMove(-1, 0, v:count1)<CR>
onoremap <unique> <silent> { :<C-U>call <SID>ParagraphMove(-1, 0, v:count1)<CR>
xnoremap <unique> <silent> { :<C-U>call <SID>ParagraphMove(-1, 1, v:count1)<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
