-- vim.api.nvim_create_user_command("Doit", function(opts)
--   local arg = opts.args
--   if arg == "" then
--     print("Usage: Doit +/-N<command> (e.g. +3d)")
--     return
--   end
--
--   local cmd = ":" .. "." .. arg
--   vim.cmd("normal! m'") -- save cursor position to mark '
--   vim.cmd(cmd)
--   vim.cmd("normal! `'")
-- end, { nargs = 1 })
-- Lowercase "doit" fallback as Lua function for user convenience
-- _G.doit = function(arg)
--   vim.cmd("Doit " .. arg)
-- end
require("config.colors")

vim.api.nvim_create_user_command("AddProject", function(opts)
  local project_name = opts.fargs[1]
  local project_path = opts.fargs[2]
  if not project_name or not project_path then
    vim.notify("Usage: :AddProject <name> <directory>", vim.log.levels.ERROR)
    return
  end

  -- Expand tilde manually since jobstart doesn't use shell expansion
  project_path = project_path:gsub("^~", os.getenv("HOME"))

  local ok = vim.fn.executable("add_project.sh")
  if ok == 0 then
    vim.notify("add_project.sh not found in $PATH", vim.log.levels.ERROR)
    return
  end

  -- Run in background to avoid blocking
  vim.fn.jobstart({ "add_project.sh", project_name, project_path }, {
    detach = true,
    on_exit = function(_, code)
      if code ~= 0 then
        vim.notify("add_project.sh exited with code " .. code, vim.log.levels.WARN)
      end
    end,
  })
end, {
  nargs = "+",
  complete = "file",
  desc = "Add a new tmux project tab",
})
