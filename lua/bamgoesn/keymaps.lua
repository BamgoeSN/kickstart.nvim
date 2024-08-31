--  See `:help vim.keymap.set()`

local utils = require('bamgoesn.utils')

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
vim.keymap.set({ 'n', 'v' }, '<leader>tsh', ':15sp | term <CR>', { desc = '[T]erminal [S]plit [H]orizontal' })
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

-- Config updater command
vim.api.nvim_create_user_command('UpdateConfig', utils.update_config, { desc = { 'Updates neovim config' } })
