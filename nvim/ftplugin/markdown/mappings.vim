nnoremap <LocalLeader>p :!pandoc % -s -o "%:r".pdf<enter>
nnoremap <LocalLeader>x :!pandoc % -s --pdf-engine=xelatex -V geometry:a4paper -o "%:r".pdf<enter>
nnoremap <LocalLeader>j :!pandoc % -V monofont="JetBrains Mono NL Medium" -V geometry:a4paper --pdf-engine=xelatex -s -o "%:r".pdf<enter>
nnoremap <LocalLeader>v :!zathura "%:r".pdf & disown<enter><enter>
