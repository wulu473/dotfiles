syntax on
set number
filetype on
set smartindent
set expandtab
set tabstop=3
set shiftwidth=3
set modeline
set ls=2

hi SpellBad ctermfg=244

:command! -nargs=+ Calc :py print <args>
:py from math import 
