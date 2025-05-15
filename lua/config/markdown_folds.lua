-- lua/config/markdown_folds.lua
local M = {}

function M.foldexpr()
  local line = vim.fn.getline(vim.v.lnum)
  -- local prev_inside = vim.b._inside_codeblock or false

  -- -- Start or end of fenced block
  -- if line:match("^```") or line:match("^~~~") then
  --   vim.b._inside_codeblock = not prev_inside
  --   if not prev_inside then
  --     return ">9" -- start of code block: fold level 9
  --   else
  --     return 0 -- end of code block
  --   end
  -- end

  -- Indented code: don't fold
  if line:match("^    ") or line:match("^\t") then
    return "="
  end

  -- if vim.b._inside_codeblock then
  --  return "9" -- inside code block: same fold level
  -- end

  -- Markdown heading
  local hashes = line:match("^(#+)")
  if hashes then
    return ">" .. tostring(#hashes)
  end

  return "="
end

return M
