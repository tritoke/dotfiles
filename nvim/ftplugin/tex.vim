" if in the report folder always compile report.tex
if expand('%:ph') =~ 'comp30040/report'
  nnoremap <LocalLeader>w :!detex report.tex \| wc -w<enter>
  nnoremap <LocalLeader>p :!latexrun report.tex<enter>
  nnoremap <LocalLeader>x :!latexrun report.tex --latex-cmd xelatex<enter>
  nnoremap <LocalLeader>v :!zathura report.pdf & disown<enter><enter>
else
  nnoremap <LocalLeader>w :!detex % \| wc -w<enter>
  nnoremap <LocalLeader>p :!latexrun %<enter>
  nnoremap <LocalLeader>x :!latexrun % --latex-cmd xelatex<enter>
  nnoremap <LocalLeader>v :!zathura "%:r".pdf & disown<enter><enter>
endif

