local M = setmetatable({}, {
  __call = function (m, ...)
    return m.telescope(...)
  end
})

function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function ()
    builtin = params.builtin
    opts = params.opts or {}
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end

return M
