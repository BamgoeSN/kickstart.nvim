return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = {
    { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle Outline' },
  },
  opts = {
    outline_window = {
      auto_jump = true,
    }
  },
}
