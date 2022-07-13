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
    else
        bp
    endif
    execute 'bd' l:buf_to_close

endfunction

function! lf#Lf(change)

    " we need to be sure that theese files aren't there
    call system('rm /tmp/lfvim-lastdir /tmp/lfvim-selection')
    term lf -last-dir-path /tmp/lfvim-lastdir -selection-path /tmp/lfvim-selection

    " we need to make this because a:change get out of scope inside the autocmd
    " on other programming languages this would look extremely awful but on Vim
    " Script it is what it is
    if a:change == 1
        autocmd TermClose <buffer> call lf#AfterCloseLf(1)
    elseif a:change == 0
        autocmd TermClose <buffer> call lf#AfterCloseLf(0)
    endif

    normal a

endfunction
