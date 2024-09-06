return {
  'nosduco/remote-sshfs.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = function(_, _)
    local api = require 'remote-sshfs.api'
    return {
      { '<leader>rc', api.connect, desc = '[R]emote-SSHFS [C]onnect' },
      { '<leader>rd', api.disconnect, desc = '[R]emote-SSHFS [D]isconnect' },
      { '<leader>re', api.edit, desc = '[R]emote-SSHFS [E]dit' },
    }
  end,
  config = function()
    require('remote-sshfs').setup()

    require('telescope').load_extension 'remote-sshfs'
  end,
}
