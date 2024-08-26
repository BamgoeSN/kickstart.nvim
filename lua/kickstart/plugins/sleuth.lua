-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
return {
  'tpope/vim-sleuth',
  config = function()
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      desc = 'Set tabstop to 4',
      callback = function()
        vim.opt.tabstop = 4
      end,
    })
  end,
}
