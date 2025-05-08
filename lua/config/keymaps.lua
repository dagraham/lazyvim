-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<C-e>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true, desc = "Expand or jump in snippet" })

vim.keymap.set({ "i", "s" }, "<C-n>", function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end, { silent = true, desc = "Jump forward in snippet" })

vim.keymap.set({ "i", "s" }, "<C-p>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true, desc = "Jump backward in snippet" })

vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>", { desc = "Toggle Aerial outline" })
