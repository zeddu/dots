"######################
"###     SKARRO     ###
"######################

"=== basic configuration
syntax on
set number
set ai
set mouse-=a
set backspace=indent,eol,start  " allow backspacing over everything.
"set syntax=whitespace "another way to highlight tabs and spaces

if exists('$TMUX')
    autocmd VimEnter,BufWrite * call system("tmux rename-window ' " . expand("%:t") . " '")
endif

:command! -bar -bang Q quit<bang> " allows quitting vim with :Q (capital q)
":command Q q

"=== tab settings
"set tabstop=4
"set expandtab
"set softtabstop=4


set listchars=tab:→\ ,space:·

"set listchars=eol:¬
"set listchars=tab:→\ ,space:·,eol:$
set list

"set listchars=tab:▸ 
"set listchars+=space:.



"=== colors
"set cursorline
"highlight CursorLine cterm=NONE ctermbg=darkgray  ctermfg=white 

"set colorcolumn=81
"highlight ColorColumn ctermbg=red

colorscheme default
highlight Comment ctermfg=green

"highlight NonText ctermfg=gold
highlight SpecialKey ctermfg=darkgray

highlight EndOfBuffer ctermfg=black ctermbg=black



