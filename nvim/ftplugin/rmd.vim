nnoremap <LocalLeader>p :!echo "rmarkdown::render('<c-r>%', rmarkdown::pdf_document())" \| R --vanilla<enter>
nnoremap <LocalLeader>v :!zathura "%:r".pdf & disown<enter><enter>
