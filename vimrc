syntax on
set number
filetype on

set smartindent
set tabstop=3

set expandtab
set smarttab

set shiftwidth=3
set modeline
set ls=2

set clipboard=unnamedplus

hi SpellBad ctermfg=244

:command! -nargs=+ Calc :py print <args>
:py from math import *

" Enabling custom file types (e.g. .csv)
:filetype plugin on

" Using '#' as a comment in .dat files
:let g:csv_comment = '#'

