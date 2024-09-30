vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
  pattern = "*.template",
  callback = function(_)
    vim.opt_local.filetype = "jinja"
  end
})
