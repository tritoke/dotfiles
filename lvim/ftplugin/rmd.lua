vim.api.nvim_set_keymap("n", "<LocalLeader>p", [[<cmd>:!echo "rmarkdown::render('<c-r>%', rmarkdown::pdf_document())" \| R --vanilla<enter>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<localleader>v", [[<cmd>:!zathura "%:r".pdf & disown<enter><enter>]], { noremap = true })
