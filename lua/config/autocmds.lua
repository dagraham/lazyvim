-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Automatically close all folds when opening markdown files
    vim.cmd("normal! zM") -- Close all
  end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  pattern = "*.md",
  callback = function()
    if vim.fn.foldclosed(".") ~= -1 then
      vim.cmd("normal! zo")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.wo.foldmethod = "expr"
    vim.wo.foldenable = true
    vim.wo.foldlevel = 99
    vim.wo.foldexpr = "v:lua.require'config.markdown_folds'.foldexpr()"
  end,
})
