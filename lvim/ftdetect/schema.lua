vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
  pattern = "*.schema",
  callback = function(_)
    vim.opt_local.filetype = "json"
  end
})
