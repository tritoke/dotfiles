nnoremap <LocalLeader>p :!pandoc % -s -o "%:r".pdf<enter>
nnoremap <LocalLeader>x :!pandoc % -s --pdf-engine=xelatex -o "%:r".pdf<enter>
nnoremap <LocalLeader>j :!pandoc % -V monofont="JetBrains Mono NL Medium" --pdf-engine=xelatex -s -o "%:r".pdf<enter>
nnoremap <LocalLeader>v :!zathura "%:r".pdf & disown<enter><enter>
