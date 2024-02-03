-- kickstart.nvim

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Useful status updates for LSP
  {
    'j-hui/fidget.nvim',
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    }
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- LSP
  require 'bamgoe.plugins.lsp',

  -- Autocompletion
  require 'bamgoe.plugins.cmp',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },

  -- Gitsigns
  require('bamgoe.plugins.gitsigns'),

  {
    -- File tree
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "xiyaowong/transparent.nvim",
      'rmehri01/onenord.nvim',
    },
    config = function()
      -- Transparent background
      vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {}, { "NeoTreeNormal", "NeoTreeNormalNC" })
      -- Easier-to-see texts
      local onenord = require('onenord.colors.onenord')
      vim.api.nvim_set_hl(0, "NeoTreeFileStats", { fg = onenord.light_gray })
      vim.api.nvim_set_hl(0, "NeoTreeFileStatsHeader", { fg = onenord.light_green })
      vim.api.nvim_set_hl(0, "NeoTreeMessage", { fg = onenord.dark_blue })
      vim.api.nvim_set_hl(0, "NeoTreeDotfile", { fg = onenord.gray })

      -- Run setup here
      require('neo-tree').setup({
        window = {
          position = "current",
        },
        filesystem = {
          hijack_netrw_behavior = "open_current",
        },
      })

      vim.api.nvim_create_user_command('E', function()
        vim.cmd("Neotree")
      end, { desc = "Open file [E]xplorer " })

      -- Autocmds to run whenever neo-tree starts
      local neotree_exec = "NeotreeExec"
      vim.api.nvim_create_augroup(neotree_exec, { clear = true })
      -- Enable rnu in neo-tree
      vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
        group = neotree_exec,
        pattern = "*",
        callback = function()
          if vim.bo.filetype == "neo-tree" then
            vim.wo.relativenumber = true
          end
        end,
      })
    end,
  },

  {
    -- Undotree
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>ut", "<cmd>lua require('undotree').toggle()<cr>", desc = "[U]ndo[T]ree" },
    },
  },

  {
    -- Transparent background
    'xiyaowong/transparent.nvim',
    config = function()
      vim.cmd(':TransparentEnable')
    end
  },

  {
    -- Onenord theme
    -- neo-tree explicitly depends on this colorscheme.
    -- Make sure to modify it whenever changing the colorscheme.
    'rmehri01/onenord.nvim',
    priority = 1000,
    opts = {
      theme = "dark",
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    event = { 'TextChanged', 'ModeChanged' },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('bamgoe.keylogger').setup()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'onenord',
          component_separators = { left = '\\', right = '/' },
          section_separators = { left = '', right = '' },
          refresh = {
            statusline = 250,
          },
          globalstatus = true,
        },
        sections = {
          lualine_y = { 'progress', 'location' },
          lualine_z = { function()
            return require('bamgoe.keylogger').str
          end }
        },
        winbar = {
          lualine_b = { {
            'buffers',
            show_filename_only = false,
            mode = 2,
            buffers_color = {
              active = 'lualine_b_normal',
              inactive = 'lualine_c_inactive',
            },
            symbols = { alternate_file = '#' },
          } },
          lualine_z = { { 'datetime', style = '%Y/%m/%d %H:%M:%S' } },
        }
      })
    end,
  },

  {
    -- Indentation guides
    -- See `:help ibl`
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  require 'bamgoe.plugins.telescope',

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    -- Contextline
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
    opts = {
      max_lines = 4,
      min_window_lines = 15,
    },
  },

  -- DAP
  require 'bamgoe.plugins.debug',

  {
    -- Automatic bracket completion
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },

  {
    -- Surround selection with brackets
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "BufEnter",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    -- Contest companion
    "xeluxee/competitest.nvim",
    event = "BufEnter",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("competitest").setup {
        testcases_use_single_file = false,
        compile_command = {
          rust = { exec = "cargo", args = { "build", "--release" } },
        },
        run_command = {
          rust = { exec = "cargo", args = { "run", "--release", "--quiet" } },
        },
      }
    end,
  },
}, {})

-- [[ Utility funcitons ]]
-- Returns a list of loaded buffers
local function list_loaded_bufs()
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
local function get_buf_picker(index)
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
local function is_on_windows()
  return string.find(vim.loop.os_uname().sysname, 'Windows') ~= nil
end

-- Returns true on WSL
-- Returns false on plain Windows or Linux
local function is_on_wsl()
  return string.find(vim.loop.os_uname().release, 'microsoft') ~= nil
end

