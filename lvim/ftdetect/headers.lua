vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
  pattern = "*.h",
  callback = function(_)
    vim.opt_local.filetype = "c"
  end
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
  pattern = "*.hpp",
  callback = function(_)
    vim.opt_local.filetype = "cpp"
  end
})
