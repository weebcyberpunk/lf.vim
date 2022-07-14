" Location:     autoload/lf.vim

function! lf#AfterCloseLf(change)

    let l:buf_to_close=bufnr('%')
    let l:dir=system('cat /tmp/lfvim-lastdir 2> /dev/null')
    let l:file=system('cat /tmp/lfvim-selection 2> /dev/null')
    
    if a:change == 1 && !empty(l:dir)
        execute 'cd' l:dir
    endif
    if !empty(l:file)
        execute 'edit' l:file
        filetype detect " for some reason it didn't run filetype normally
    endif

    " make sure to close lf buffer
    if bufexists(l:buf_to_close)
        execute 'bd!' l:buf_to_close
    endif

endfunction

function! lf#Lf(change, path='')

    " we need to be sure that theese files aren't there
    call system('rm /tmp/lfvim-lastdir /tmp/lfvim-selection')
    execute 'term' 'lf -last-dir-path /tmp/lfvim-lastdir -selection-path /tmp/lfvim-selection' a:path

    " make sure lf buffer will be deleted on close
    setlocal bufhidden=wipe

    " we need to make this because a:change get out of scope inside the autocmd
    execute 'autocmd TermClose <buffer> call lf#AfterCloseLf('a:change ')'

    normal a

    " deletes that buffer that gets created when trying to edit a directory
    if bufexists(a:path)
        execute 'bd!' bufnr(a:path)
    endif

endfunction

function! lf#CheckDir(dir)

    if !isdirectory(a:dir)
        return
    endif
    
    call lf#Lf(g:lf_change_cwd, a:dir)

endfunction
