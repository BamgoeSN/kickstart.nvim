return {
  'xeluxee/competitest.nvim',
  event = 'BufEnter',
  dependencies = 'MunifTanjim/nui.nvim',
  config = function()
    require('competitest').setup {
      testcases_use_single_file = false,
      compile_command = {
        rust = { exec = 'cargo', args = { 'build', '--release' } },
      },
      run_command = {
        rust = { exec = 'cargo', args = { 'run', '--release', '--quiet' } },
      },
    }
  end,
}
