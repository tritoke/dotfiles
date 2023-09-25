if expand('%:ph') =~ '/cv/'
  nnoremap <LocalLeader>p :!latexrun cv.tex<enter>
  nnoremap <LocalLeader>v :!zathura cv.pdf & disown<enter><enter>
elseif expand('%:ph') =~ '/cover_letter/'
  nnoremap <LocalLeader>p :!latexrun cover_letter.tex<enter>
  nnoremap <LocalLeader>v :!zathura cover_letter.pdf & disown<enter><enter>
else
  nnoremap <LocalLeader>v :!zathura report.pdf & disown<enter><enter>
  nnoremap <LocalLeader>w :!texcount % \| grep Total -A1 \| grep -o '[0-9]\+'<enter>
  nnoremap <LocalLeader>p :!latexrun --latex-args="-shell-escape" --bibtex-cmd=biber %<enter>
  nnoremap <LocalLeader>x :!latexrun --latex-args="-shell-escape" --bibtex-cmd=biber % --latex-cmd xelatex<enter>
  nnoremap <LocalLeader>v :!zathura "%:r".pdf & disown<enter><enter>
endif

" tell gnuplot to go actually make the tables... latexrun doesn't handle this well
nnoremap <LocalLeader>g :!cd latex.out && gnuplot *.gnuplot<enter>
