-- kickstart.nvim

-- [[ Utility funcitons ]]
local utils = require 'bamgoesn.utils'

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'bamgoesn.opts'

-- [[ Basic Keymaps ]]
require 'bamgoesn.keymaps'

-- [[ Basic Autocommands ]]
require 'bamgoesn.autocommands'

-- Load plugins via lazy.vim
require 'bamgoesn.plugins'

-- [[ Neovide ]]
if vim.g.neovide then
  require 'bamgoesn.neovide'
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
