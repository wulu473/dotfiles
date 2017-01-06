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

:command! -nargs=+ Calc :py print <args>
:py from math import *

" Enabling custom file types (e.g. .csv)
:filetype plugin on

" Using '#' as a comment in .dat files
:let g:csv_comment = '#'
hi CSVColumnEven term=bold ctermbg=4 guibg=DarkBlue
hi CSVColumnOdd term=bold ctermbg=5 guibg=DarkMagenta

