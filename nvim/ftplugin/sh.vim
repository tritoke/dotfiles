" shabang
call sab#Iab('#!', '#!/bin/sh<Enter>')

" control structures
call sab#Iab('for', 'for $ in <++><Enter>do<Enter>done<Esc>kkf$s')
call sab#Iab('while', 'while [  ]<Enter>do<Enter>done<Esc>kkf]hi')
call sab#Iab('if', 'if [  ]<Enter>then<Enter>fi<Esc>kkf]hi')
call sab#Iab('elif', 'elif [  ]<Left><Left>')
