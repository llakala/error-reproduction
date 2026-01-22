vim.g._ts_force_sync_parsing = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "nix" },
  group = vim.api.nvim_create_augroup("LoadTreesitter", {}),
  callback = function()
    vim.treesitter.start()
  end,
})

vim.cmd([[colorscheme tokyonight-night]])
