syntax on "Turns Sytax Hilighting on
set nu "Turns on Line Numbers
colorscheme desert "Sets colorscheme to the more readable desert
filetype plugin indent on "Sets filetype plugin indent to on
set background=dark "Sets background to dark
set tabstop=4 "Sets tab stop to 4
set softtabstop=4 "Sets spacing to 4
set shiftwidth=4 "Sets shift width to 4
set expandtab "Sets tab to be spaces

" Custom Variables
let g:sleepvariable = 5 "This variable exists only for the Pmakess command, it is the number of seconds to have the shell sleep

" Colorscheme stuff
command Desert colorscheme desert
command Zen colorscheme zenburn
command SolarD colorscheme solarized

"Minetest Stuff
command Minetest silent !$(nohup minetest --go --name chanku --world /home/chanku/minetest/worlds/testing_world 2&>1 >> /home/chanku/minetest/bin/development_debug.log &)
command MinetestMenu silent !$(nohup minetest 2&>1 >> /home/chanku/minetest/bin/development_debug.log &)

" This would setup FEEL prior to the Feel plugin existing. 
" autocmd BufNewFile,BufRead *.feel set filetype=lisp
" autocmd FileType lisp let maplocalleader= '\' 
autocmd FileType feel let maplocalleader= '\'
let g:feel_command = "python3 /home/chanku/pygames/frozen-earth-engine/src/feel.py"

" This sets up special keybinds and commands for Python3 Files
"  Pmake allows me to run the python command directly from Vim on the current
"  buffer. Pmakes does the same thing, but in the command line (Pmakess is a
"   hack to allow you some time to read output before it returns to allow you to
"   input more information.). 
"  These commands do require the file to be saved beforehand.
"  Please note these will only exist when you are editing a .py file or your
"   filetype is set to python.
"  (NOTE: Pmake = Python Make, Pmakes = Python Make Shell, Pmakess = Python Make Sleep Shell.) 
autocmd FileType python command! Pmake py3file %
autocmd FileType python command! Pmakes !python3 %
autocmd FileType python command! Pmakess execute '!python3 %; sleep ' . sleepvariable

" These are the keybinds mentioned in the above comment, these allow an easy
"  way to execute the commands above. In the imaps the binding <C-r> will enter
"  return before you can see any output so <C-f> is suggested as an
"  alternative.
" Please note that <C-r> and <C-e> will take over the vim session and will
"  require Vim (and potentially your terminal session) to be restarted if there
"  is an endless loop.
autocmd FileType python nmap ,m :Pmake<enter>
autocmd FileType python nmap ,n :Pmakes<enter>
autocmd FileType python imap <C-r> <esc>:Pmake<enter>a
autocmd FileType python imap <C-e> <esc>:Pmake<enter>
autocmd FileType python imap <C-f> <esc>:Pmakess<enter>a
autocmd FileType python imap <C-d> <esc>:Pmakes<enter>

" Set termcolors, airline stuff, and laststatus
let g:solarized_termcolors=256
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2

" Change Colorscheme to Zen
Zen

" Start Pathogen
execute pathogen#infect()
