" shabang
call sab#Iab('#!', '#!/bin/zsh<Enter>')

" control structures
call sab#Iab('for', 'for $ in <++><Enter>do<Enter>done<Esc>kkf$a')
call sab#Iab('while', 'while [ x ]<Enter>do<Enter>done<Esc>kkfxs')
call sab#Iab('if', 'if [ x ]<Enter>then<Enter><++><Enter>fi<Esc>3kfxs')
call sab#Iab('elif', 'elif [ x ]<Enter>then<Enter><++><Esc>kkfxs')
