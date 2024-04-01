M = {}

-- Convert keystroke argument into a prettier form to print
-- <M-x> are registered as if its coming after Esc without Alt, so <M-x> is fundamentally indistinguishable from <Esc>x only from key chars.
local convert = require('kickstart.keylogger.convert').convert

function M.setup(opt)
  local default_opt = {
    maxlog = 100,
    strmax = function()
      return vim.o.columns / 7
    end,
  }

  if opt ~= nil then
    for k, v in pairs(default_opt) do
      if default_opt[k] ~= nil then
        default_opt[k] = v
      end
    end
  end

  local Deque = require('plenary.async.structs').Deque
  M.keylog = Deque.new()
  M.maxlog = default_opt.maxlog
  M.strmax = default_opt.strmax
  M.str = ""

  vim.on_key(function(key)
    local display = convert(key)
    if display ~= nil and display:len() >= 1 and vim.fn.mode() ~= "t" then
      M.keylog:pushright(display)
    end

    while M.keylog:len() > M.maxlog do
      M.keylog:popleft()
    end

    local aimlen = M.strmax()
    M.str = ""
    for _, v in M.keylog:ipairs_left() do
      M.str = M.str .. " " .. v
    end
    while M.str:len() < aimlen do
      M.str = M.str .. " "
    end
    M.str = M.str:sub(M.str:len() + 1 - aimlen, M.str:len())
    M.str = M.str:gsub("%%", "%%%%")
  end)
end

return M
