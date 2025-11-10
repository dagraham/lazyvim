-- ~/.config/nvim/lua/config/options.lua

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = false
if vim.g.neovide then
  vim.o.guifont = "MesloLGS Nerd Font:h12"
end
-- vim.opt.guifont = "MesloLGLDZ NF:h12"

-- Folding for Treesitter-enabled files
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
vim.o.foldenable = true
-- block in normal, 25% vertical bar in insert, thin horiz in replace
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
-- Start with all Snacks animations off (for other UI bits)
vim.g.snacks_animate = false
-- Start Mini Animate disabled globally
vim.g.minianimate_disable = true
