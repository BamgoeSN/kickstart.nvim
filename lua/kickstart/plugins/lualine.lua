return {
  'nvim-lualine/lualine.nvim',
  -- event = { 'TextChanged', 'ModeChanged' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('kickstart.keylogger').setup()
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
        lualine_y = { 'progress', 'location' },
        lualine_z = {
          function()
            return require('kickstart.keylogger').str
          end,
        },
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
