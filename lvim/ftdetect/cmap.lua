vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
  pattern = "*.cmap",
  callback = function(_)
    vim.opt_local.filetype = "c"
  end
})
