return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.api.nvim_create_user_command('E', function()
      vim.cmd 'Oil'
    end, { desc = 'Open file [E]xplorer ' })
    require('oil').setup {
      view_options = {
        delete_to_trash = true,
        case_insensitive = true,
        sort = {
          { 'type', 'asc' },
          { 'name', 'asc' },
        },
      },
    }
  end,
}
