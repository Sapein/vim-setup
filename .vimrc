syntax on "Turns Sytax Hilighting on
set nu "Turns on Line Numbers
colorscheme desert "Sets colorscheme to the more readable desert
filetype plugin indent on "Sets filetype plugin indent to on
set background=dark "Sets background to dark
set tabstop=4 "Sets tab stop to 4
set softtabstop=4 "Sets spacing to 4
set shiftwidth=4 "Sets shift width to 4
set expandtab "Sets tab to be spaces
let mapleader=","

" Custom Variables
let g:sleepvariable = 5 "This variable exists only for the Pmakess command, it is the number of seconds to have the shell sleep
let g:make_command = "/bin/sh -c make"

" Colorscheme stuff
command Desert colorscheme desert
command Zen set background=dark | colorscheme zenburn
command SolarD set background=dark | colorscheme solarized

" Asyncronous Make Section
"
" This begins the section on Asyncronous Make, this should probably
"  be split into it's own package/module at some point.
"
" This merely creates an Asyncronous Make command and the relevant
"  functions for it. It can start, and stop a Make command, but can
"  only run one Make command at a time.
"
" All new functions are documented as well

" Function - Async_Make_Start
"  Arguments - Variable (up to 20)
"   Arg 1: Makefile Name
"   Arg 2: Make options and targets
"  Returns - Nothing
"
"  It Checks and sees if a make_job is running, if it is it errors
"   otherwise it just starts a new one. All Output it piped to the
"   buffer 'make_output'.
"WARNING: Arguments 3-20 are currently ignored (to be fixed)
"TODO - Update to allow for usage of multiple args
function Async_Make_Start(...)
    if exists("g:make_job") && job_status(g:make_job) ==? "run"
        echoerr 'Make is already running!'
        exe "normal \<Esc>"
    else
        let l:make_command = g:make_command

        if a:0 <= 0
            let l:make_file = ""
            let l:make_args = ""
        elseif a:0 == 1
            let l:make_files = "-f ". a:1
            let l:make_args = ""
        elseif a:0 >= 2
            let l:make_files = "-f ". a:1
            let l:make_args = a:2
        endif
        if strlen(l:make_file) <= 0
            let l:make_file = ""
        endif
        if strlen(l:make_file) <= 0
            let l:make_args = ""
        endif
        let l:make_command .= " " . l:make_file
        let l:make_command .= " " . l:make_args
        echom l:make_command
        if bufexists('make_output')
            let l:buff_num = bufnr('make_output')
            try
                let l:win_name = win_findbuf(l:buff_num)[0]
                call win_gotoid(l:win_name)
                wincmd c
                wincmd p
            catch E684
                try
                    bdelete! make_output
                catch E94
                    "Do nothing
                endtry
            endtry
        endif
        new make_output
        setlocal buftype=nofile bufhidden=hide noswapfile
        wincmd p
        let l:out_buff = bufnr('make_output')
        let g:make_job = job_start(l:make_command, {'out_io': 'buffer',
                    \  'out_buf': l:out_buff,
                    \  'out_modifiable': 0,
                    \  'err_io': 'buffer',
                    \  'err_buf': l:out_buff,
                    \  'err_modifiable': 0,
                    \  'in_io': 'null'})
    endif
endfunction

" Function - Async_Make_Stop
"  Arguments - Variable (up to 20)
"   Arg 1: Kill Method (Default is term)
"  Returns - Nothing
"
"
"  It Checks and sees if a make job is running, if not it errors
"   othewise it kills the currently running one. The command buffer
"    'make_output' is updated to include a notice the function has
"     been killed
"NOTE: Arguments 2-20 are ignored. This is on Purpose
function Async_Make_Stop(...)
    if !exists("g:make_job")
        echoerr 'Make is not running!'
        exe "normal \<Esc>"
    else
        if a:0 <= 0
            let l:method = "term"
        elseif a:0 >= 0
            let l:method = a:1
        endif
        let l:buff_num = ch_getbufnr(g:make_job, "err")
        try
            let l:win_name = win_findbuf(l:buff_num)[0]
            call win_gotoid(l:win_name)
            setlocal ma
            call append(line('$'), 'Make Stopped!')
            setlocal noma
            wincmd p
        catch E684
            echoerr 'Buffer Window Not found!'
            exe "normal \<Esc>"
        endtry
        call job_stop(g:make_job, 'l:method')
        unlet g:make_job
    endif
endfunction

" The commands for the Asyncronous Make, along with something to kill it
command -nargs=* Make call Async_Make_Start(<f-args>)
command -nargs=* MakeK call Async_Make_Stop(<f-args>)

" End of Asyncronous Make Area

" Setup binary editing
augroup binaryfile
    autocmd!
    au BufRead,BufNewFile *.bin set filetype=binary
    autocmd FileType binary nmap ,h :%!xxd<enter>
    autocmd FileType binary nmap ,y :%!xxd -r <enter>
    autocmd FileType binary nmap ,n :%!xxd -p<enter>
    autocmd FileType binary nmap ,m :%!xxd -p -r<enter>
augroup END


" Set termcolors, airline stuff, and laststatus
let g:solarized_termcolors=256
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2

" Change Colorscheme to Zen
Zen


" Start Pathogen
execute pathogen#infect()

let g:rust_fold = 1
let g:is_posix = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
nmap <F8> :TagbarToggle<CR>
set foldmethod=syntax
