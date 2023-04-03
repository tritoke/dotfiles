" if in the report folder always compile report.tex
if expand('%:ph') =~ 'comp30040/report'
  nnoremap <LocalLeader>w :!texcount *.tex \| grep Total -A1 \| grep -o '[0-9]\+'<enter>
  nnoremap <LocalLeader>p :!latexrun --latex-args="-shell-escape" --bibtex-cmd=biber report.tex<enter>
  nnoremap <LocalLeader>x :!latexrun --latex-args="-shell-escape" --bibtex-cmd=biber report.tex --latex-cmd xelatex<enter>
  nnoremap <LocalLeader>v :!zathura report.pdf & disown<enter><enter>
else
  nnoremap <LocalLeader>w :!texcount % \| grep Total -A1 \| grep -o '[0-9]\+'<enter>
  nnoremap <LocalLeader>p :!latexrun --latex-args="-shell-escape" %<enter>
  nnoremap <LocalLeader>x :!latexrun --latex-args="-shell-escape" % --latex-cmd xelatex<enter>
  nnoremap <LocalLeader>v :!zathura "%:r".pdf & disown<enter><enter>
endif

" tell gnuplot to go actually make the tables... latexrun doesn't handle this well
nnoremap <LocalLeader>g :!cd latex.out && gnuplot *.gnuplot<enter>
