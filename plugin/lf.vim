" Title:        lf.vim
" Description:  Stupid Lf wrapper for Vim
" Last Change:  13 July 2022
" Mainteiner:   GG https://github.com/weebcyberpunk
" Location:     plugin/lf.vim

if exists('g:autoloaded_lf')
    finish
endif

let g:autoloaded_lf = 1

" Section:       config

if !exists('g:lf_change_cwd')
    let g:lf_change_cwd=0
endif

" Section:      commands

command! Lf call lf#Lf(g:lf_change_cwd)
command! LfNoChangeCwd call lf#Lf(0)
command! LfChangeCwd call lf#Lf(1)