-- Automatically executes `git pull --rebase` on the config directory.
-- More accurately, it executes the command on the first directory of runtime paths.
local function update_config()
  local runtime_paths = vim.api.nvim_list_runtime_paths()
  local dir = runtime_paths[1]
  local git = vim.fn.expand(dir .. '/.git')
  if vim.fn.isdirectory(git) == 1 then
    local cmd = string.format('cd %s && git pull --rebase', vim.fn.shellescape(dir))
    print("Executing " .. cmd)
    local output = vim.fn.system(cmd)
    print(output)
  end
end
vim.api.nvim_create_user_command('UpdateConfig', update_config, { desc = { 'Updates neovim config' } })

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set tab size
-- See :h tabstop
vim.o.tabstop = 8
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- Turn tabline on by default
-- vim.o.showtabline = 2

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 150

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Use Powershell as a default shell on Windows
if is_on_windows() then
  vim.o.shell = 'pwsh'
  vim.o.shellcmdflag = '-command'
  vim.o.shellquote = '\"'
  vim.o.shellxquote = ''
end

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Buffers
-- vim.keymap.set({ 'n', 'v' }, '<leader>bn', '<cmd> bn <cr>', { desc = '[B]uffer [N]ext', silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<leader>bp', '<cmd> bp <cr>', { desc = '[B]uffer [P]revious', silent = true })
vim.keymap.set({ 'n', 'v' }, ']b', '<cmd> bn <cr>', { desc = 'Go to the next [B]uffer', silent = true })
vim.keymap.set({ 'n', 'v' }, '[b', '<cmd> bp <cr>', { desc = 'Go to the previous [B]uffer', silent = true })
for i = 1, 9 do
  vim.keymap.set({ 'n', 'v' }, '<leader>b' .. i, function()
    local bufs = list_loaded_bufs()
    local bufnr = bufs[i]
    if bufnr ~= nil then
      vim.api.nvim_set_current_buf(bufnr)
    end
  end, { desc = 'Go to the [B]uffer #' .. i })
end
vim.keymap.set({ 'n', 'v' }, '<leader>bx', '<cmd> bdelete <cr>', { desc = "Close current [B]uffer [X]" })

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
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', ':w<CR>', { silent = true })

-- Switch between windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Left window', silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Upper window', silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Lower window', silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Right window', silent = true })

-- Terminal
vim.keymap.set({ 'n', 'v' }, '<leader>tt', '<cmd>terminal<cr>', { desc = '[T]erminal mode' })
vim.keymap.set({ 'n', 'v' }, '<leader>tv', '<cmd>vsp<cr> <C-w><C-l> <cmd>terminal<cr>G',
  { desc = '[T]erminal as [V]ertical split' })
vim.keymap.set({ 'n', 'v' }, '<leader>th', '<cmd>split<cr> <C-w><C-j> <cmd>terminal<cr> 10<C-w>-G',
  { desc = '[T]erminal as [H]orizontal split' })
vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode', silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Competitest ]]
vim.keymap.set('n', '<leader>tr', ':CompetiTest run <CR>', { desc = '[T]estcases [R]un' })
vim.keymap.set('n', '<leader>ta', ':CompetiTest add_testcase <CR>', { desc = '[T]estcases [A]dd' })
vim.keymap.set('n', '<leader>te', ':CompetiTest edit_testcase <CR>', { desc = '[T]estcases [E]dit' })
vim.keymap.set('n', '<leader>td', ':CompetiTest delete_testcase <CR>', { desc = '[T]estcases [D]elete' })
vim.keymap.set('n', '<leader>tg', ':CompetiTest receive testcases <CR>', { desc = '[T]estcases [G]et' })
vim.keymap.set('n', '<leader>ts', ':CompetiTest show_ui <CR>', { desc = '[T]estcases [S]how previous UI' })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Treesitter ]]
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'markdown' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<cm-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']a'] = '@parameter.outer',
          [']f'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']A'] = '@parameter.outer',
          [']F'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[a'] = '@parameter.outer',
          ['[f'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[A'] = '@parameter.outer',
          ['[F'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- Neovide configuration
if vim.g.neovide then
  vim.cmd('TransparentDisable')
  vim.o.guifont = "FiraCode Nerd Font:h11"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_refresh_rate = 180
  vim.g.neovide_scroll_animation_length = 0.05
  vim.g.neovide_scroll_animation_far_lines = 99999999
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_cursor_vfx_mode = "torpedo"
  vim.g.neovide_cursor_vfx_particle_density = 10.0

  -- Apply transparency only when it's not on Windows
  if not is_on_windows() and not is_on_wsl() then
    vim.g.neovide_transparency = 0.85
  end

  -- Disable IME when not in insert mode
  local function set_ime(args)
    if args.event:match("Enter$") then
      vim.g.neovide_input_ime = true
    else
      vim.g.neovide_input_ime = false
    end
  end

  local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime
  })

  vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime
  })
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
