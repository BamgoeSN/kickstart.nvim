-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({
  -- Detect tabstop and shiftwidth automatically
  require 'bamgoesn.plugins.sleuth',

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  require 'bamgoesn.plugins.gitsigns',

  -- Useful plugin to show you pending keybinds.
  require 'bamgoesn.plugins.which-key',

  -- Fuzzy Finder (files, lsp, etc)
  require 'bamgoesn.plugins.telescope',

  -- Neovim lua LSP
  require 'bamgoesn.plugins.nvim-lua-lsp',
  -- LSP configuration
  require 'bamgoesn.plugins.lspconfig',

  -- Autoformat with conform.nvim
  require 'bamgoesn.plugins.conform',

  -- Autocompletion
  require 'bamgoesn.plugins.nvim-cmp',

  -- Theme
  require 'bamgoesn.plugins.theme',

  -- File tree with oil.nvim
  require 'bamgoesn.plugins.oil',

  -- Undotree
  require 'bamgoesn.plugins.undo-tree',

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    -- Display colors of color codes
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  -- Collection of various small independent plugins/modules
  -- Better text objects and surrounding functionality
  require 'bamgoesn.plugins.mini',

  -- Autopairs
  require 'bamgoesn.plugins.autopairs',

  -- Statusline with lualine.nvim
  require 'bamgoesn.plugins.lualine',

  -- Highlight, edit, and navigate code
  require 'bamgoesn.plugins.treesitter',

  -- Adds gitsigns recommend keymaps
  require 'bamgoesn.plugins.gitsigns',

  -- Debug adapter
  require 'bamgoesn.plugins.nvim-dap',

  -- Indent line
  require 'bamgoesn.plugins.indent_blankline',

  -- Outline of the code file
  require 'bamgoesn.plugins.outline',

  -- Asynchronous lint
  require 'bamgoesn.plugins.nvim-lint',

  -- Contest companion
  require 'bamgoesn.plugins.competitest',

  -- Typst preview
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '0.3.*',
    build = function()
      require('typst-preview').update()
    end,
  },

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
