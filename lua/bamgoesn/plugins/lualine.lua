return {
  'nvim-lualine/lualine.nvim',
  -- event = { 'TextChanged', 'ModeChanged' },
  dependencies = {
    'nvim-lua/plenary.nvim',

    -- Key viewer
    {
      'NStefan002/screenkey.nvim',
      opts = {
        clear_after = 999999999999999,
        disable = {
          buftypes = { 'terminal' },
        },
        show_leader = false,
        group_mappings = true,
      },
    },
  },
  config = function()
    vim.g.screenkey_statusline_component = true
    -- require('bamgoesn.keylogger').setup()
    require('lualine').setup {
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
        lualine_x = {
          function()
            return require('screenkey').get_keys()
            -- return require('bamgoesn.keylogger').str
          end,
        },
        lualine_y = { 'encoding', 'fileformat', 'filetype' },
        lualine_z = { 'progress', 'location' },
      },
      tabline = {
        lualine_b = {
          {
            'buffers',
            show_filename_only = false,
            mode = 2,
            buffers_color = {
              active = 'lualine_b_normal',
              inactive = 'lualine_c_inactive',
            },
            symbols = { alternate_file = '#' },
          },
        },
        lualine_y = { { 'datetime', style = '%Y/%m/%d %H:%M:%S' } },
      },
    }
  end,
}
