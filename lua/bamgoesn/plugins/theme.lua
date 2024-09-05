return {

  -- Onenord theme
  -- neo-tree explicitly depends on this colorscheme.
  -- Make sure to modify it whenever changing the colorscheme.
  {
    'rmehri01/onenord.nvim',
    priority = 1000,
    opts = {
      theme = 'dark',
    },
  },

  -- Transparent background
  {
    'xiyaowong/transparent.nvim',
    config = function()
      vim.cmd ':TransparentEnable'
    end,
  },
}
