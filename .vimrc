"###################################################
"###              PLUGINS (VIM PLUG)             ###
"###################################################

call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'jremmen/vim-ripgrep'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'ryanoasis/vim-devicons'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'scrooloose/nerdcommenter'
  Plug 'ap/vim-css-color'
  Plug 'jiangmiao/auto-pairs'
  Plug 'farmergreg/vim-lastplace'
  Plug 'mhinz/vim-startify'
  Plug 'pechorin/any-jump.vim'
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  Plug 'majutsushi/tagbar'

  "Plug 'kaicataldo/material.vim', { 'branch': 'main' }
  "Plug 'Xuyuanp/nerdtree-git-plugin'
  "Plug 'airblade/vim-gitgutter'
  "Plug 'vim-airline/vim-airline'
  "Plug 'vim-airline/vim-airline-themes'
  
call plug#end()


"###################################################
"###                MAIN BINDINGS                ###
"###################################################

let mapleader = " "

nnoremap <leader>q :q<CR>

nnoremap <leader>m :TagbarToggle<CR>

nnoremap <leader>s :AnyJump<CR>
xnoremap <leader>s :AnyJumpVisual<CR>
nnoremap <leader>ss :AnyJumpBack<CR>

command! Reload execute "source ~/.vimrc"
command! Config execute ":e $MYVIMRC"

"nnoremap <silent><leader>p :NERDTreeToggle<CR><bar> :vertical resize 25<CR>
"nnoremap <silent><leader>o :NERDTreeFind<CR>
nnoremap <silent> <expr> <leader>o g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

vmap <C-\> <plug>NERDCommenterToggle
nmap <C-\> <plug>NERDCommenterToggle
vmap <leader>.. <plug>NERDCommenterToggle
nmap <leader>.. <plug>NERDCommenterToggle

nnoremap <leader>h  :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

nnoremap <leader>f :Rg<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nnoremap <leader>t :tabnew<CR>
nnoremap <leader>d :Files<CR>

let g:ctrlp_map = '<leader>g'
let g:ctrlp_cmd = 'CtrlP'

nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt

"# allows to ripgrep, then ctrl+t to open in new tab
nnoremap <C-t> <C-w><CR><C-w>T
augroup quickfix_tab | au!
    au filetype qf nnoremap <buffer> <C-t> <C-w><CR><C-w>T
augroup END

"# set get root dir for ripgrep
if executable('rg')
	let g:rg_derive_root='true'
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()


"###################################################
"###           ADDITIONAL FUNCTIONALITY          ###
"###################################################

"# Markdown support
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['c', 'css', 'sass', 'xml', 'html', 'bash']

"# ctrl+y yanks to system clipboard using xclip, ctrl+p pastes
vnoremap <C-y> :'<,'>w !xclip -i -sel c<Cr><Cr>
nmap <C-p> :-1r !xclip -o -sel clip<CR><CR>

"# In addition to redraw (ctrl+l), also clear search highlight (similar to bash ctrl+l for clear)
nnoremap <C-l> :nohl<CR><C-L> 

"# Timouts seems to be needed for instant effects with tmux
set timeout
set timeoutlen=1000 
set ttimeoutlen=0

"# Picks up window name for tmux
if exists('$TMUX')
autocmd VimEnter,BufWrite * call system("tmux rename-window ' " . expand("%:t") . " '")
autocmd VimLeave * call system("tmux rename-window bash")
endif

"# allows quitting vim with :Q (capital q), bang expands to !. Second seems to be an alternative
:command! -bar -bang Q quit<bang> 
":command Q q 

"# allow ctrl+s in normal and insert mode to save
nmap <c-s> :update<CR>
imap <c-s> <Esc>:update<CR>


"###################################################
"###                  MAIN SETS                  ###
"###################################################

syntax on
set number
set ai
set ruler
set hlsearch "highlight search result, opposite nohlsearch
set mouse=a
set tabstop=4
set shiftwidth=4
set listchars=tab:→\ ,space:·
set list
set scrolloff=8 "x amount of lines to block from top/bottom before scroll
set relativenumber "show lines numbers are relative numbers
set nu " show current line as actual line number
set noswapfile
set incsearch
set cursorline
set showtabline=2
set encoding=utf-8

"# Set bottom statusbar, 2 = always show filename (shifts status up 1 line above insert/view etc)
"set laststatus=2

"# Allow backspacing over everything.
set backspace=indent,eol,start  

"###################################################
"###                  APPEARANCE                 ###
"###################################################

"# Use terminal set colors
"if (has("termguicolors"))
"set termguicolors
"endif

set t_Co=256
set term=xterm-256color
let g:gruvbox_contrast_dark='hard' "for gruvbox theme
set background=dark 
colorscheme gruvbox

"# set colors for tabs
"highlight TabLineFill ctermfg=black ctermbg=red
"highlight TabLine ctermfg=gray ctermbg=black
"highlight TabLineSel ctermfg=Red ctermbg=Yellow
highlight TabLineSel ctermfg=green

"# hides the "~" on empty lines (terminal bg color needs to match)
highlight EndOfBuffer ctermfg=black 

"# Search match colors (only works when using VIM default colorschemes)
"hi MatchParen cterm=none ctermbg=green ctermfg=red
"highlight Search ctermbg=white ctermfg=red

"# Search match colors (only works when using VIM default colorschemes)
"highlight SpecialKey ctermfg=darkgray
"highlight NonText ctermfg=red

"# Set comment color (uses green color set by terminal)
"highlight Comment ctermfg=green
