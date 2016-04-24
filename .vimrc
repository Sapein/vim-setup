syntax on "Turns Sytax Hilighting on
set nu "Turns on Line Numbers
colorscheme desert "Sets colorscheme to the more readable desert
filetype plugin indent on "Sets filetype plugin indent to on
set background=dark "Sets background to dark
set tabstop=4 "Sets tab stop to 4
set softtabstop=4 "Sets spacing to 4
set shiftwidth=4 "Sets shift width to 4
set expandtab "Sets tab to be spaces

command Desert colorscheme desert
command Zen colorscheme zenburn
command SolarD colorscheme solarized
command Minetest !$(nohup minetest --go --name chanku --world /home/chanku/minetest/worlds/testing_world 2&>1 >> /home/chanku/minetest/bin/development_debug.log &)

command MinetestMenu !$(nohup minetest 2&>1 >> /home/chanku/minetest/bin/development_debug.log &)

let g:solarized_termcolors=256
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2
execute pathogen#infect()
