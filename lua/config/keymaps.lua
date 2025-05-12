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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Line-specific fold opening (keep this!)
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = 0,
      callback = function()
        local line = vim.fn.line(".")
        if vim.fn.foldclosed(line) ~= -1 then
          vim.cmd("normal! zo")
        end
      end,
    })
  end,
})

-- ✅ Global fold toggle (put in config/keymaps.lua or shared location)
function ToggleAllFolds()
  local foldlevel = vim.wo.foldlevel
  if foldlevel == 0 then
    vim.cmd("normal! zR") -- open all folds
    vim.wo.foldlevel = 99
  else
    vim.cmd("normal! zM") -- close all folds
    vim.wo.foldlevel = 0
  end
end

vim.keymap.set("n", "<leader>Z", ToggleAllFolds, { desc = "Toggle all folds" })
vim.keymap.set("n", "<leader>z", "za", { desc = "Toggle fold under cursor" })
