" Package manager
execute pathogen#infect()

syntax on
set number
filetype on

set smartindent
set tabstop=8

set expandtab
set smarttab

set shiftwidth=2
set modeline
set ls=2

set clipboard=unnamedplus

hi SpellBad ctermfg=244

autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" Enabling custom file types (e.g. .csv)
:filetype plugin on

" Using '#' as a comment in .dat files
:let g:csv_comment = '#'
hi CSVColumnEven term=bold ctermbg=4 guibg=DarkBlue
hi CSVColumnOdd term=bold ctermbg=5 guibg=DarkMagenta


" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
"
" " IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" " can be called correctly.
" set shellslash
"
" " IMPORTANT: grep will sometimes skip displaying the file name if you
" " search in a singe file. This will confuse Latex-Suite. Set your grep
" " program to always generate a file-name.
set grepprg=grep\ -nH\ $*
"
" " OPTIONAL: This enables automatic indentation as you type.
filetype indent on
"
" " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults
" to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Check python syntax on open
let g:syntastic_check_on_open = 1

