
let g:grepcustomprg="grep\\ -rIn"

function! Grep(args)

    exec "tabe"

    if empty(a:args)
        let l:grepargs = expand("<cword>")
    else
        let l:grepargs = a:args . join(a:000, ' ')
    end
    echom l:grepargs

    let grepprg_bak=&grepprg
    exec "set grepprg=" . g:grepcustomprg
    silent execute "grep " . escape(l:grepargs, '|#%')
    let s:close_cmd = ':cclose<CR>'
    botright copen
    let &grepprg=grepprg_bak

    call <SID>apply_maps()

    let @/ = matchstr(l:grepargs, "\\v(-)\@<!(\<)\@<=\\w+|['\"]\\zs.{-}\\ze['\"]")
    call feedkeys(":let &l:hlsearch=1 \| echo \<CR>", "n")

    exec "redraw!"

endfunction


function! GrepFromSearch(args)
    let search = getreg('/')
    call Grep('"' . search . '" ' . a:args)
endfunction

let g:grep_mappings = {
      \ "t": "<C-W><CR><C-W>T",
      \ "T": "<C-W><CR><C-W>TgT<C-W>j",
      \ "h": "<C-W><CR><C-W>K",
      \ "v": "<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t"}

function! s:apply_maps()
    let g:grep_mappings.q = s:close_cmd

    if &ft == "qf"
        for key_map in items(g:grep_mappings)
            execute printf("nnoremap <buffer> <silent> %s %s", get(key_map, 0), get(key_map, 1) . s:close_cmd)
        endfor
        execute "nnoremap <buffer> <silent> <CR> <CR>" . s:close_cmd
    endif

    execute "nnoremap <buffer> <silent> j j<CR><C-W><C-W>"
    execute "nnoremap <buffer> <silent> k k<CR><C-W><C-W>"

endfunction


command! -nargs=* -complete=file Grep call Grep(<q-args>)
command! -nargs=* -complete=file GrepFromSearch call GrepFromSearch(<q-args>)
