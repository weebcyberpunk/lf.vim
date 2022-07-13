" Location:     autoload/lf.vim

function! lf#AfterCloseLf(change)

    let l:buf_to_close=bufnr('%')
    let l:dir=system('echo "$(cat /tmp/lfvim-lastdir)\n"')
    let l:file=system('echo "$(cat /tmp/lfvim-selection)\n"')
    if a:change == 1
        execute 'cd' l:dir
    endif
    execute 'edit' l:file
    filetype detect " for some reason it didn't run filetype normally
    execute 'bd' l:buf_to_close

endfunction

function! lf#Lf(change)

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
