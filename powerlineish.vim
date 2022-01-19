" =============================================================================
" Filename: autoload/lightline/colorscheme/powerlineish.vim
" Author: itchyny
" License: MIT License
" Last Change: 2019/06/12 18:47:00.
" =============================================================================

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ ['black', 'brightgreen', 'bold'], ['white', 'gray0'] ]
let s:p.normal.right = [ ['gray10', 'gray2'], ['white', 'gray1'], ['white', 'gray0'] ]
let s:p.inactive.right = [ ['gray1', 'gray5'], ['gray4', 'gray1'], ['gray4', 'gray0'] ]
let s:p.inactive.left = s:p.inactive.right[1:]
let s:p.insert.left = [ ['black', '#00ff00', 'bold'], ['black', 'brightestorange'] ]
let s:p.insert.right = [ [ 'gray10', 'gray2' ], [ 'white', 'gray1' ], [ 'white', 'gray0' ] ]
let s:p.replace.left = [ ['white', 'brightred', 'bold'], ['white', 'gray0'] ]
let s:p.visual.left = [ ['black', 'brightestorange', 'bold'], ['white', 'gray0'] ]
let s:p.normal.middle = [ [ 'white', 'gray0' ] ]
let s:p.insert.middle = [ [ 'black', 'brightestorange' ] ]
let s:p.replace.middle = s:p.normal.middle
let s:p.replace.right = s:p.normal.right
let s:p.tabline.left = [ [ 'gray3', 'gray0' ] ]
let s:p.tabline.tabsel = [ [ '#00ff00', 'gray2' ] ]
let s:p.tabline.middle = [ [ 'gray3', 'gray0' ] ]
let s:p.tabline.right = [ [ 'red', 'gray1' ] ]
let s:p.normal.error = [ [ 'gray9', 'brightestred' ] ]
let s:p.normal.warning = [ [ 'gray1', 'yellow' ] ]

let g:lightline#colorscheme#powerlineish#palette = lightline#colorscheme#fill(s:p)
