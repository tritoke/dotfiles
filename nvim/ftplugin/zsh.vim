" shabang
call Iab('#!', '#!/bin/zsh<Enter>')

" control structures
call Iab('for', 'for $ in <++><Enter>do<Enter>done<Esc>kkf$a')
call Iab('while', 'while [ x ]<Enter>do<Enter>done<Esc>kkfxs')
call Iab('if', 'if [ x ]<Enter>then<Enter><++><Enter>fi<Esc>3kfxs')
call Iab('elif', 'elif [ x ]<Enter>then<Enter><++><Esc>kkfxs')
