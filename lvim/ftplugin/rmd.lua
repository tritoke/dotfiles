vim.cmd.nnoremap("<LocalLeader>p", [[<cmd>:!echo "rmarkdown::render('<c-r>%', rmarkdown::pdf_document())" \| R --vanilla<enter>]])
vim.cmd.nnoremap("<localleader>v", [[<cmd>:!zathura "%:r".pdf & disown<enter><enter>]])
