" shabang
call Iab('#!', '#!/bin/sh<Enter>')

" control structures
call Iab('for', 'for $ in <++><Enter>do<Enter>done<Esc>kkf$a')
call Iab('while', 'while [  ]<Enter>do<Enter>done<Esc>kkf]hi')
call Iab('if', 'if [  ]<Enter>then<Enter>fi<Esc>kkf]hi')
call Iab('elif', 'elif [  ]<Left><Left>')
