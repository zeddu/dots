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
  Plug 'airblade/vim-rooter'
  Plug 'justinmk/vim-sneak'
  Plug 'unblevable/quick-scope'

  "tpope/commentary.vim
  "terryma/vim-multiple-cursors
  "tpope/vim-surround
  "easymotion/vim-easymotion
   "rhysd/clever-f.vim"
   "rbong/vim-crystalline"
   "lazygit"
   "hlyank"
   "andymass/vim-match-up
   "tommcdo/exchange.vim
   "preservim/vimux

  
  "Plug 'kaicataldo/material.vim', { 'branch': 'main' }
  "Plug 'Xuyuanp/nerdtree-git-plugin'
  "Plug 'airblade/vim-gitgutter'
  
  "Plug 'vim-airline/vim-airline'
  "Plug 'vim-airline/vim-airline-themes'

   Plug 'mengelbrecht/lightline-bufferline'
   Plug 'itchyny/lightline.vim'
call plug#end()
let g:indentLine_enabled = 1
"###################################################
"###                PLUGIN CONFIGS               ###
"###################################################


"# For airline
set noshowmode
set laststatus=2

"# For sneak
let g:lightline = {'colorscheme': 'powerlineish',}

let g:sneak#label = 1

" case insensitive sneak
let g:sneak#use_ic_scs = 1

" immediately move to the next instance of search, if you move the cursor sneak is back to default behavior
let g:sneak#s_next = 1

" remap so I can use , and ; with f and t
map gS <Plug>Sneak_,
map gs <Plug>Sneak_;

" Change the colors
highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow

" Cool prompts
"let g:sneak#prompt = '🕵'
let g:sneak#prompt = '🔎'

"# For quickscope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']



let g:qs_max_chars=150

"###################################################
"###                MAIN BINDINGS                ###
"###################################################

let mapleader = " "
set wildmenu
set wildmode=list:full

command! -nargs=1 -complete=file E tabnew <args>

" Split window
nmap oo :vsplit<Return><C-w>w

" Resize window
nmap <C-right> <C-w><
nmap <C-left> <C-w>>
nmap <C-up> <C-w>+
nmap <C-down> <C-w>-

nnoremap <C-w>a  <C-w>h
nnoremap <C-w>d <C-w>l

"# Hold visual select when indenting
vnoremap < <gv
vnoremap > >gv

"# Hold pasted in register after pasting over visually selected block (usually takes pasted over text in to reg)
"vnoremap p _dP

noremap <silent> <C-e> <C-^>

"# Move text up and down
noremap <silent> <C-j> :move +1<CR>
noremap <silent> <C-k> :move -2<CR>
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


noremap <silent> J jj
noremap <silent> K kk

inoremap jj <esc>

noremap <silent> <leader>hl :set hlsearch!<CR>
noremap <silent> <leader><leader> :noh<CR>

nnoremap <leader>q :q<CR>
nnoremap <leader>qq :q!<CR>

nnoremap <leader>m :TagbarToggle<CR>

nnoremap <leader>s :AnyJump<CR>
xnoremap <leader>s :AnyJumpVisual<CR>
nnoremap <leader>ss :AnyJumpBack<CR>
let g:any_jump_disable_default_keybindings = 1

command! Reload execute "source ~/.vimrc"
command! Config execute ":e $MYVIMRC"

"nnoremap <silent> <leader>p :NERDTreeToggle<CR><bar> :vertical resize 25<CR>
"nnoremap <silent> <leader>o :NERDTreeFind<CR>
nnoremap <silent> <expr> <leader>o g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

vmap <C-\> <plug>NERDCommenterToggle
nmap <C-\> <plug>NERDCommenterToggle
vmap <leader>\ <plug>NERDCommenterToggle
nmap <leader>\ <plug>NERDCommenterToggle

nnoremap <silent> <leader>h  :wincmd h<CR>
nnoremap <silent> <leader>j :wincmd j<CR>
nnoremap <silent> <leader>k :wincmd k<CR>
nnoremap <silent> <leader>l :wincmd l<CR>

nnoremap <leader>r :Find!<CR>

" For some reason doesnt work when using 'Find Rg' as it should, works when giving own new name aka - 'Find'
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
  
"command! -bang -nargs=* Rg! call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smartcase -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

command! -bang F42 call fzf#vim#files('~/42', <bang>0)

nmap // :BLines!<CR>
nmap ?? :Find!<CR>
nmap cm :Commands<CR>
"nmap cm :Commits<CR>

nnoremap <leader>t :tabnew<CR>
nnoremap <leader>d :Files<CR>

let g:ctrlp_map = '<leader>g'
let g:ctrlp_cmd = 'CtrlP'


"# set get root dir for ripgrep
if executable('rg')
	let g:rg_derive_root='true'
endif

nnoremap <leader>t :tabnew<CR>
nnoremap <leader>d :Files!<CR>

let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlP'

nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt



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
set timeoutlen=250 
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
set hidden
set signcolumn=yes


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

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]
let g:startify_change_to_vcs_root = 1
let g:startify_custom_header = [
\ '                   ',
\ '    __  __(_)_ _   ',
\ '    | |/ / /  ` \  ',
\ '    |___/_/_/_/_/  ',
\]

let g:startify_bookmarks = [
            \ { 'v': '~/.vimrc' },
            \ { 'b': '~/.bashrc' },
            \ { 'z': '~/.zshrc' },
            \ ]
let g:startify_files_number        = 5


highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=196 cterm=underline
highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=141 cterm=underline

command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
