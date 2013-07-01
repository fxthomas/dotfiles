" Vim syntax file
" Language   : SBT (http://scala-sbt.org/)

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

runtime! syntax/scala.vim
let b:current_syntax = "sbt"
