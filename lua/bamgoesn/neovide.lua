local utils = require 'bamgoesn.utils'

vim.cmd 'TransparentDisable'
Fsize = 12
vim.o.guifont = 'FiraCode Nerd Font:h' .. Fsize
vim.g.neovide_remember_window_size = true
vim.g.neovide_refresh_rate = 180
vim.g.neovide_scroll_animation_length = 0.05
vim.g.neovide_scroll_animation_far_lines = 99999999
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_trail_size = 0.5
vim.g.neovide_cursor_vfx_mode = 'torpedo'
vim.g.neovide_cursor_vfx_particle_density = 10.0

-- Smaller font size if on Windows or on WSL
if utils.is_on_windows() or utils.is_on_wsl() then
  -- vim.g.neovide_transparency = 0.85
  Fsize = 12
  vim.o.guifont = 'FiraCode Nerd Font:h' .. Fsize
end

-- Disable IME when not in insert mode
local function set_ime(args)
  if args.event:match 'Enter$' then
    vim.g.neovide_input_ime = true
  else
    vim.g.neovide_input_ime = false
  end
end

local ime_input = vim.api.nvim_create_augroup('ime_input', { clear = true })

vim.api.nvim_create_autocmd({ 'InsertEnter', 'InsertLeave' }, {
  group = ime_input,
  pattern = '*',
  callback = set_ime,
})

vim.api.nvim_create_autocmd({ 'CmdlineEnter', 'CmdlineLeave' }, {
  group = ime_input,
  pattern = '[/\\?]',
  callback = set_ime,
})
