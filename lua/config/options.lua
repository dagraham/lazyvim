-- ~/.config/nvim/lua/config/options.lua

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.guifont = "MesloLGLDZ NF:h12"

-- Folding for Treesitter-enabled files
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
vim.o.foldenable = true
