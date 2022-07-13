# lf.vim

A simple [Lf](https://github.com/gokcehan/lf) wrapper for Vim and Neovim.

## Usage

The command `Lf` opens the Lf file manager inside the Vim native terminal.
Opening a file inside Lf will make it to quit and open the same file inside Vim.

By default, the Vim `cwd` will **NOT** change to the last directory of Lf. This
behaviour can be changed by the variable `g:lf_change_cwd` or, if you want to
change it only once, using the commands `LfChangeCwd` and `LfNoChangeCwd`.

## Settings

Only one variable is provided: `g:lf_change_cwd`, set to 1 to default the `Lf`
command to changing the Vim `cwd` or 0 to default it to not change.
