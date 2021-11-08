"######################
"###     SKARRO     ###
"######################

"=== basic configuration ===
syntax on
set number
set ai
set ruler
set hlsearch
set mouse-=a

au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['c', 'css', 'sass', 'xml', 'html', 'bash']

set backspace=indent,eol,start  " allow backspacing over everything.

nnoremap <C-l> :nohl<CR><C-L> "in addition to redraw (ctrl+l), also clear search highlight

if exists('$TMUX')
    autocmd VimEnter,BufWrite * call system("tmux rename-window ' " . expand("%:t") . " '")
endif

:command! -bar -bang Q quit<bang> " allows quitting vim with :Q (capital q)
":command Q q "seems to be an alternative



"=== tab settings === 
set tabstop=4
set shiftwidth=4
"set expandtab
"set softtabstop=4

set listchars=tab:→\ ,space:·
"set listchars=tab:→\ ,space:·,eol:$
set list



"=== colors ===
colorscheme default
hi MatchParen cterm=none ctermbg=green ctermfg=red
highlight Comment ctermfg=green
highlight Search ctermbg=white ctermfg=red
highlight SpecialKey ctermfg=darkgray
highlight EndOfBuffer ctermfg=black ctermbg=black
"highlight NonText ctermfg=red

"set cursorline
"highlight CursorLine cterm=NONE ctermbg=darkgray  ctermfg=white 

