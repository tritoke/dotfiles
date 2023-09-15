vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
  pattern = "*.sage",
  callback = function(_)
    vim.opt_local.filetype = "python"
  end
})
