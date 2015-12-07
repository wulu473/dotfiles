" Vim syntax file
" Language: LSC-AMR settings file
" Maintainer: Lukas Wutschitz
" Latest Revision: 25 May 2015

if exists("b:current_syntax")
	finish
endif

syn region lscamrComment start="/\*" end="\*/" contains=@Spell
highlight link lscamrComment Comment

syn match lscamrLineComment "\/\/.*" contains=@Spell
highlight link lscamrLineComment Comment

syn match lscamrConstant "{.*}" 
highlight link lscamrConstant Constant

let b:current_syntax = "lscamr"

