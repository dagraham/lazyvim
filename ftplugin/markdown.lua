vim.keymap.set({ "i", "s" }, "<C-l>", function()
  local ls = require("luasnip")
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true, buffer = true })
