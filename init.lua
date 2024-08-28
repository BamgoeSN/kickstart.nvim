-- kickstart.nvim

-- [[ Utility funcitons ]]
local utils = require 'bamgoesn.utils'

-- [[ Options ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set tab size
-- See :h tabstop
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 2

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Buffers
-- vim.keymap.set({ 'n', 'v' }, '<leader>bn', '<cmd> bn <cr>', { desc = '[B]uffer [N]ext', silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<leader>bp', '<cmd> bp <cr>', { desc = '[B]uffer [P]revious', silent = true })
vim.keymap.set({ 'n', 'v' }, ']b', '<cmd> bn <cr>', { desc = 'Go to the next [B]uffer', silent = true })
vim.keymap.set({ 'n', 'v' }, '[b', '<cmd> bp <cr>', { desc = 'Go to the previous [B]uffer', silent = true })
for i = 1, 9 do
  vim.keymap.set({ 'n', 'v' }, '<leader>' .. i, function()
    local bufs = utils.list_loaded_bufs()
    local bufnr = bufs[i]
    if bufnr ~= nil then
      vim.api.nvim_set_current_buf(bufnr)
    end
  end, { desc = 'Go to the [B]uffer #' .. i })
end
vim.keymap.set({ 'n', 'v' }, '<leader>x', '<cmd> bdelete <cr>', { desc = 'Close current [B]uffer [X]' })

-- Center cursor after big vertical motions
vim.keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-f>', '<C-f>zz', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-b>', '<C-b>zz', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Copy all text
vim.keymap.set({ 'n', 'v' }, '<C-c>', '<cmd> %y+ <CR>', { silent = true })

-- Easy save
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', function()
  vim.cmd 'w'
end, { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set({ 'n', 'v' }, '<leader>tt', ':term <CR>', { desc = '[T]erminal mode' })
vim.keymap.set({ 'n', 'v' }, '<leader>tsv', ':vsp | term <CR>', { desc = '[T]erminal [S]plit [V]ertical' })
vim.keymap.set({ 'n', 'v' }, '<leader>tsh', ':sp | term <CR>', { desc = '[T]erminal [S]plit [H]orizontal' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>tsv', '<cmd>vsp<cr> <C-w><C-l> <cmd>terminal<cr>G', { desc = '[T]erminal [S]plit [V]ertical' })
-- vim.keymap.set({ 'n', 'v' }, '<leader>tsh', '<cmd>split<cr> <C-w><C-j> <cmd>terminal<cr> 10<C-w>-G', { desc = '[T]erminal [S]plit [H]orizontal' })

-- Competitest
vim.keymap.set('n', '<leader>tr', ':CompetiTest run <CR>', { desc = '[T]estcases [R]un' })
vim.keymap.set('n', '<leader>ta', ':CompetiTest add_testcase <CR>', { desc = '[T]estcases [A]dd' })
vim.keymap.set('n', '<leader>te', ':CompetiTest edit_testcase <CR>', { desc = '[T]estcases [E]dit' })
vim.keymap.set('n', '<leader>td', ':CompetiTest delete_testcase <CR>', { desc = '[T]estcases [D]elete' })
vim.keymap.set('n', '<leader>tg', ':CompetiTest receive testcases <CR>', { desc = '[T]estcases [G]et' })
vim.keymap.set('n', '<leader>tp', ':CompetiTest show_ui <CR>', { desc = '[T]estcases show [P]revious UI' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<leader>>', '10<C-w>>', { desc = 'Increase width by 10' })
vim.keymap.set('n', '<leader><', '10<C-w><', { desc = 'Decrease width by 10' })
vim.keymap.set('n', '<leader>+', '10<C-w>+', { desc = 'Increase height by 10' })
vim.keymap.set('n', '<leader>-', '10<C-w>-', { desc = 'Decrease height by 10' })
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Config updater command
vim.api.nvim_create_user_command('UpdateConfig', utils.update_config, { desc = { 'Updates neovim config' } })

-- Load plugins via lazy.vim
require 'bamgoesn.plugins'

-- [[ Neovide ]]
if vim.g.neovide then
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
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
