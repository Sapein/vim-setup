syntax on "Turns Sytax Hilighting on
set nu "Turns on Line Numbers
colorscheme desert "Sets colorscheme to the more readable desert
filetype plugin indent on "Sets filetype plugin indent to on
set background=dark "Sets background to dark
set tabstop=4 "Sets tab stop to 4
set softtabstop=4 "Sets spacing to 4
set shiftwidth=4 "Sets shift width to 4
set expandtab "Sets tab to be spaces

"Colorscheme stuff
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
g:feel_command = "python3 /home/chanku/pygames/frozen-earth-engine/src/feel.py"

"set termcolors, airline stuff, laststatus and start pathogen
let g:solarized_termcolors=256
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2
execute pathogen#infect()

