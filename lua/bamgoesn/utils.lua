local M = {}

-- Returns a list of loaded buffers
M.list_loaded_bufs = function()
  local bufs = vim.api.nvim_list_bufs()
  local loaded = {}
  for _, bufnr in ipairs(bufs) do
    if vim.api.nvim_buf_get_option(bufnr, 'buflisted') then
      table.insert(loaded, bufnr)
    end
  end
  return loaded
end

-- Returns a function which picks a given index of buffer
M.get_buf_picker = function(index)
  local loaded = list_loaded_bufs()
  return function()
    local bufnr = loaded[index]
    if bufnr ~= nil then
      vim.api.nvim_set_current_buf(bufnr)
    end
  end
end

-- Returns true on plain Windows
-- Returns false on WSL or plain Linux
M.is_on_windows = function()
  return string.find(vim.loop.os_uname().sysname, 'Windows') ~= nil
end

-- Returns true on WSL
-- Returns false on plain Windows or Linux
M.is_on_wsl = function()
  return string.find(vim.loop.os_uname().release, 'microsoft') ~= nil
end

-- Automatically executes `git pull --rebase` on the config directory.
-- More accurately, it executes the command on the first directory of runtime paths.
M.update_config = function()
  local runtime_paths = vim.api.nvim_list_runtime_paths()
  local dir = runtime_paths[1]
  local git = vim.fn.expand(dir .. '/.git')
  if vim.fn.isdirectory(git) == 1 then
    local cmd = string.format('cd %s && git pull --rebase', vim.fn.shellescape(dir))
    print('Executing ' .. cmd)
    local output = vim.fn.system(cmd)
    print(output)
  end
end

return M
